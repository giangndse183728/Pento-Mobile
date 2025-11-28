import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/circle_icon_button.dart';
import '../../data/models/meal_plan_models.dart';
import '../providers/meal_plan_provider.dart';
import '../widgets/meal_plan_item_card.dart';
import '../../../../core/constants/app_images.dart';

class MealPlanScreen extends HookConsumerWidget {
  const MealPlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = useState(DateTime.now());
    final focusedDay = useState(DateTime.now());
    final topSpacing = MediaQuery.of(context).padding.top + kToolbarHeight;

    // Watch meal plans for the focused month
    final mealPlanAsync = ref.watch(
      mealPlanProvider(
        month: focusedDay.value.month,
        year: focusedDay.value.year,
      ),
    );

    return AppScaffold(
      title: 'Meal Plan',
      forcePillMode: true,
      actions: [
        CircleIconButton(
          icon: Icons.shopping_cart_outlined,
          onTap: () => context.push(AppRoutes.grocery),
        ),
      ],
      body: Stack(
        children: [
          mealPlanAsync.when(
            data: (meals) {
              final mealsForSelectedDay = meals.where((meal) {
                final mealDate = meal.date;
                return mealDate.year == selectedDay.value.year &&
                    mealDate.month == selectedDay.value.month &&
                    mealDate.day == selectedDay.value.day;
              }).toList();

              return ListView(
                padding: EdgeInsets.only(bottom: 80.h),
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(height: topSpacing),
                  Container(
                    color: Colors.white,
                    child: TableCalendar<MealPlanItem>(
                      rowHeight: 72.h,
                      daysOfWeekHeight: 16.h,
                      
                      firstDay: DateTime.now().subtract(
                        const Duration(days: 365),
                      ),
                      lastDay: DateTime.now().add(
                        const Duration(days: 365),
                      ),
                      focusedDay: focusedDay.value,
                      selectedDayPredicate: (day) =>
                          isSameDay(selectedDay.value, day),
                      calendarFormat: CalendarFormat.week,
                      availableCalendarFormats: const {
                        CalendarFormat.week: 'Week',
                      },
                      onDaySelected: (selected, focused) {
                        selectedDay.value = selected;
                        focusedDay.value = focused;
                      },
                      onPageChanged: (focused) {
                        focusedDay.value = focused;
                      },
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: AppColors.powderBlue,
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: AppColors.blueGray,
                          shape: BoxShape.circle,
                        ),
                        markerDecoration: BoxDecoration(
                          color: AppColors.blueGray.withAlpha(180),
                          shape: BoxShape.circle,
                        ),
                        markerMargin: EdgeInsets.only(bottom: 6.h),
                        markersAlignment: Alignment.bottomCenter,
                        outsideDaysVisible: false,
                      ),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                      calendarBuilders: CalendarBuilders(
                        markerBuilder: (context, day, events) {
                          if (events.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          final mealsForDay = events.cast<MealPlanItem>();
                          final markers = MealType.values
                              .where(
                                (type) => mealsForDay.any(
                                  (meal) => meal.mealTypeEnum == type,
                                ),
                              )
                              .toList();
                          if (markers.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          return Positioned(
                            bottom: 4.h,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: markers
                                  .map(
                                    (type) => Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 0.w,
                                      ),
                                      child: Image.asset(
                                        _getMealTypeIcon(type),
                                        width: 11.w,
                                        height: 11.h,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          );
                        },
                      ),
                      eventLoader: (day) {
                        return meals.where((meal) {
                          final mealDate = meal.date;
                          return mealDate.year == day.year &&
                              mealDate.month == day.month &&
                              mealDate.day == day.day;
                        }).toList();
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatSelectedDate(selectedDay.value),
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blueGray,
                          ),
                        ),
                        Text(
                          '${mealsForSelectedDay.length} meals',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  if (mealsForSelectedDay.isEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          SizedBox(height: 80.h),
                          Icon(
                            Icons.restaurant_menu,
                            size: 64.sp,
                            color: AppColors.powderBlue,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'No meals planned',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Tap + to add a meal',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...mealsForSelectedDay.map(
                      (meal) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: MealPlanItemCard(
                          meal: meal,
                          onDelete: () {
                            ref
                                .read(mealPlanProvider(
                                  month: focusedDay.value.month,
                                  year: focusedDay.value.year,
                                ).notifier)
                                .removeMeal(meal.id);
                          },
                        ),
                      ),
                    ),
                ],
              );
            },
            loading: () => Center(
              child: Padding(
                padding: EdgeInsets.only(top: topSpacing + 100.h),
                child: const CircularProgressIndicator(
                  color: AppColors.blueGray,
                ),
              ),
            ),
            error: (error, stack) => Center(
              child: Padding(
                padding: EdgeInsets.only(top: topSpacing + 50.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64.sp,
                      color: Colors.red.shade300,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Failed to load meal plan',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextButton(
                      onPressed: () {
                        ref.invalidate(mealPlanProvider(
                          month: focusedDay.value.month,
                          year: focusedDay.value.year,
                        ));
                      },
                      child: Text(
                        'Retry',
                        style: TextStyle(
                          color: AppColors.blueGray,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatSelectedDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Today';
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day + 1) {
      return 'Tomorrow';
    } else {
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    }
  }

  String _getMealTypeIcon(MealType type) {
    switch (type) {
      case MealType.breakfast:
        return AppImages.breakfast;
      case MealType.lunch:
        return AppImages.lunch;
      case MealType.dinner:
        return AppImages.dinner;
      case MealType.snack:
        return AppImages.snack;
    }
  }
}
