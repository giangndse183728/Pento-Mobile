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
  Future<Household> joinHousehold(JoinHouseholdRequest request) async {
    final response = await _networkService.post(
      ApiEndpoints.joinHousehold,
      data: request.toJson(),
      onSuccess: (data) => Household.fromJson(data),
    );

    return response;
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
}

