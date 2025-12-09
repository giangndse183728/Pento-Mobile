import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/exceptions/network_exception.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/utils/logging.dart';
import '../../../authentication/presentation/providers/user_session_provider.dart';
import '../../data/models/place_models.dart';
import '../../data/repositories/places_repository.dart';

part 'nearby_places_provider.g.dart';

@riverpod
class NearbyPlaces extends _$NearbyPlaces {
  final PlacesRepository _repository = PlacesRepository();
  final LocationService _locationService = LocationService.instance;
  final _logger = AppLogger.getLogger('NearbyPlaces');

  @override
  Future<List<Place>> build(String foodGroup) async {
    if (foodGroup.isEmpty) {
      return [];
    }

    try {
      // Get current location
      final position = await _locationService.getCurrentLocation();
      if (position == null) {
        _logger.warning('Could not get current location');
        return [];
      }

      // Get userId from user session (set by profile_initializer_provider)
      final userSession = ref.read(userSessionNotifierProvider);
      final userId = userSession?.userId;
      if (userId == null) {
        throw NetworkException(
          message: 'User not authenticated',
          statusCode: 401,
        );
      }

      // Fetch nearby places
      return await _repository.getNearbyPlaces(
        foodGroup: foodGroup,
        lat: position.latitude,
        lng: position.longitude,
        userId: userId,
      );
    } on NetworkException {
      rethrow;
    } catch (e) {
      _logger.severe('Error fetching nearby places: $e');
      rethrow;
    }
  }

  Future<void> refresh(String foodGroup) async {
    if (foodGroup.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build(foodGroup));
  }
}

