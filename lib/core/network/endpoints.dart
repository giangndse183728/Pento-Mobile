class ApiEndpoints {
  ApiEndpoints._();

  // Base URL
  static const String baseUrl =
      'https://pento-api.wonderfulrock-2a6b94b0.koreacentral.azurecontainerapps.io';

  static const String baseUrlLocal = 'http://10.0.2.2:3000/api';

  // Image Search (local API)
  static const String imageSearch = '/image-search';

  // Authentication
  static const String signIn = '/users/mobile-sign-in';
  static const String signUp = '/users/register';
  static const String refreshToken = '/users/mobile-refresh';
  static const String logout = '/users/sign-out';

  // User
  static const String profile = '/users/profile';
  static const String updateProfile = '/users/profile';
  static const String verifyEmail = '/users/send-verification-email';
  static const String uploadAvatar = '/users/avatar';

  // Household
  static const String createHousehold = '/households';
  static const String joinHousehold = '/households/join';
  static const String getHousehold = '/households/current';

  // Storage
  static const String getStorage = '/storages';
  static const String getStorageById = '/storages/{storageId}';
  static const String createStorage = '/storages';
  static const String updateStorage = '/storages/{storageId}';
  static const String deleteStorage = '/storages/{storageId}';
  static const String getStorageCompartments = '/storages/{storageId}/compartments';
  static const String createStorageCompartment = '/storages/{storageId}/compartments';

  //Compartment
  static const String getCompartment = '/compartments/{compartmentId}';
  static const String updateCompartment = '/compartments/{compartmentId}';
  static const String deleteCompartment = '/compartments/{compartmentId}';
  static const String getCompartmentItems = '/compartments/{compartmentId}';

  //Food
  static const String createFood = '/food-items';
  static const String getDetailFoodItem = '/food-items/{id}';
  static const String updateFoodItem = '/food-items/{foodItemId}';
  static const String discardFoodItem = '/food-items/{foodItemId}/discard';
  static const String consumeFoodItem = '/food-items/{foodItemId}/consumption';
  static const String updateFoodItemImage = '/food-items/{id}/image';
  
  //Food Reference
  static const String getFoodReference = '/food-references';
  static const String getFoodReferenceBarcode = '/food-references/{barcode}';

  //Unit
  static const String getUnit = '/units';

  //Recipe
  static const String getRecipe = '/recipes';
  static const String getRecipeById = '/recipes/{recipeId}';

  //Activity Log
  static const String getSummaryFoodItemLogs = '/food-item-logs/summary';
  static const String getFoodItemLogs = '/food-item-logs';

  //Grocery List
  static const String getGroceryList = '/grocery-lists/current-house';
  static const String createGroceryList = '/grocery-lists';
  static const String updateGroceryList = '/grocery-lists/{id}';
  static const String deleteGroceryList = '/grocery-lists/{id}';

  //Grocery List Item
  static const String getGroceryListItem = '/grocery-list-items/{id}';
  static const String createGroceryListItem = '/grocery-list-items';
  static const String updateGroceryListItem = '/grocery-list-items/{id}';
  static const String deleteGroceryListItem = '/grocery-list-items/{id}';

  //Meal Plan
  static const String getMealPlan = '/meal-plans/current-house';
  static const String createMealPlan = '/meal-plans';
}
