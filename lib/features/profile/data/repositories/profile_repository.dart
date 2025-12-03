import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/profile_models.dart';
import 'package:dio/dio.dart';

class ProfileRepository {
  final NetworkService _networkService = NetworkService.instance;

  /// Get user profile
  Future<UserProfile> getProfile() async {
    final response = await _networkService.get(
      ApiEndpoints.profile,
      onSuccess: (data) => UserProfile.fromJson(data),
    );

    return response;
  }

  /// Get user subscription detail by id
  Future<Map<String, dynamic>> getUserSubscriptionById(
    String userSubscriptionId,
  ) async {
    final path = ApiEndpoints.getUserSubscriptionById.replaceFirst(
      '{subscriptionId}',
      userSubscriptionId,
    );

    final response = await _networkService.get<Map<String, dynamic>>(
      path,
      onSuccess: (data) => data as Map<String, dynamic>,
    );

    return response;
  }

  /// Update user profile
  Future<UserProfile> updateProfile(UpdateProfileRequest request) async {
    // Update API returns 204 No Content on success
    final response = await _networkService.put(
      ApiEndpoints.updateProfile,
      data: request.toJson(),
      onSuccess: (data) {
        // If 204, data will be null - fetch the updated profile
        if (data == null) {
          return null; // Signal that we need to fetch
        }
        return UserProfile.fromJson(data);
      },
    );

    // If update returned 204 (No Content), fetch the updated profile
    if (response == null) {
      // Fetch the updated profile after successful update
      return await getProfile();
    }

    return response;
  }

  /// Upload avatar image using PUT multipart/form-data
  Future<UserProfile> uploadAvatar(String filePath) async {
    final fileName = filePath.split('/').last.split('\\').last;
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        filePath,
        filename: fileName,
      ),
    });


    await _networkService.put<UserProfile?>(
      ApiEndpoints.uploadAvatar,
      data: formData,
      onSuccess: (data) {
        return null;
      },
    );

    // Fetch the updated profile after successful avatar upload
    return await getProfile();
  }
}

