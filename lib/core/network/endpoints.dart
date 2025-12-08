class ApiEndpoints {
  ApiEndpoints._();

  // Base URL
  static const String baseUrl =
      'https://pento-api.wonderfulrock-2a6b94b0.koreacentral.azurecontainerapps.io';

  static const String baseUrlNest = 'https://pento-service.onrender.com/api/v1';

  static const String baseUrlLocal = 'http://10.0.2.2:8000/api/v1';

  // Nest API
  static const String imageSearch = '$baseUrlNest/image-search';
  static const String scanImage = '$baseUrlNest/scan-food';
  static const String scanBillImage = '$baseUrlNest/scan-food/bill';
  static const String chatbot = '$baseUrlNest/chatbot/chat';
  static const String placeNearBy = '$baseUrlNest/places/nearby';

  // Authentication
  static const String signIn = '/auth/mobile-sign-in';
  static const String signUp = '/auth/register';
  static const String refreshToken = '/auth/mobile-refresh';
  static const String logout = '/auth/sign-out';

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
  static const String getFoodItems = '/food-items';
  static const String createFood = '/food-items';
  static const String createFoodBulk = '/food-items/bulk';
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
  static const String getWishlist = '/recipes/wishlist';
  static const String addToWishlist = '/recipes/{recipeId}/add-to-wishlist';
  static const String removeFromWishlist = '/recipes/{recipeId}/wishlist';


  //Activity Log
  static const String getSummaryFoodItemLogs = '/food-item-logs/summary';
  static const String getFoodItemLogs = '/food-item-logs';

  //Grocery List
  static const String getGroceryList = '/grocery-lists/current-house';
  static const String getGroceryListItem = '/grocery-list-items';
  static const String createGroceryList = '/grocery-lists';
  static const String updateGroceryList = '/grocery-lists/{id}';
  static const String deleteGroceryList = '/grocery-lists/{id}';

  //Grocery List Item
  static const String createGroceryListItem = '/grocery-list-items';
  static const String updateGroceryListItem = '/grocery-list-items/{id}';
  static const String deleteGroceryListItem = '/grocery-list-items/{id}';
  static const String createGroceryListItemBulk = '/grocery-lists/detail';

  //Meal Plan
  static const String getMealPlan = '/meal-plans';
  static const String createMealPlan = '/meal-plans';
  static const String fulfillMealPlan = '/meal-plans/{mealPlanId}/fulfill';
  static const String cancelMealPlan = '/meal-plans/{mealPlanId}/cancel';

  //Reservation
  static const String createMealReservation = '/meal-plan-reservations';
  static const String createRecipeReservation = '/meal-plans/from-recipe';
  static const String confirmRecipeReservation = '/meal-plans/from-recipe/confirm';
  static const String getMealReservations = '/meal-plan-reservations';

  static const String fulfillRecipeReservation = '/meal-plans/{mealPlanId}/recipes/{recipeId}/fulfill';
  static const String cancelRecipeReservation = '/meal-plans/{mealPlanId}/recipes/{recipeId}/cancel';

  static const String fulfillFoodItemReservation = '/mealplan-reservations/{id}/fulfill';
  static const String cancelFoodItemReservation = '/mealplan-reservations/{id}/cancel';

  //Subscription
  static const String getSubscription = '/subscriptions';
  static const String getUserSubscriptionById ='/users/subscriptions/{subscriptionId}';

  //Payment
  static const String getPayment = '/payments/{paymentId}';
  static const String createPayment = '/payments';
  static const String getPayments = '/payments';

  //Notifications
  static const String registerNotificationToken = '/notifications/register-token';

  //Achievement
  static const String getAchievement = '/users/milestones';
  static const String getAchievementById = '/users/milestones/{milestoneId}';

  //Trade 
  static const String getTradeOffers = '/trade-posts';
  static const String createTradeOffer = '/trade-offers/items';
  static const String createTradeRequestItem = '/trade-requests/items';
  static const String getMyPosts = '/trades/posts/me';
  static const String getPostById = '/trade-requests/offer/{offerId}';

  

}
