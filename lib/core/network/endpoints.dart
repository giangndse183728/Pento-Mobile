class ApiEndpoints {
  ApiEndpoints._();

  // Base URL
  static const String baseUrl =
      'https://pento-api.wonderfulrock-2a6b94b0.koreacentral.azurecontainerapps.io';

  // Authentication
  static const String signIn = '/users/mobile-sign-in';
  static const String signUp = '/users/register';
  static const String refreshToken = '/users/mobile-refresh';
  static const String logout = '/users/logout';

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
  
  //Food Reference
  static const String getFoodReference = '/food-references';

  //Unit
  static const String getUnit = '/units';

}

