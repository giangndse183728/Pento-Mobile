import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/trade_offers_model.dart';

class TradeOfferRepository {
  final NetworkService _network = NetworkService.instance;

  static const int defaultPageSize = 12;

  Future<PaginatedTradeOffers> getTradeOffers({
    int pageNumber = 1,
    int pageSize = defaultPageSize,
  }) async {
    final queryParams = <String, dynamic>{
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };

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

  Future<void> createTradeRequestItem({
    required String tradeOfferId,
    required List<Map<String, dynamic>> items,
  }) async {
    final payload = <String, dynamic>{
      'tradeOfferId': tradeOfferId,
      'items': items,
    };

    await _network.post<void>(
      ApiEndpoints.createTradeRequestItem,
      data: payload,
      onSuccess: (_) => null,
    );
  }

  Future<List<MyPost>> getMyPosts() async {
    final result = await _network.get<List<MyPost>>(
      ApiEndpoints.getMyPosts,
      onSuccess: (data) {
        if (data == null) return <MyPost>[];
        
        final List<dynamic> items = data as List<dynamic>;
        return items
            .whereType<Map<String, dynamic>>()
            .map((json) => MyPost.fromJson(json))
            .toList();
      },
    );

    return result;
  }

  Future<List<TradeRequest>> getPostRequests({
    required String offerId,
  }) async {
    final endpoint = ApiEndpoints.getPostById.replaceAll('{offerId}', offerId);
    
    final result = await _network.get<List<TradeRequest>>(
      endpoint,
      onSuccess: (data) {
        if (data == null) return <TradeRequest>[];
        
        final List<dynamic> items = data as List<dynamic>;
        return items
            .whereType<Map<String, dynamic>>()
            .map((json) => TradeRequest.fromJson(json))
            .toList();
      },
    );

    return result;
  }

  Future<void> acceptTradeRequest({
    required String tradeOfferId,
    required String tradeRequestId,
  }) async {
    final endpoint = ApiEndpoints.acceptTradeRequest
        .replaceAll('{tradeOfferId}', tradeOfferId)
        .replaceAll('{tradeRequestId}', tradeRequestId);

    await _network.post<void>(
      endpoint,
      onSuccess: (_) => null,
    );
  }

  // Trade Session Methods
  Future<PaginatedTradeSessions> getTradeSessions({
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    final queryParams = <String, dynamic>{
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };

    final queryString = queryParams.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');

    final result = await _network.get<PaginatedTradeSessions>(
      '${ApiEndpoints.getAllTradeSession}?$queryString',
      onSuccess: (data) {
        return PaginatedTradeSessions.fromJson(
          data as Map<String, dynamic>,
        );
      },
    );

    return result;
  }

  Future<TradeSessionDetail> getTradeSessionDetail({
    required String sessionId,
  }) async {
    final endpoint = ApiEndpoints.getTradeSessionDetail
        .replaceAll('{sessionId}', sessionId);

    final result = await _network.get<TradeSessionDetail>(
      endpoint,
      onSuccess: (data) {
        return TradeSessionDetail.fromJson(
          data as Map<String, dynamic>,
        );
      },
    );

    return result;
  }

  Future<void> sendTradeSessionMessage({
    required String tradeSessionId,
    required String messageText,
  }) async {
    final endpoint = ApiEndpoints.sendTradeSessionMessage
        .replaceAll('{tradeSessionId}', tradeSessionId);

    await _network.post<void>(
      endpoint,
      data: {'message': messageText},
      onSuccess: (_) => null,
    );
  }
}
