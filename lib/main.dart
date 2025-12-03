import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logging/logging.dart';
import 'package:toastification/toastification.dart';
import 'core/routing/app_router.dart';
import 'core/routing/app_routes.dart';
import 'core/constants/app_colors.dart';
import 'core/network/api_client.dart';
import 'core/services/secure_storage_service.dart';
import 'core/services/notification_service.dart';
import 'core/utils/logging.dart';
import 'features/authentication/presentation/providers/user_session_provider.dart';
import 'features/profile/presentation/providers/profile_initializer_provider.dart';

ProviderContainer? _globalContainer;

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // TODO: handle background message (logging, navigation, etc.)
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
  
  final container = ProviderContainer();
  _globalContainer = container;
  
  // Initialize router with container first
  appRouter = createAppRouter(container);
  
  ApiClient.instance.initialize(
    onTokenRefreshed: (String newAccessToken) async {
      if (_globalContainer != null) {
        try {
          _globalContainer!.read(userSessionNotifierProvider.notifier).updateAccessToken(newAccessToken);
        } catch (e) {
          // Handle error silently 
        }
      }
    },
    onRefreshTokenFailed: () async {
      // Navigate to auth screen when refresh token fails
      appRouter.go(AppRoutes.auth);
    },
  );
  
  // Fetch user profile on app startup if user is logged in
  try {
    final userSession = container.read(userSessionNotifierProvider);
    if (userSession?.accessToken != null) {
      // Trigger profile fetch
      container.read(profileInitializerProvider);
    }
  } catch (e) {
    // Handle error silently
  }
  
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
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
          routerConfig: appRouter,
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
