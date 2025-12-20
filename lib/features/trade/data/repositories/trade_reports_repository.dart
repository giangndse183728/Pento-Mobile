import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/trade_offers_model.dart';

class TradeReportRepository {
  final NetworkService _network = NetworkService.instance;

  Future<TradeReportResponse> createTradeReport({
    required String tradeSessionId,
    required TradeReportReason reason,
    required FoodSafetyIssueLevel severity,
    required String description,
  }) async {
    // Convert enum to API format
    String reasonValue;
    switch (reason) {
      case TradeReportReason.foodSafetyConcern:
        reasonValue = 'FoodSafetyConcern';
        break;
      case TradeReportReason.expiredFood:
        reasonValue = 'ExpiredFood';
        break;
      case TradeReportReason.poorHygiene:
        reasonValue = 'PoorHygiene';
        break;
      case TradeReportReason.misleadingInformation:
        reasonValue = 'MisleadingInformation';
        break;
      case TradeReportReason.inappropriateBehavior:
        reasonValue = 'InappropriateBehavior';
        break;
      case TradeReportReason.other:
        reasonValue = 'Other';
        break;
    }

    String severityValue;
    switch (severity) {
      case FoodSafetyIssueLevel.minor:
        severityValue = 'Minor';
        break;
      case FoodSafetyIssueLevel.serious:
        severityValue = 'Serious';
        break;
      case FoodSafetyIssueLevel.critical:
        severityValue = 'Critical';
        break;
    }

    final payload = <String, dynamic>{
      'tradeSessionId': tradeSessionId,
      'reason': reasonValue,
      'severity': severityValue,
      'description': description,
    };

    final result = await _network.post<TradeReportResponse>(
      ApiEndpoints.reportTrade,
      data: payload,
      onSuccess: (data) {
        // Handle if API returns just the ID string
        if (data is String) {
          return TradeReportResponse(
            tradeReportId: data,
            tradeSessionId: tradeSessionId,
            reason: reasonValue,
            severity: severityValue,
            description: description,
            createdAt: DateTime.now(),
          );
        }
        // Handle if API returns full object
        return TradeReportResponse.fromJson(
          data as Map<String, dynamic>,
        );
      },
    );

    return result;
  }

  Future<void> uploadTradeReportMedia({
    required String tradeReportId,
    required String filePath,
    required ReportMediaType mediaType,
  }) async {
    final mediaTypeValue =
        mediaType == ReportMediaType.image ? 'Image' : 'Video';

    final endpoint = '${ApiEndpoints.reportTradeMedia.replaceAll('{tradeReportId}', tradeReportId)}?mediaType=$mediaTypeValue';

    await _network.uploadFile(
      endpoint,
      filePath: filePath,
      fieldName: 'file',
      onSuccess: (_) => null,
    );
  }
}

