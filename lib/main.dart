import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logging/logging.dart';
import 'package:toastification/toastification.dart';
import 'core/routing/app_router.dart';
import 'core/constants/app_colors.dart';
import 'core/network/api_client.dart';
import 'core/services/secure_storage_service.dart';
import 'core/utils/logging.dart';
import 'features/authentication/presentation/providers/user_session_provider.dart';
import 'features/profile/presentation/providers/profile_initializer_provider.dart';

ProviderContainer? _globalContainer;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  AppLogger.initialize(level: Level.ALL);
  
  SecureStorageService.instance.initialize();
  
  final container = ProviderContainer();
  _globalContainer = container;
  
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
  );
  
  // Initialize router with container
  appRouter = createAppRouter(container);
  
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
