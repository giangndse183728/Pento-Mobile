import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';
import '../layouts/main_layout.dart';
import '../layouts/bottom_nav_items.dart';
import '../../features/pantry/presentation/screen/pantry_screen.dart';
import '../../screens/meal_screen.dart';
import '../../screens/posts_screen.dart';
import '../../features/pantry/presentation/screen/barcode_scanner_screen.dart';
import '../../features/authentication/presentation/screen/auth_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/household/presentation/screen/household_screen.dart';
import '../../features/household/presentation/screen/join_household_screen.dart';
import '../../features/household/presentation/screen/create_household_screen.dart';
import '../../features/household/presentation/screen/household_detail_screen.dart';
import '../../features/profile/presentation/screen/profile_screen.dart';
import '../../features/compartment/presentation/screen/compartment_screen.dart';
import '../../features/compartment/presentation/screen/add_food_screen.dart';
import '../../features/compartment/presentation/screen/food_item_detail_screen.dart';
import '../../features/recipe/presentation/screen/recipe_screen.dart';
import '../../features/recipe/presentation/screen/recipe_detail_screen.dart';
import '../../features/authentication/presentation/providers/user_session_provider.dart';
import '../../features/profile/presentation/providers/profile_initializer_provider.dart';
import '../services/secure_storage_service.dart';
import '../services/token_provider.dart';
import '../utils/jwt_utils.dart';
import 'app_routes.dart';

GoRouter createAppRouter(ProviderContainer container) {
  return GoRouter(
    initialLocation: AppRoutes.onboarding,
    redirect: (context, state) async {
      final storage = SecureStorageService.instance;
      final currentLocation = state.matchedLocation;

      // If accessing onboarding, allow it
      if (currentLocation == AppRoutes.onboarding) {
        return null; // No redirect needed
      }

      // If accessing auth route, check if user already has valid refresh token
      if (currentLocation == AppRoutes.auth) {
        final refreshToken = await storage.getRefreshToken();
        if (refreshToken != null &&
            refreshToken.isNotEmpty &&
            !JwtUtils.isTokenExpired(refreshToken)) {
          // Valid refresh token exists, ensure it's in TokenProvider and fetch profile
          final tokenProvider = TokenProvider.instance;
          if (tokenProvider.refreshToken == null) {
            tokenProvider.setTokens(refreshToken: refreshToken);
          }
          // Trigger profile fetch to get name, email, avatarUrl
          final userSession = container.read(userSessionNotifierProvider);
          if (userSession == null || userSession.name == null) {
            try {
              container.read(profileInitializerProvider.notifier).refresh();
            } catch (e) {
              // Silently fail - profile will be fetched later
            }
          }
          return AppRoutes.pantry;
        }
        // No valid refresh token, allow access to auth screen
        return null;
      }

      // For protected routes, check refresh token
      final refreshToken = await storage.getRefreshToken();

      if (refreshToken == null || refreshToken.isEmpty) {
        // No refresh token, redirect to auth
        return AppRoutes.auth;
      }

      // Check if refresh token is expired
      if (JwtUtils.isTokenExpired(refreshToken)) {
        // Refresh token expired, redirect to auth
        return AppRoutes.auth;
      }

      // Refresh token is valid, ensure it's in TokenProvider and fetch profile if needed
      final tokenProvider = TokenProvider.instance;
      if (tokenProvider.refreshToken == null) {
        tokenProvider.setTokens(refreshToken: refreshToken);
      }
      
      // Trigger profile fetch to get name, email, avatarUrl if session is empty or missing profile data
      final userSession = container.read(userSessionNotifierProvider);
      if (userSession == null || userSession.name == null) {
        try {
          container.read(profileInitializerProvider.notifier).refresh();
        } catch (e) {
          // Silently fail - profile will be fetched later
        }
      }
      
      // Check household route access based on householdId
      if (currentLocation == AppRoutes.household ||
          currentLocation == AppRoutes.joinHousehold ||
          currentLocation == AppRoutes.createHousehold) {
        // If householdId is not null, redirect away from household routes
        if (userSession?.householdId != null) {
          return AppRoutes.pantry;
        }
      }

      return null; // No redirect needed
    },
    routes: [
    GoRoute(
      path: AppRoutes.onboarding,
      pageBuilder: GoTransitions.fadeUpwards.build(
        builder: (context, state) {
          final storage = SecureStorageService.instance;
          return OnboardingScreen(
            onFinished: () async {
          
              final refreshToken = await storage.getRefreshToken();
              if (refreshToken != null &&
                  refreshToken.isNotEmpty &&
                  !JwtUtils.isTokenExpired(refreshToken)) {
             
                final tokenProvider = TokenProvider.instance;
                if (tokenProvider.refreshToken == null) {
                  tokenProvider.setTokens(refreshToken: refreshToken);
                }
          
                final userSession = container.read(userSessionNotifierProvider);
                if (userSession == null || userSession.name == null) {
                  try {
                    container.read(profileInitializerProvider.notifier).refresh();
                  } catch (e) {
                    // Silently fail - profile will be fetched later
                  }
                }
                if (context.mounted) {
                  context.go(AppRoutes.pantry);
                }
              } else {
                if (context.mounted) {
                  context.go(AppRoutes.auth);
                }
              }
            },
          );
        },
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
    GoRoute(
      path: AppRoutes.household,
      pageBuilder: GoTransitions.fadeUpwards.build(
        child: const HouseholdScreen(),
      ),
    ),
        GoRoute(
      path: AppRoutes.householdDetail,
      pageBuilder: GoTransitions.fadeUpwards.build(
        child: const HouseholdDetailScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.joinHousehold,
      pageBuilder: GoTransitions.fadeUpwards.build(
        child: const JoinHouseholdScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.createHousehold,
      pageBuilder: GoTransitions.fadeUpwards.build(
        child: const CreateHouseholdScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.profile,
      pageBuilder: GoTransitions.fadeUpwards.build(
        child: const ProfileScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.compartment,
      pageBuilder: GoTransitions.fadeUpwards.build(
        child: const CompartmentScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.addFood,
      pageBuilder: GoTransitions.fadeUpwards.build(
        child: const AddFoodScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.foodItemDetail,
      pageBuilder: GoTransitions.fadeUpwards.build(
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          final compartmentId = state.uri.queryParameters['compartmentId'];
          return FoodItemDetailScreen(
            foodItemId: id,
            compartmentId: compartmentId,
          );
        },
      ),
    ),
    GoRoute(
      path: AppRoutes.recipeDetail,
      pageBuilder: GoTransitions.fadeUpwards.build(
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return RecipeDetailScreen(
            recipeId: id,
          );
        },
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
          path: AppRoutes.recipe,
          builder: (context, state) => const RecipeScreen(),
        ),
      ],
    ),

  
    ],
  );
}

// Create router instance - will be initialized in main.dart
late final GoRouter appRouter;
