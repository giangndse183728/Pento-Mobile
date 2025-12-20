import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/trade_offers_model.dart';
import '../../data/repositories/trade_reports_repository.dart';

part 'trade_report_provider.g.dart';

@riverpod
class TradeReportNotifier extends _$TradeReportNotifier {
  late final TradeReportRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = TradeReportRepository();
    return null;
  }

  Future<TradeReportResponse> createReport({
    required String tradeSessionId,
    required TradeReportReason reason,
    required FoodSafetyIssueLevel severity,
    required String description,
  }) async {
    // Don't manage state in the provider, just call the repository
    return await _repository.createTradeReport(
      tradeSessionId: tradeSessionId,
      reason: reason,
      severity: severity,
      description: description,
    );
  }

  Future<void> uploadMedia({
    required String tradeReportId,
    required String filePath,
    required ReportMediaType mediaType,
  }) async {
    // Don't manage state in the provider, just call the repository
    return await _repository.uploadTradeReportMedia(
      tradeReportId: tradeReportId,
      filePath: filePath,
      mediaType: mediaType,
    );
  }
}

