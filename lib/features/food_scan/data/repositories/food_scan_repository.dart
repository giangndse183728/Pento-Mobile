import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/exceptions/network_exception.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/endpoints.dart';
import '../../../../core/utils/logging.dart';
import '../models/scanned_food_reference.dart';

class FoodScanRepository {
  FoodScanRepository({Dio? localClient})
      : _localClient = localClient ?? ApiClient.instance.nestDio;

  final Dio _localClient;
  final _logger = AppLogger.getLogger('FoodScanRepository');

  /// Scan food image to detect food items
  Future<ScanFoodResponse> scanFoodImage(File imageFile) async {
    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: 'food_image.jpg',
        ),
      });

      final response = await _localClient.post(
        ApiEndpoints.scanImage,
        data: formData,
      );

      final statusCode = response.statusCode ?? 200;
      if (statusCode >= 400) {
        throw NetworkException(
          message: 'Failed to scan food image',
          statusCode: statusCode,
          data: response.data,
        );
      }

      return _parseResponse(response.data);
    } on DioException catch (error) {
      final responseData = error.response?.data;
      final messageText = responseData?['detail'] as String? ??
          responseData?['message'] as String? ??
          'Failed to scan food image. Please try again.';
      throw NetworkException(
        message: messageText,
        statusCode: error.response?.statusCode,
        data: responseData,
      );
    }
  }

  /// Scan bill/receipt image to detect food items
  Future<ScanFoodResponse> scanBillImage(File imageFile) async {
    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: 'bill_image.jpg',
        ),
      });

      final response = await _localClient.post(
        ApiEndpoints.scanBillImage,
        data: formData,
      );

      final statusCode = response.statusCode ?? 200;
      if (statusCode >= 400) {
        throw NetworkException(
          message: 'Failed to scan bill image',
          statusCode: statusCode,
          data: response.data,
        );
      }

      return _parseResponse(response.data);
    } on DioException catch (error) {
      final responseData = error.response?.data;
      final messageText = responseData?['detail'] as String? ??
          responseData?['message'] as String? ??
          'Failed to scan bill image. Please try again.';
      throw NetworkException(
        message: messageText,
        statusCode: error.response?.statusCode,
        data: responseData,
      );
    }
  }

  ScanFoodResponse _parseResponse(dynamic data) {
    if (data == null) {
      _logger.warning('Response data is null');
      return const ScanFoodResponse(
        success: false,
        error: 'Empty response from server',
      );
    }

    if (data is Map<String, dynamic>) {
      // Check if response is wrapped in a 'data' field
      if (data.containsKey('data') && data['data'] is Map<String, dynamic>) {
        final innerData = data['data'] as Map<String, dynamic>;
        _logger.info('Parsing nested data: $innerData');
        try {
          _logger.info('Items in innerData: ${innerData['items']}');
          _logger.info('Items type: ${innerData['items'].runtimeType}');
          final parsed = ScanFoodResponse.fromJson(innerData);
          _logger.info(
            'Parsed response: success=${parsed.success}, '
            'items=${parsed.items.length}',
          );
          if (parsed.items.isNotEmpty) {
            _logger.info('First item: ${parsed.items.first.name}');
          }
          return parsed;
        } catch (e, stackTrace) {
          _logger.severe('Failed to parse nested response', e, stackTrace);
          return ScanFoodResponse(
            success: false,
            error: 'Failed to parse response: $e',
          );
        }
      }
      // Otherwise, try to parse directly
      _logger.info('Parsing direct data: $data');
      try {
        final parsed = ScanFoodResponse.fromJson(data);
        _logger.info(
          'Parsed response: success=${parsed.success}, '
          'items=${parsed.items.length}',
        );
        return parsed;
      } catch (e, stackTrace) {
        _logger.severe('Failed to parse direct response', e, stackTrace);
        return ScanFoodResponse(
          success: false,
          error: 'Failed to parse response: $e',
        );
      }
    }

    _logger.warning('Response is not a Map: ${data.runtimeType}');
    return const ScanFoodResponse(
      success: false,
      error: 'Invalid response format',
    );
  }
}

