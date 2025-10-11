import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';
import '../layouts/main_layout.dart';
import '../layouts/bottom_nav_items.dart';
import '../../features/pantry/presentation/pantry_screen.dart';
import '../../screens/meal_screen.dart';
import '../../screens/posts_screen.dart';
import '../../screens/cart_screen.dart';
import '../../features/pantry/presentation/barcode_scanner_screen.dart';
import '../../features/authentication/presentation/screen/auth_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.onboarding,
  routes: [
    GoRoute(
      path: AppRoutes.onboarding,
      pageBuilder: GoTransitions.fadeUpwards.build(
        builder: (context, state) => OnboardingScreen(
          onFinished: () => context.go(AppRoutes.auth),
        ),
      ),
    ),
    GoRoute(
      path: AppRoutes.auth,
      pageBuilder: GoTransitions.fadeUpwards.build(
        child: const AuthScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.barcode,
      pageBuilder: GoTransitions.fadeUpwards.build(
        child: const BarcodeScannerScreen(),
      ),
    ),

    
ShellRoute(
      builder: (context, state, child) {
        return MainLayout(
          items: kDefaultNavItems,
          pages: [child], 
        );
      },
      routes: [
        GoRoute(
          path: AppRoutes.pantry,
          builder: (context, state) => const PantryScreen(),
        ),
        GoRoute(
          path: AppRoutes.meal,
          builder: (context, state) => const MealScreen(),
        ),
        GoRoute(
          path: AppRoutes.posts,
          builder: (context, state) => const PostsScreen(),
        ),
        GoRoute(
          path: AppRoutes.cart,
          builder: (context, state) => const CartScreen(),
        ),
      ],
    ),

  
  ],
);


