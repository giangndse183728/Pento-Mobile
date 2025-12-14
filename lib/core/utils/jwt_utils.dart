import 'package:jwt_decoder/jwt_decoder.dart';
import '../utils/logging.dart';

/// Utility class for JWT token operations
class JwtUtils {
  JwtUtils._();

  static final _logger = AppLogger.getLogger('JwtUtils');

  /// Decode JWT token and extract payload
  static Map<String, dynamic>? decodePayload(String token) {
    try {
      return JwtDecoder.decode(token);
    } catch (e) {
      _logger.warning('⚠️ Failed to decode JWT token: $e');
      return null;
    }
  }

  /// Check if JWT token is expired
  /// Returns true if token is expired or invalid, false if still valid
  static bool isTokenExpired(String token) {
    try {
      final isExpired = JwtDecoder.isExpired(token);
      
      if (isExpired) {
        final decodedToken = JwtDecoder.decode(token);
        final exp = decodedToken['exp'];
        if (exp != null) {
          final expirationTime = DateTime.fromMillisecondsSinceEpoch(
            (exp as int) * 1000,
          );
          _logger.info('🕐 Token expired at: $expirationTime');
        } else {
          _logger.info('🕐 Token expired (no exp claim)');
        }
      } else {
        _logger.fine('✅ Token is valid');
      }
      
      return isExpired;
    } catch (e) {
      _logger.warning('⚠️ Failed to check token expiration: $e');
      return true; // Consider invalid tokens as expired
    }
  }

  /// Check if JWT token is valid (exists and not expired)
  static bool isTokenValid(String? token) {
    if (token == null || token.isEmpty) {
      return false;
    }
    return !isTokenExpired(token);
  }
}

