class AppRoutes {
  const AppRoutes._();

  static const String main = '/main';
  static const String pantry = '/pantry';
  static const String meal = '/meal';
  static const String posts = '/posts';
  static const String cart = '/cart';
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
  static const String foodItemDetail = '/compartment/food-item/:id';
  
  // Helper method to build food item detail route
  static String foodItemDetailRoute(String id) =>
      '/compartment/food-item/$id';
}
