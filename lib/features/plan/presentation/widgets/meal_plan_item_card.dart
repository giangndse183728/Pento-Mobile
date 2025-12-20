import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../../../core/utils/logging.dart';
import '../../data/repositories/meal_plan_repository.dart';
import '../providers/meal_plan_provider.dart';
import 'fulfill_food_item_dialog.dart';

class MealPlanItemCard extends ConsumerStatefulWidget {
  final MealPlanItem meal;
  final VoidCallback onDelete;

  const MealPlanItemCard({
    super.key,
    required this.meal,
    required this.onDelete,
  });

  @override
  ConsumerState<MealPlanItemCard> createState() => _MealPlanItemCardState();
}

class _MealPlanItemCardState extends ConsumerState<MealPlanItemCard>
    with SingleTickerProviderStateMixin {
  final _repository = MealPlanRepository();
  final _logger = AppLogger.getLogger('MealPlanItemCard');
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final meal = widget.meal;
    final mealType = meal.mealTypeEnum;
    final hasContent = meal.hasRecipes || meal.hasFoodItems;
    final mealPlanId = meal.id;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          InkWell(
            onTap: hasContent ? _toggleExpanded : null,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12.r),
              bottom: _isExpanded ? Radius.zero : Radius.circular(12.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Row(
                children: [
                  // Meal Image or Icon
                  _buildMealImage(mealType),

                  SizedBox(width: 12.w),

                  // Meal Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meal.name,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    _getMealTypeColor(mealType).withAlpha(51),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                _getMealTypeLabel(mealType),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: _getMealTypeColor(mealType),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            if (meal.servings > 0) ...[
                              Icon(
                                Icons.people_outline,
                                size: 14.sp,
                                color: Colors.black54,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '${meal.servings} servings',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ],
                        ),
                        if (hasContent) ...[
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              if (meal.hasRecipes) ...[
                                Icon(
                                  Icons.restaurant,
                                  size: 14.sp,
                                  color: Colors.black54,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  '${meal.recipes.length} recipe${meal.recipes.length > 1 ? 's' : ''}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                              if (meal.hasRecipes && meal.hasFoodItems)
                                SizedBox(width: 8.w),
                              if (meal.hasFoodItems) ...[
                                Icon(
                                  Icons.fastfood_outlined,
                                  size: 14.sp,
                                  color: Colors.black54,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  '${meal.foodItems.length} item${meal.foodItems.length > 1 ? 's' : ''}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Dropdown Arrow (if has content)
                  if (hasContent)
                    RotationTransition(
                      turns: _rotationAnimation,
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black54,
                        size: 24.sp,
                      ),
                    ),

                  SizedBox(width: 4.w),

                  // Delete Button
                  IconButton(
                    onPressed: widget.onDelete,
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.red.shade400,
                      size: 20.sp,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
          ),

          // Expanded Content
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: _buildExpandedContent(mealType, mealPlanId),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedContent(MealType mealType, String mealPlanId) {
    final meal = widget.meal;

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(height: 1, color: Colors.grey.shade200),

          // Recipes Section
          if (meal.hasRecipes) ...[
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 8.h),
              child: Row(
                children: [
                  Icon(
                    Icons.restaurant,
                    size: 16.sp,
                    color: _getMealTypeColor(mealType),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'Recipes',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: _getMealTypeColor(mealType),
                    ),
                  ),
                ],
              ),
            ),
            ...meal.recipes.map(
              (recipe) => _buildRecipeItem(recipe, mealPlanId),
            ),
          ],

          // Food Items Section
          if (meal.hasFoodItems) ...[
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 8.h),
              child: Row(
                children: [
                  Icon(
                    Icons.fastfood_outlined,
                    size: 16.sp,
                    color: _getMealTypeColor(mealType),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'Food Items',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: _getMealTypeColor(mealType),
                    ),
                  ),
                ],
              ),
            ),
            ...meal.foodItems.map(
              (foodItem) => _buildFoodItemTile(foodItem),
            ),
          ],

          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  Widget _buildRecipeItem(MealPlanRecipe recipe, String mealPlanId) {
    final status = recipe.status;
    final isDimmed = status != null && _isCompletedStatus(status);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      child: Slidable(
        key: ValueKey(recipe.id),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => _handleFulfillRecipe(recipe.id, mealPlanId),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.check_circle,
              label: 'Fulfill',
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
              ),
            ),
            SlidableAction(
              onPressed: (_) => _handleCancelRecipe(recipe.id, mealPlanId),
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              icon: Icons.cancel,
              label: 'Cancel',
            ),
          ],
        ),
        child: Opacity(
          opacity: isDimmed ? 0.5 : 1,
          child: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                // Recipe Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.r),
                  child: recipe.imageUrl != null &&
                          recipe.imageUrl!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: recipe.imageUrl!,
                          width: 50.w,
                          height: 50.h,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            width: 50.w,
                            height: 50.h,
                            color: Colors.grey.shade200,
                            child: Icon(
                              Icons.restaurant,
                              size: 24.sp,
                              color: Colors.grey,
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 50.w,
                            height: 50.h,
                            color: Colors.grey.shade200,
                            child: Icon(
                              Icons.restaurant,
                              size: 24.sp,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : Container(
                          width: 50.w,
                          height: 50.h,
                          color: Colors.grey.shade200,
                          child: Icon(
                            Icons.restaurant,
                            size: 24.sp,
                            color: Colors.grey,
                          ),
                        ),
                ),
                SizedBox(width: 10.w),
                // Recipe Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.title,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          if (recipe.difficultyLevel != null) ...[
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: _getDifficultyColor(
                                  recipe.difficultyLevel!,
                                ).withAlpha(30),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                recipe.difficultyLevel!,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: _getDifficultyColor(
                                    recipe.difficultyLevel!,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 6.w),
                          ],
                          Icon(
                            Icons.people_outline,
                            size: 12.sp,
                            color: Colors.black45,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            '${recipe.servings}',
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.black45,
                            ),
                          ),
                          if (status != null && status.isNotEmpty) ...[
                            SizedBox(width: 8.w),
                            _buildStatusChip(status),
                          ],
                        ],
                      ),
                      if (recipe.description != null &&
                          recipe.description!.isNotEmpty) ...[
                        SizedBox(height: 4.h),
                        Text(
                          recipe.description!,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.black54,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFoodItemTile(MealPlanFoodItem foodItem) {
    final status = foodItem.status;
    final isDimmed = status != null && _isCompletedStatus(status);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      child: Slidable(
        key: ValueKey(foodItem.id),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => _handleFulfillFoodItem(foodItem),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.check_circle,
              label: 'Fulfill',
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
              ),
            ),
            SlidableAction(
              onPressed: (_) => _handleCancelFoodItem(foodItem),
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              icon: Icons.cancel,
              label: 'Cancel',
            ),
          ],
        ),
        child: Opacity(
          opacity: isDimmed ? 0.5 : 1,
          child: Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              // Food Item Image
              ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: foodItem.imageUrl != null &&
                        foodItem.imageUrl!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: foodItem.imageUrl!,
                        width: 50.w,
                        height: 50.h,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: 50.w,
                          height: 50.h,
                          color: Colors.grey.shade200,
                          child: Icon(
                            Icons.fastfood_outlined,
                            size: 24.sp,
                            color: Colors.grey,
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: 50.w,
                          height: 50.h,
                          color: Colors.grey.shade200,
                          child: Icon(
                            Icons.fastfood_outlined,
                            size: 24.sp,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : Container(
                        width: 50.w,
                        height: 50.h,
                        color: Colors.grey.shade200,
                        child: Icon(
                          Icons.fastfood_outlined,
                          size: 24.sp,
                          color: Colors.grey,
                        ),
                      ),
              ),
              SizedBox(width: 10.w),
              // Food Item Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      foodItem.name,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        if (foodItem.foodGroup != null) ...[
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.blueGray.withAlpha(30),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              foodItem.foodGroup!,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blueGray,
                              ),
                            ),
                          ),
                          SizedBox(width: 6.w),
                        ],
                        if (foodItem.quantity > 0) ...[
                          Text(
                            '${foodItem.quantity.toStringAsFixed(foodItem.quantity.truncateToDouble() == foodItem.quantity ? 0 : 1)} ${foodItem.unitAbbreviation ?? ''}',
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                        if (status != null && status.isNotEmpty) ...[
                          SizedBox(width: 8.w),
                          _buildStatusChip(status),
                        ],
                      ],
                    ),
                    if (foodItem.expirationDate != null) ...[
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.event_outlined,
                            size: 12.sp,
                            color: _getExpirationColor(
                              foodItem.expirationDate!,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Exp: ${foodItem.expirationDate}',
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: _getExpirationColor(
                                foodItem.expirationDate!,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }

  Future<void> _handleFulfillRecipe(String recipeId, String mealPlanId) async {
    try {
      await _repository.fulfillRecipeReservation(
        mealPlanId: mealPlanId,
        recipeId: recipeId,
      );
      _refreshMealPlan();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Recipe reservation fulfilled'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      _logger.severe('Error fulfilling recipe reservation: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to fulfill recipe: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _handleCancelRecipe(String recipeId, String mealPlanId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AppDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Cancel Recipe Reservation',
              style: AppTextStyles.sectionHeader(),
            ),
            SizedBox(height: 16.h),
            Text(
              'Canceling this recipe reservation will return all ingredients to the first storage/compartment.',
              style: AppTextStyles.inputHint,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: AppColors.blueGray,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Confirm',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    if (confirmed != true || !mounted) {
      return;
    }

    try {
      await _repository.cancelRecipeReservation(
        mealPlanId: mealPlanId,
        recipeId: recipeId,
      );
      _refreshMealPlan();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Recipe reservation cancelled'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      _logger.severe('Error cancelling recipe reservation: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to cancel recipe: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _handleFulfillFoodItem(MealPlanFoodItem foodItem) async {
    if (!mounted) return;

    final reservationId = foodItem.reservationId ?? foodItem.id;
    if (reservationId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid reservation ID'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    await showDialog(
      context: context,
      builder: (context) => FulfillFoodItemDialog(
        foodItemName: foodItem.name,
        defaultQuantity: foodItem.quantity > 0 ? foodItem.quantity : 0,
        defaultUnitAbbreviation: foodItem.unitAbbreviation,
        onConfirm: (quantity, unitId) async {
          try {
            await _repository.fulfillFoodItemReservation(
              reservationId: reservationId,
              quantity: quantity,
              unitId: unitId,
            );
            _refreshMealPlan();
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Food item reservation fulfilled'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          } catch (e) {
            _logger.severe('Error fulfilling food item reservation: $e');
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to fulfill food item: ${e.toString()}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
            rethrow;
          }
        },
      ),
    );
  }

  Future<void> _handleCancelFoodItem(MealPlanFoodItem foodItem) async {
    final reservationId = foodItem.reservationId ?? foodItem.id;
    if (reservationId.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid reservation ID'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AppDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Cancel Food Item Reservation',
              style: AppTextStyles.sectionHeader(),
            ),
            SizedBox(height: 16.h),
            Text(
              'Canceling this food item reservation will return it to the first storage/compartment.',
              style: AppTextStyles.inputHint,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: AppColors.blueGray,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Confirm',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    if (confirmed != true || !mounted) {
      return;
    }

    try {
      await _repository.cancelFoodItemReservation(
        reservationId: reservationId,
      );
      _refreshMealPlan();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Food item reservation cancelled'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      _logger.severe('Error cancelling food item reservation: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to cancel food item: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _refreshMealPlan() {
    final mealDate = widget.meal.date;
    final mealPlanAsync = ref.read(
      mealPlanProvider(
        month: mealDate.month,
        year: mealDate.year,
      ),
    );
    mealPlanAsync.whenData((_) {
      ref
          .read(
            mealPlanProvider(
              month: mealDate.month,
              year: mealDate.year,
            ).notifier,
          )
          .refresh();
    });
  }

  Widget _buildMealImage(MealType mealType) {
    return Container(
      width: 48.w,
      height: 48.h,
      decoration: BoxDecoration(
        color: _getMealTypeColor(mealType).withAlpha(51),
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(8.w),
      child: Image.asset(
        _getMealTypeImage(mealType),
        fit: BoxFit.contain,
      ),
    );
  }

  String _getMealTypeImage(MealType type) {
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

  Color _getMealTypeColor(MealType type) {
    switch (type) {
      case MealType.breakfast:
        return Colors.orange;
      case MealType.lunch:
        return AppColors.blueGray;
      case MealType.dinner:
        return Colors.deepPurple;
      case MealType.snack:
        return Colors.green;
    }
  }

  String _getMealTypeLabel(MealType type) {
    switch (type) {
      case MealType.breakfast:
        return 'Breakfast';
      case MealType.lunch:
        return 'Lunch';
      case MealType.dinner:
        return 'Dinner';
      case MealType.snack:
        return 'Snack';
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getExpirationColor(String expirationDate) {
    try {
      final expDate = DateTime.parse(expirationDate);
      final now = DateTime.now();
      final difference = expDate.difference(now).inDays;

      if (difference < 0) {
        return Colors.red; // Expired
      } else if (difference <= 3) {
        return Colors.orange; // Expiring soon
      } else {
        return Colors.green; // Good
      }
    } catch (e) {
      return Colors.grey;
    }
  }

  Widget _buildStatusChip(String status) {
    final color = _getStatusColor(status);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'fulfilled':
        return Colors.green;
      case 'cancelled':
        return Colors.orange;
      case 'pending':
        return AppColors.blueGray;
      default:
        return Colors.grey;
    }
  }

  bool _isCompletedStatus(String status) {
    final normalized = status.toLowerCase();
    return normalized == 'fulfilled' ||
        normalized == 'fullfilled' ||
        normalized == 'cancelled' ||
        normalized == 'canceled';
  }
}
