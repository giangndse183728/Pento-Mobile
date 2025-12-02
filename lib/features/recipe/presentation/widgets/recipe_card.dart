import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../data/models/recipe_model.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.recipe,
    this.onTap,
  });

  final Recipe recipe;
  final VoidCallback? onTap;

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

  String _getDifficultyIcon(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return AppImages.easy;
      case 'medium':
        return AppImages.medium;
      case 'hard':
        return AppImages.hard;
      default:
        return AppImages.easy;
    }
  }

  Widget _buildChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 6.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.iceberg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.iceberg,
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.sp,
          color: AppColors.blueGray,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 6.w,
              right: 6.w,
              top: 6.h,
            ),
            child: AspectRatio(
              aspectRatio: 4 / 5,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: ConcaveNotchClipper(
                      borderRadius: 28.r,
                      notchRadius: 32.r,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            _getDifficultyColor(recipe.difficultyLevel)
                                .withValues(alpha: 0.3),
                            _getDifficultyColor(recipe.difficultyLevel)
                                .withValues(alpha: 0.15),
                          ],
                        ),
                      ),
                      child: recipe.imageUrl != null
                          ? Image.network(
                              recipe.imageUrl!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Icon(
                                    Icons.restaurant,
                                    size: 60.w,
                                    color: Colors.white.withValues(alpha: 0.7),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Icon(
                                Icons.restaurant,
                                size: 60.w,
                                color: Colors.white.withValues(alpha: 0.7),
                              ),
                            ),
                    ),
                  ),
                  Positioned(
                    top: 0.h,
                    right: 0.w,
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: _getDifficultyColor(recipe.difficultyLevel),
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Image.asset(
                        _getDifficultyIcon(recipe.difficultyLevel),
                        width: 20.w,
                        height: 20.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                   bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      decoration: BoxDecoration(
                        color: _getDifficultyColor(recipe.difficultyLevel)
                            .withValues(alpha: 0.85),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16.r),
                          bottomRight: Radius.circular(16.r),
                        ),
                      ),
                      child: Text(
                        '${recipe.unifiedTotalTime} mins',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16.sp * 1.2 * 2, 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          recipe.unifiedTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            height: 1.2,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                    ],
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    _buildChip('${recipe.servings} Servings'),
                    SizedBox(width: 8.w),
                    _buildChip(recipe.difficultyLevel)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ConcaveNotchClipper extends CustomClipper<Path> {
  final double borderRadius;
  final double notchRadius;

  ConcaveNotchClipper({
    required this.borderRadius,
    required this.notchRadius,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    
    path.moveTo(0, borderRadius);
    path.quadraticBezierTo(0, 0, borderRadius, 0);
    
    path.lineTo(size.width - notchRadius, 0);
    
    path.arcToPoint(
      Offset(size.width, notchRadius),
      radius: Radius.circular(notchRadius * 0.2),
      clockwise: false,
    );
    
    path.lineTo(size.width, size.height - borderRadius);
    
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - borderRadius,
      size.height,
    );
    
    path.lineTo(borderRadius, size.height);
    
    path.quadraticBezierTo(
      0,
      size.height,
      0,
      size.height - borderRadius,
    );
    
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}