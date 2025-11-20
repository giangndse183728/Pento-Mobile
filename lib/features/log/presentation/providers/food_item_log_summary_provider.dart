import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/food_item_log_model.dart';
import '../../data/repositories/food_item_log_repository.dart';

part 'food_item_log_summary_provider.g.dart';

@riverpod
class FoodItemLogSummaryData extends _$FoodItemLogSummaryData {
  late final FoodItemLogRepository _repository;

  @override
  FutureOr<FoodItemLogSummary> build() async {
    _repository = FoodItemLogRepository();
    return await _loadSummary();
  }

  Future<FoodItemLogSummary> _loadSummary() async {
    return await _repository.getSummary();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadSummary());
  }
}

