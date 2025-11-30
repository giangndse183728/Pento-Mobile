import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';
import '../layouts/main_layout.dart';
import '../layouts/bottom_nav_items.dart';
import '../../features/pantry/presentation/screen/pantry_screen.dart';
import '../../features/plan/presentation/screen/meal_plan_screen.dart';
import '../../screens/posts_screen.dart';
import '../../features/authentication/presentation/screen/auth_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/household/presentation/screen/household_screen.dart';
import '../../features/household/presentation/screen/join_household_screen.dart';
import '../../features/household/presentation/screen/create_household_screen.dart';
import '../../features/household/presentation/screen/household_detail_screen.dart';
import '../../features/profile/presentation/screen/profile_screen.dart';
import '../../features/compartment/presentation/screen/compartment_screen.dart';
import '../../features/compartment/presentation/screen/add_food_screen.dart';
import '../../features/compartment/presentation/screen/barcode_scanner_screen.dart';
import '../../features/compartment/presentation/screen/food_item_detail_screen.dart';
import '../../features/recipe/presentation/screen/recipe_screen.dart';
import '../../features/recipe/presentation/screen/recipe_detail_screen.dart';
import '../../features/log/presentation/screen/food_item_logs_screen.dart';
import '../../features/grocery/presentation/screen/grocery_screen.dart';
import '../../features/chatbot/presentation/screen/chatbot_screen.dart';
import '../../features/subscription/presentation/screen/subscription_screen.dart';
import '../../features/subscription/presentation/screen/payment_qr_screen.dart';
import '../../features/food_scan/presentation/screen/food_scan_screen.dart';
import '../../features/food_scan/presentation/screen/food_scan_results_screen.dart';
import '../../features/food_scan/data/models/scanned_food_reference.dart';
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

      if (currentLocation == AppRoutes.onboarding) {
        return null;
      }

      if (currentLocation == AppRoutes.auth) {
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
          return AppRoutes.pantry;
        }
        return null;
      }

      final refreshToken = await storage.getRefreshToken();

      if (refreshToken == null || refreshToken.isEmpty) {
        return AppRoutes.auth;
      }

      if (JwtUtils.isTokenExpired(refreshToken)) {
        return AppRoutes.auth;
      }

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
      
      if (currentLocation == AppRoutes.household ||
          currentLocation == AppRoutes.joinHousehold ||
          currentLocation == AppRoutes.createHousehold) {
        if (userSession?.householdId != null) {
          return AppRoutes.pantry;
        }
      }

      return null;
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
      path: AppRoutes.barcodeScanner,
      pageBuilder: GoTransitions.fadeUpwards.build(
        child: const BarcodeScannerScreen(),
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
    GoRoute(
      path: AppRoutes.foodItemLogs,
      pageBuilder: GoTransitions.fadeUpwards.build(
child: const FoodItemLogsScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.grocery,
      pageBuilder: GoTransitions.fadeUpwards.build(
        child: const GroceryScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.chatbot,
      pageBuilder: GoTransitions.fadeUpwards.build(
        child: const ChatbotScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.subscription,
      pageBuilder: GoTransitions.fadeUpwards.build(
        child: const SubscriptionScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.paymentQr,
      pageBuilder: GoTransitions.fadeUpwards.build(
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return PaymentQrScreen(
            qrCode: extra?['qrCode'] ?? '',
            paymentId: extra?['paymentId'] ?? '',
            planName: extra?['planName'],
            price: extra?['price'],
          );
        },
      ),
    ),
    GoRoute(
      path: AppRoutes.foodScanCamera,
      pageBuilder: GoTransitions.fadeUpwards.build(
        builder: (context, state) {
          final compartmentId =
              state.uri.queryParameters['compartmentId'] ?? '';
          return FoodScanScreen(
            compartmentId: compartmentId,
            scanType: ScanType.food,
          );
        },
      ),
    ),
    GoRoute(
      path: AppRoutes.foodScanBill,
      pageBuilder: GoTransitions.fadeUpwards.build(
        builder: (context, state) {
          final compartmentId =
              state.uri.queryParameters['compartmentId'] ?? '';
          return FoodScanScreen(
            compartmentId: compartmentId,
            scanType: ScanType.bill,
          );
        },
      ),
    ),
    GoRoute(
      path: AppRoutes.foodScanResults,
      pageBuilder: GoTransitions.fadeUpwards.build(
        builder: (context, state) {
          final compartmentId =
              state.uri.queryParameters['compartmentId'] ?? '';
          final scanResponse = state.extra as ScanFoodResponse?;
          return FoodScanResultsScreen(
            compartmentId: compartmentId,
            scanResponse: scanResponse,
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
          builder: (context, state) => const MealPlanScreen(),
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
