import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/household_models.dart';

class HouseholdRepository {
  final NetworkService _networkService = NetworkService.instance;

  /// Create a new household
  /// Returns only the invite code from the API
  Future<CreateHouseholdResponse> createHousehold(
    CreateHouseholdRequest request,
  ) async {
    final response = await _networkService.post(
      ApiEndpoints.createHousehold,
      data: request.toJson(),
      onSuccess: (data) => CreateHouseholdResponse.fromJson(data),
    );

    return response;
  }

  /// Join an existing household with invite code
  /// Returns the full household after joining
  /// Note: API returns 204 No Content, so we fetch the household after joining
  Future<Household> joinHousehold(JoinHouseholdRequest request) async {
    await _networkService.post(
      ApiEndpoints.joinHousehold,
      data: request.toJson(),
      onSuccess: (_) => null, // 204 No Content - no response body
    );

    // After joining, fetch the full household details
    final household = await getCurrentHousehold();
    if (household == null) {
      throw Exception('Failed to fetch household after joining');
    }
    return household;
  }

  /// Get current user's household
  Future<Household?> getCurrentHousehold() async {
    try {
      final response = await _networkService.get(
        ApiEndpoints.getHousehold,
        onSuccess: (data) => Household.fromJson(data),
      );

      return response;
    } catch (e) {
      // User might not be in a household yet
      return null;
    }
  }

  /// Leave the current household
  Future<void> leaveHousehold() async {
    await _networkService.delete(
      ApiEndpoints.leaveHousehold,
      onSuccess: (_) => null,
    );
  }

  /// Kick a member from the household
  Future<void> kickHouseholdMember(String userId) async {
    final path = ApiEndpoints.kickHouseholdMember.replaceFirst(
      '{userId}',
      userId,
    );
    await _networkService.delete(
      path,
      onSuccess: (_) => null,
    );
  }
}

