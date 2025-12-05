import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../utils/logging.dart';

class LocationService {
  LocationService._();

  static final LocationService _instance = LocationService._();
  static LocationService get instance => _instance;

  final _logger = AppLogger.getLogger('LocationService');

  /// Check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  /// Check location permission status
  Future<PermissionStatus> checkLocationPermission() async {
    return await Permission.location.status;
  }

  /// Request location permission
  Future<PermissionStatus> requestLocationPermission() async {
    final status = await Permission.location.request();
    _logger.info('Location permission status: $status');
    return status;
  }

  /// Get current location
  /// Returns null if permission is denied or location cannot be determined
  Future<Position?> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      final serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) {
        _logger.warning('Location services are disabled');
        return null;
      }

      // Check permission
      var permission = await checkLocationPermission();
      if (permission == PermissionStatus.denied) {
        // Request permission
        permission = await requestLocationPermission();
        if (permission == PermissionStatus.denied) {
          _logger.warning('Location permission denied');
          return null;
        }
      }

      if (permission == PermissionStatus.permanentlyDenied) {
        _logger.warning('Location permission permanently denied');
        return null;
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      _logger.info(
        'Current location: ${position.latitude}, ${position.longitude}',
      );
      return position;
    } catch (e) {
      _logger.severe('Error getting current location: $e');
      return null;
    }
  }

  /// Get last known position (cached)
  Future<Position?> getLastKnownPosition() async {
    try {
      return await Geolocator.getLastKnownPosition();
    } catch (e) {
      _logger.severe('Error getting last known position: $e');
      return null;
    }
  }
}



