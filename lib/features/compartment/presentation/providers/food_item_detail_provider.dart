import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/compartment_models.dart';
import '../../data/repositories/compartment_repository.dart';

part 'food_item_detail_provider.g.dart';

@riverpod
class FoodItemDetail extends _$FoodItemDetail {
  late final CompartmentRepository _repository;
  late final String _foodItemId;

  @override
  FutureOr<CompartmentItemDetail> build(String foodItemId) async {
    _repository = CompartmentRepository();
    _foodItemId = foodItemId;
    return await _repository.getFoodItemDetail(foodItemId);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _repository.getFoodItemDetail(_foodItemId);
    });
  }
}

