import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logging/logging.dart';
import 'core/routing/app_router.dart';
import 'core/constants/app_colors.dart';
import 'core/network/api_client.dart';
import 'core/services/secure_storage_service.dart';
import 'core/utils/logging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configure logging
  AppLogger.initialize(level: Level.ALL); // Use Level.WARNING in production
  
  // Initialize services
  SecureStorageService.instance.initialize();
  ApiClient.instance.initialize();
  
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X design size
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
        );
      },
    );
  }
}
