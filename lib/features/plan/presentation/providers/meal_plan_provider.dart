import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/meal_plan_models.dart';
import '../../data/repositories/meal_plan_repository.dart';

part 'meal_plan_provider.g.dart';

/// Provider to fetch meal plans for a specific month/year
@riverpod
class MealPlan extends _$MealPlan {
  final _repository = MealPlanRepository();

  @override
  Future<List<MealPlanItem>> build({
    required int month,
    required int year,
  }) async {
    return await _repository.getMealPlans(
      month: month,
      year: year,
    );
  }

  /// Refresh meal plans for current month/year
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _repository.getMealPlans(month: month, year: year),
    );
  }

  // Get meals for a specific date from current state
  List<MealPlanItem> getMealsForDate(DateTime date) {
    final meals = state.value ?? [];
    return meals.where((meal) {
      final mealDate = meal.date;
      return mealDate.year == date.year &&
          mealDate.month == date.month &&
          mealDate.day == date.day;
    }).toList();
  }

  // Remove a meal from the plan (optimistic update)
  Future<void> removeMeal(String mealId) async {
    final currentMeals = state.value ?? [];
    state = AsyncValue.data(
      currentMeals.where((meal) => meal.id != mealId).toList(),
    );
    // TODO: API call for delete will go here
  }
}

/// Provider for the currently focused month in calendar
@riverpod
class FocusedMonth extends _$FocusedMonth {
  @override
  DateTime build() => DateTime.now();

  void setMonth(DateTime date) {
    state = DateTime(date.year, date.month, 1);
  }
}
