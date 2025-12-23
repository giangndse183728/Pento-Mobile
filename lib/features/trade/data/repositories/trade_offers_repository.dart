import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/trade_offers_model.dart';

class TradeOfferRepository {
  final NetworkService _network = NetworkService.instance;

  static const int defaultPageSize = 12;

  Future<PaginatedTradeOffers> getTradeOffers({
    int pageNumber = 1,
    int pageSize = defaultPageSize,
    bool? isMine,
    bool? isMyHousehold,
    String? status,
  }) async {
    final queryParams = <String, dynamic>{
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };

    if (isMine != null) {
      queryParams['isMine'] = isMine;
    }
    if (isMyHousehold != null) {
      queryParams['isMyHousehold'] = isMyHousehold;
    }
    if (status != null) {
      queryParams['status'] = status;
    }

    final queryString = queryParams.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');

    final result = await _network.get<PaginatedTradeOffers>(
      '${ApiEndpoints.getTradeOffers}?$queryString',
      onSuccess: (data) {
        return PaginatedTradeOffers.fromJson(
          data as Map<String, dynamic>,
        );
      },
    );

    return result;
  }

  Future<void> createTradeOffer({
    required DateTime startDate,
    required DateTime endDate,
    required String pickupOption,
    required List<Map<String, dynamic>> items,
  }) async {
    final payload = <String, dynamic>{
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'pickupOption': pickupOption,
      'items': items,
    };

    await _network.post<void>(
      ApiEndpoints.createTradeOffer,
      data: payload,
      onSuccess: (_) => null,
    );
  }

  Future<PaginatedTradeOffers> getMyPosts({
    int pageNumber = 1,
    int pageSize = defaultPageSize,
    String? status,
  }) async {
    final queryParams = <String, dynamic>{
      'isMine': true,
      'isMyHousehold': true,
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };

    if (status != null && status.isNotEmpty) {
      queryParams['status'] = status;
    }

    final queryString = queryParams.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');

    final result = await _network.get<PaginatedTradeOffers>(
      '${ApiEndpoints.getTradeOffers}?$queryString',
      onSuccess: (data) {
        return PaginatedTradeOffers.fromJson(
          data as Map<String, dynamic>,
        );
      },
    );

    return result;
  }

  Future<void> cancelTradeOffer({
    required String tradeOfferId,
  }) async {
    final endpoint = ApiEndpoints.cancelTradeOffer
        .replaceAll('{tradeOfferId}', tradeOfferId);

    await _network.delete<void>(
      endpoint,
      onSuccess: (_) => null,
    );
  }
}
