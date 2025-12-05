import 'package:dio/dio.dart';
import '../../../../core/exceptions/network_exception.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/endpoints.dart';
import '../../../../core/utils/logging.dart';
import '../models/place_models.dart';

class PlacesRepository {
  PlacesRepository({Dio? localClient})
      : _localClient = localClient ?? ApiClient.instance.nestDio;

  final Dio _localClient;
  final _logger = AppLogger.getLogger('PlacesRepository');

  Future<List<Place>> getNearbyPlaces({
    required String foodGroup,
    required double lat,
    required double lng,
    required String userId,
  }) async {
    _logger.info(
      'Fetching nearby places for foodGroup: $foodGroup at ($lat, $lng)',
    );

    try {
      final response = await _localClient.get(
        ApiEndpoints.placeNearBy,
        queryParameters: {
          'foodGroup': foodGroup,
          'lat': lat,
          'lng': lng,
          'userId': userId,
        },
      );

      final statusCode = response.statusCode ?? 200;
      if (statusCode >= 400) {
        throw NetworkException(
          message: 'Failed to fetch nearby places',
          statusCode: statusCode,
          data: response.data,
        );
      }

      // Parse response
      final responseData = response.data;
      if (responseData is! Map<String, dynamic>) {
        throw NetworkException(
          message: 'Invalid response format',
          statusCode: 500,
        );
      }

      // Handle the response structure: { statusCode, msg, data: [...] }
      final placesResponse = PlacesResponse.fromJson(responseData);
      return placesResponse.data;
    } on DioException catch (error) {
      final responseData = error.response?.data;
      final messageText = responseData?['msg'] as String? ??
          responseData?['detail'] as String? ??
          responseData?['message'] as String? ??
          'Unable to fetch nearby places. Please try again.';
      throw NetworkException(
        message: messageText,
        statusCode: error.response?.statusCode,
        data: responseData,
      );
    } catch (e) {
      _logger.severe('Error fetching nearby places: $e');
      if (e is NetworkException) {
        rethrow;
      }
      throw NetworkException(
        message: 'An unexpected error occurred while fetching nearby places',
        statusCode: 500,
      );
    }
  }
}

