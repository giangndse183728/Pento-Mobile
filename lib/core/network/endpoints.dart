class ApiEndpoints {
  ApiEndpoints._();

  // Base URL
  static const String baseUrl =
      'https://pento-api.jollyground-f3462e5a.southeastasia.azurecontainerapps.io';

  // Authentication
  static const String signIn = '/users/sign-in';
  static const String signUp = '/users/sign-up';
  static const String refreshToken = '/users/refresh-token';
  static const String logout = '/users/logout';

  // User
  static const String profile = '/users/profile';
  static const String updateProfile = '/users/profile';

  // Add other endpoints as needed
}

