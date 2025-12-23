import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logging/logging.dart';
import 'package:toastification/toastification.dart';
import 'package:go_router/go_router.dart';
import 'core/routing/app_router.dart';
import 'core/routing/app_routes.dart';
import 'core/constants/app_colors.dart';
import 'core/network/api_client.dart';
import 'core/services/secure_storage_service.dart';
import 'core/services/notification_service.dart';
import 'core/utils/logging.dart';
import 'features/authentication/presentation/providers/user_session_provider.dart';
import 'features/profile/presentation/providers/profile_initializer_provider.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

   FirebaseMessaging.onBackgroundMessage(
    firebaseMessagingBackgroundHandler,
  );

  final messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  AppLogger.initialize(level: Level.ALL);
  
  SecureStorageService.instance.initialize();
  await NotificationService.instance.initialize();
  
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    final notification = message.notification;
    final title = notification?.title ?? 'Pento';
    final body = notification?.body ?? 'You have a new notification';

    await NotificationService.instance.showNotification(
      id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title: title,
      body: body,
    );
  });

  

runApp(
  Phoenix(
    child: ProviderScope(
      key: UniqueKey(), 
      child: MyApp(),
    ),
  ),
);

}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late final GoRouter _router;
  bool _apiClientInitialized = false;

  @override
  void initState() {
    super.initState();
    _router = createAppRouter();
  }

  void _initializeApiClient() {
    if (_apiClientInitialized) {
      _updateApiClientCallbacks();
      return;
    }
    _apiClientInitialized = true;
    
    ApiClient.instance.initialize(
      onTokenRefreshed: (String newAccessToken) async {
        _handleTokenRefreshed(newAccessToken);
      },
      onRefreshTokenFailed: () async {
        _router.go(AppRoutes.auth);
      },
    );
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialProfile();
    });
  }

  void _updateApiClientCallbacks() {
    ApiClient.instance.updateCallbacks(
      onTokenRefreshed: (String newAccessToken) async {
        _handleTokenRefreshed(newAccessToken);
      },
      onRefreshTokenFailed: () async {
        _router.go(AppRoutes.auth);
      },
    );
  }

  void _handleTokenRefreshed(String newAccessToken) {
    try {
      ref.read(userSessionNotifierProvider.notifier).updateAccessToken(newAccessToken);
    } catch (e) {
      // Handle error silently
    }
  }

  void _loadInitialProfile() {
    try {
      final userSession = ref.read(userSessionNotifierProvider);
      if (userSession?.accessToken != null) {
        ref.read(profileInitializerProvider);
      }
    } catch (e) {
      // Handle error silently
    }
  }

  @override
  Widget build(BuildContext context) {
    _initializeApiClient();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Pento',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blueGray),
            scaffoldBackgroundColor: AppColors.iceberg,
            useMaterial3: true,
            appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
          builder: (context, child) {
            return ToastificationWrapper(
              child: child ?? const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}
