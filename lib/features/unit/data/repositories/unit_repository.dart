import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/unit_model.dart';

class UnitRepository {
  final NetworkService _network = NetworkService.instance;

  Future<List<Unit>> getUnits() async {
    final response = await _network.get<List<Unit>>(
      ApiEndpoints.getUnit,
      onSuccess: (data) {
        if (data is List<dynamic>) {
          return data
              .map((e) => Unit.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return <Unit>[];
      },
    );
    return response;
  }
}


