import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../data/models/recipe_model.dart';
import '../providers/recipe_provider.dart';

class RecipeDetailScreen extends ConsumerWidget {
  const RecipeDetailScreen({
    super.key,
    required this.recipeId,
  });

  final String recipeId;

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return AppColors.blueGray;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(recipeDetailNotifierProvider(recipeId));

    return AppScaffold(
      title: 'Recipe',
      showBackButton: true,
      showAvatarButton: false,
      showNotificationButton: false,
      padding: EdgeInsets.zero,
      transparentAppBar: true,
      body: detailAsync.when(
        loading: () => Center(
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + kToolbarHeight,
            ),
            child: CircularProgressIndicator(
              color: AppColors.babyBlue,
            ),
          ),
        ),
        error: (error, stack) => Center(
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + kToolbarHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 64.sp,
                  color: Colors.red.shade400,
                ),
                SizedBox(height: 20.h),
                Text(
                  'Failed to load recipe',
                  style: AppTextStyles.inputLabel.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 24.h),
                ElevatedButton.icon(
                  onPressed: () => ref
                      .read(recipeDetailNotifierProvider(recipeId).notifier)
                      .refresh(),
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.babyBlue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.w,
                      vertical: 14.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        data: (detail) {
          final screenWidth = MediaQuery.of(context).size.width;
          final imageHeight = screenWidth * 4 / 3;
          
          return Stack(
            children: [
              // Fixed image background
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: imageHeight,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Image or placeholder
                    detail.imageUrl != null
                        ? Image.network(
                            detail.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: AppColors.iceberg,
                                child: Icon(
                                  Icons.restaurant,
                                  size: 80.w,
                                  color: AppColors.blueGray.withValues(
                                    alpha: 0.5,
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(
                            color: AppColors.iceberg,
                            child: Icon(
                              Icons.restaurant,
                              size: 80.w,
                              color: AppColors.blueGray.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                    // Gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.2),
                            Colors.black.withValues(alpha: 0.6),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Scrollable content that moves over the image
              DraggableScrollableSheet(
                initialChildSize: (screenWidth * 1 / 1) / 
                    MediaQuery.of(context).size.height,
                minChildSize: (screenWidth * 1 / 1) / 
                    MediaQuery.of(context).size.height,
                maxChildSize: 1.0,
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.r),
                        topRight: Radius.circular(32.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20.r,
                          offset: Offset(0, -4.h),
                        ),
                      ],
                      border: Border(
                        top: BorderSide(
                          color: AppColors.powderBlue,
                          width: 8,
                        ),
                      ),
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 24.h,
                          left: 20.w,
                          right: 20.w,
                          bottom: 24.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                      // Title with difficulty level
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              detail.unifiedTitle,
                              style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                height: 1.2,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: _getDifficultyColor(detail.difficultyLevel),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Text(
                              detail.difficultyLevel,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      // Time and servings info
                      Row(
                        children: [
                          Expanded(
                            child: _InfoCard(
                              iconAsset: AppImages.prepTime,
                              value: '${detail.prepTimeMinutes}',
                              unit: 'min',
                              label: 'Prep',
                              color: AppColors.blueGray,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: _InfoCard(
                              iconAsset: AppImages.cookTime,
                              value: '${detail.cookTimeMinutes}',
                              unit: 'min',
                              label: 'Cook',
                              color: Colors.orange.shade400,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: _InfoCard(
                              iconAsset: AppImages.servings,
                              value: '${detail.servings}',
                              unit: '',
                              label: 'Servings',
                              color: Colors.green.shade400,
                            ),
                          ),
                        ],
                      ),
                      if (detail.description.isNotEmpty) ...[
                        SizedBox(height: 20.h),
                        Text(
                          detail.description,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.black87,
                            height: 1.6,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                      if (detail.notes.isNotEmpty) ...[
                        SizedBox(height: 16.h),
                        Container(
                          padding: EdgeInsets.all(14.w),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade50,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: Colors.amber.shade200,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(6.w),
                                decoration: BoxDecoration(
                                  color: Colors.amber.shade100,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.lightbulb_outline,
                                  size: 18.w,
                                  color: Colors.amber.shade700,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  detail.notes,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black87,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      // Ingredients section
                      SizedBox(height: 28.h),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: AppColors.babyBlue.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.shopping_basket_outlined,
                              size: 20.w,
                              color: AppColors.blueGray,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            'Ingredients',
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.iceberg.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.powderBlue.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(12.w),
                          itemCount: detail.ingredients.length,
                          separatorBuilder: (context, index) => Divider(
                            height: 12.h,
                            color: AppColors.powderBlue.withValues(alpha: 0.2),
                          ),
                          itemBuilder: (context, index) {
                            final ingredient = detail.ingredients[index];
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Ingredient image or placeholder
                                Container(
                                  width: 44.w,
                                  height: 44.w,
                                  margin: EdgeInsets.only(right: 12.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.iceberg,
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: AppColors.powderBlue.withValues(
                                        alpha: 0.3,
                                      ),
                                      width: 1,
                                    ),
                                  ),
                                  child: ingredient.imageUrl != null &&
                                          ingredient.imageUrl!.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                          child: Image.network(
                                            ingredient.imageUrl!,
                                            fit: BoxFit.cover,
                                            errorBuilder: (
                                              context,
                                              error,
                                              stackTrace,
                                            ) {
                                              return Icon(
                                                Icons.restaurant,
                                                size: 20.w,
                                                color: AppColors.blueGray
                                                    .withValues(alpha: 0.5),
                                              );
                                            },
                                          ),
                                        )
                                      : Icon(
                                          Icons.restaurant,
                                          size: 20.w,
                                          color: AppColors.blueGray.withValues(
                                            alpha: 0.5,
                                          ),
                                        ),
                                ),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${ingredient.quantity} ',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.blueGray,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '${ingredient.unitName ?? ''} ',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ingredient.foodRefName ?? '',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      // Directions section
                      SizedBox(height: 28.h),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.menu_book_outlined,
                              size: 20.w,
                              color: Colors.orange.shade700,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            'Directions',
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        height: detail.directions.any(
                          (d) =>
                              d.imageUrl != null && d.imageUrl!.isNotEmpty,
                        )
                            ? 320.h
                            : 200.h,
                        child: PageView.builder(
                          controller: PageController(viewportFraction: 0.92),
                          itemCount: detail.directions.length,
                          itemBuilder: (context, index) {
                            final direction = detail.directions[index];
                            return Container(
                              margin: EdgeInsets.only(right: 12.w),
                              child: _DirectionCard(
                                direction: direction,
                                stepNumber: direction.stepNumber,
                              ),
                            );
                          },
                        ),
                      ),
                    SizedBox(height: 40.h),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    this.icon,
    this.iconAsset,
    required this.value,
    required this.unit,
    required this.label,
    required this.color,
  }) : assert(
          icon != null || iconAsset != null,
          'Either icon or iconAsset must be provided',
        );

  final IconData? icon;
  final String? iconAsset;
  final String value;
  final String unit;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          if (iconAsset != null)
            Image.asset(
              iconAsset!,
              width: 24.w,
              height: 24.w,
            )
          else
            Icon(
              icon!,
              size: 24.w,
              color: color,
            ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              if (unit.isNotEmpty) ...[
                SizedBox(width: 2.w),
                Text(
                  unit,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: color.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _DirectionCard extends StatelessWidget {
  const _DirectionCard({
    required this.direction,
    required this.stepNumber,
  });

  final RecipeDirection direction;
  final int stepNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.powderBlue.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.powderBlue.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image if available
          if (direction.imageUrl != null && direction.imageUrl!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              child: Image.network(
                direction.imageUrl!,
                height: 140.h,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 140.h,
                    width: double.infinity,
                    color: AppColors.iceberg,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 40.w,
                      color: AppColors.blueGray.withValues(alpha: 0.3),
                    ),
                  );
                },
              ),
            ),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Step number badge
                  Row(
                    children: [
                      Container(
                        width: 36.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.babyBlue,
                              AppColors.blueGray,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.blueGray.withValues(alpha: 0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '$stepNumber',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'Step $stepNumber',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blueGray,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  // Description
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        direction.description,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black87,
                          height: 1.6,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

