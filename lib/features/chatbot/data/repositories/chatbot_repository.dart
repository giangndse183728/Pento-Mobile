import 'package:dio/dio.dart';
import '../../../../core/exceptions/network_exception.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/endpoints.dart';

class ChatbotRepository {
  ChatbotRepository({Dio? localClient})
      : _localClient = localClient ?? ApiClient.instance.nestDio;

  final Dio _localClient;

  Future<String> sendMessage({
    required String message,
    required String userId,
  }) async {
    try {
      final response = await _localClient.post(
        ApiEndpoints.chatbot,
        queryParameters: {
          'userId': userId,
        },
        data: {
          'message': message,
        },
      );

      final statusCode = response.statusCode ?? 200;
      if (statusCode >= 400) {
        throw NetworkException(
          message: 'Chatbot request failed',
          statusCode: statusCode,
          data: response.data,
        );
      }

      return _extractReply(response.data);
    } on DioException catch (error) {
      final responseData = error.response?.data;
      final messageText = responseData?['detail'] as String? ??
          responseData?['message'] as String? ??
          'Unable to reach chatbot. Please try again.';
      throw NetworkException(
        message: messageText,
        statusCode: error.response?.statusCode,
        data: responseData,
      );
    }
  }

  String _extractReply(dynamic data) {
    final reply = _findContent(data)?.trim();
    if (reply != null && reply.isNotEmpty) {
      return reply;
    }

    throw NetworkException(
      message: 'Chatbot returned an empty response.',
      statusCode: 500,
      data: data,
    );
  }

  String? _findContent(dynamic data) {
    if (data == null) {
      return null;
    }

    if (data is String) {
      return data;
    }

    if (data is Map<String, dynamic>) {
      final candidates = [
        'content',
        'reply',
        'message',
        'response',
        'data',
        'text',
      ];

      for (final key in candidates) {
        if (!data.containsKey(key)) continue;
        final result = _findContent(data[key]);
        if (result != null && result.trim().isNotEmpty) {
          return result;
        }
      }

      for (final value in data.values) {
        final result = _findContent(value);
        if (result != null && result.trim().isNotEmpty) {
          return result;
        }
      }
    }

    if (data is Iterable) {
      for (final entry in data) {
        final result = _findContent(entry);
        if (result != null && result.trim().isNotEmpty) {
          return result;
        }
      }
    }

    return null;
  }
}

