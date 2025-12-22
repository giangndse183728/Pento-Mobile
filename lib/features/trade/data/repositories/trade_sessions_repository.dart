import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/trade_offers_model.dart';

class TradeSessionRepository {
  final NetworkService _network = NetworkService.instance;

  static const int defaultPageSize = 10;

  Future<PaginatedTradeSessions> getTradeSessions({
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

  Future<void> confirmTradeSession({
    required String tradeSessionId,
  }) async {
    final endpoint = ApiEndpoints.confirmTradeSessionItem
        .replaceAll('{tradeSessionId}', tradeSessionId);

    await _network.patch<void>(
      endpoint,
      onSuccess: (_) => null,
    );
  }

  Future<void> cancelTradeSession({
    required String tradeSessionId,
  }) async {
    final endpoint = ApiEndpoints.cancelTradeSession
        .replaceAll('{tradeSessionId}', tradeSessionId);

    await _network.delete<void>(
      endpoint,
      onSuccess: (_) => null,
    );
  }

  Future<List<TradeSessionItem>> addTradeSessionItems({
    required String tradeSessionId,
    required List<Map<String, dynamic>> items,
  }) async {
    final endpoint = ApiEndpoints.addTradeSessionItem
        .replaceAll('{tradeSessionId}', tradeSessionId);

    final payload = <String, dynamic>{
      'items': items,
    };

    final result = await _network.post<List<TradeSessionItem>>(
      endpoint,
      data: payload,
      onSuccess: (data) {
        if (data == null) return <TradeSessionItem>[];

        final List<dynamic> items = data as List<dynamic>;
        return items
            .whereType<Map<String, dynamic>>()
            .map((json) => TradeSessionItem.fromJson(json))
            .toList();
      },
    );

    return result;
  }

  Future<List<TradeSessionItem>> updateTradeSessionItems({
    required String tradeSessionId,
    required List<Map<String, dynamic>> items,
  }) async {
    final endpoint = ApiEndpoints.updateTradeSessionItem
        .replaceAll('{tradeSessionId}', tradeSessionId);

    final payload = <String, dynamic>{
      'items': items,
    };

    final result = await _network.patch<List<TradeSessionItem>>(
      endpoint,
      data: payload,
      onSuccess: (data) {
        if (data == null) return <TradeSessionItem>[];

        final List<dynamic> items = data as List<dynamic>;
        return items
            .whereType<Map<String, dynamic>>()
            .map((json) => TradeSessionItem.fromJson(json))
            .toList();
      },
    );

    return result;
  }

  Future<void> removeTradeSessionItems({
    required String tradeSessionId,
    required List<String> tradeItemIds,
  }) async {
    final endpoint = ApiEndpoints.removeTradeSessionItem
        .replaceAll('{tradeSessionId}', tradeSessionId);

    final queryParams = <String, dynamic>{
      'tradeItemIds': tradeItemIds,
    };

    await _network.delete<void>(
      endpoint,
      queryParameters: queryParams,
      onSuccess: (_) => null,
    );
  }
}







