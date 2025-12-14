import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/meal_plan_models.dart';
import '../../data/repositories/meal_plan_repository.dart';

final mealReservationControllerProvider =
    AutoDisposeAsyncNotifierProvider<MealReservationController, void>(
  MealReservationController.new,
);

class MealReservationController extends AutoDisposeAsyncNotifier<void> {
  late final MealPlanRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = MealPlanRepository();
    return null;
  }

  Future<void> createReservation(MealReservationPayload payload) async {
    state = const AsyncValue.loading();
    try {
      await _repository.createMealReservation(payload: payload);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}


