import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/trade_offers_model.dart';

class TradeRequestRepository {
  final NetworkService _network = NetworkService.instance;

  static const int defaultPageSize = 10;

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

  Future<PaginatedTradeRequests> getPostRequests({
    required String offerId,
    int pageNumber = 1,
    int pageSize = defaultPageSize,
  }) async {
    final queryParams = <String, dynamic>{
      'offerId': offerId,
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };

    final queryString = queryParams.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');

    final result = await _network.get<PaginatedTradeRequests>(
      '${ApiEndpoints.getTradeRequests}?$queryString',
      onSuccess: (data) {
        return PaginatedTradeRequests.fromJson(
          data as Map<String, dynamic>,
        );
      },
    );

    return result;
  }

  Future<PaginatedTradeRequests> getMyTradeRequests({
    String? sortOrder = 'DESC',
    int pageNumber = 1,
    int pageSize = 12,
    String? status,
  }) async {
    final queryParams = <String, dynamic>{
      'sortOrder': sortOrder,
      'isMine': true,
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };

    if (status != null && status.isNotEmpty) {
      queryParams['status'] = status;
    }

    final queryString = queryParams.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');

    final result = await _network.get<PaginatedTradeRequests>(
      '${ApiEndpoints.getTradeRequests}?$queryString',
      onSuccess: (data) {
        return PaginatedTradeRequests.fromJson(
          data as Map<String, dynamic>,
        );
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

  Future<void> cancelTradeRequest({
    required String tradeRequestId,
  }) async {
    final endpoint = ApiEndpoints.cancelTradeRequest
        .replaceAll('{tradeRequestId}', tradeRequestId);

    await _network.delete<void>(
      endpoint,
      onSuccess: (_) => null,
    );
  }

  Future<void> rejectTradeRequest({
    required String tradeRequestId,
  }) async {
    final endpoint = ApiEndpoints.rejectTradeRequest
        .replaceAll('{tradeRequestId}', tradeRequestId);

    await _network.patch<void>(
      endpoint,
      onSuccess: (_) => null,
    );
  }

  Future<TradeRequestDetail> getTradeRequestDetail({
    required String tradeRequestId,
  }) async {
    final endpoint = ApiEndpoints.getTradeRequestsDetail
        .replaceAll('{tradeRequestId}', tradeRequestId);

    final result = await _network.get<TradeRequestDetail>(
      endpoint,
      onSuccess: (data) {
        return TradeRequestDetail.fromJson(
          data as Map<String, dynamic>,
        );
      },
    );

    return result;
  }
}








