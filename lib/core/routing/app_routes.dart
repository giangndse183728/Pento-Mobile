class AppRoutes {
  const AppRoutes._();

  static const String main = '/main';
  static const String pantry = '/pantry';
  static const String meal = '/meal';
  static const String posts = '/posts';
  static const String cart = '/cart';
  static const String recipe = '/recipe';
  static const String barcode = '/barcode';
  static const String onboarding = '/onboarding';
  static const String auth = '/auth';
  static const String household = '/household';
  static const String joinHousehold = '/household/join';
  static const String createHousehold = '/household/create';
  static const String householdDetail = '/household/detail';
  static const String bill = '/bill';
  static const String foodscan = '/foodscan';
  static const String inputform = '/inputform';
  static const String profile = '/profile';
  static const String compartment = '/compartment';
  static const String addFood = '/compartment/add-food';
  static const String barcodeScanner = '/compartment/barcode-scanner';
  static const String foodItemDetail = '/compartment/food-item/:id';
  static const String recipeDetail = '/recipe/:id';
  static const String foodItemLogs = '/food-item-logs';
  static const String grocery = '/grocery';
  static const String chatbot = '/chatbot';
  static const String subscription = '/subscription';
  static const String paymentQr = '/payment-qr';
  static const String paymentHistory = '/payment-history';
  static const String foodScanCamera = '/compartment/food-scan-camera';
  static const String foodScanBill = '/compartment/food-scan-bill';
  static const String foodScanResults = '/compartment/food-scan-results';
  static const String foodItems = '/food-items';
  
  static String foodItemDetailRoute(String id) =>
      '/compartment/food-item/$id';

  static String recipeDetailRoute(String id) => '/recipe/$id';
  
}
