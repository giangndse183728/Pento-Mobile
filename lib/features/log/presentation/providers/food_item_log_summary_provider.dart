import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/food_item_log_model.dart';
import '../../data/repositories/food_item_log_repository.dart';

part 'food_item_log_summary_provider.g.dart';

@Riverpod(keepAlive: true)
class FoodItemLogSummaryData extends _$FoodItemLogSummaryData {
  final FoodItemLogRepository _repository = FoodItemLogRepository();

  @override
  FutureOr<FoodItemLogSummary> build() async => _loadSummary();

  Future<FoodItemLogSummary> _loadSummary() async {
    return await _repository.getSummary();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadSummary());
  }
}

