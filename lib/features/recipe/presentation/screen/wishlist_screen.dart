import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/glass_toggle.dart';
import '../../data/models/recipe_model.dart';
import '../providers/recipe_provider.dart';
import '../widgets/recipe_card.dart';

class WishlistScreen extends ConsumerStatefulWidget {
  const WishlistScreen({super.key});

  @override
  ConsumerState<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends ConsumerState<WishlistScreen> {
  int _selectedToggleIndex = 0; // 0 = My Wishlist (isMine: true), 1 = Household Wishlist (isMine: false)
  bool _isInitialized = false;

  Widget _buildHeader(int totalCount) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Wishlist',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.blueGrey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              '$totalCount items',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncWishlist = ref.watch(wishlistProvider);

    // Initialize with My Wishlist (isMine: true) on first build
    if (!_isInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ref.read(wishlistProvider.notifier).setIsMine(true);
          setState(() {
            _isInitialized = true;
          });
        }
      });
    }

    Future<void> refreshWishlist() =>
        ref.read(wishlistProvider.notifier).refresh();

    return AppScaffold(
      title: 'Wishlist',
      showBackButton: true,
      padding: EdgeInsets.zero,
      body: RefreshIndicator(
        onRefresh: refreshWishlist,
        child: asyncWishlist.when(
          loading: () => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top +
                    kToolbarHeight +
                    16.h,
              ),
              _buildHeader(0),
              const SizedBox(
                height: 320,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
          error: (e, st) => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top +
                    kToolbarHeight +
                    16.h,
              ),
              _buildHeader(0),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Failed to load wishlist'),
                      SizedBox(height: 8.h),
                      ElevatedButton(
                        onPressed: refreshWishlist,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          data: (wishlistState) {
            Widget buildList({required bool isEmpty}) {
              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.axis != Axis.vertical) {
                    return false;
                  }
                  final data = asyncWishlist.valueOrNull;
                  if (data == null ||
                      data.isLoadingMore ||
                      !data.hasNext) {
                    return false;
                  }

                  final threshold =
                      notification.metrics.maxScrollExtent - 120;
                  if (notification.metrics.pixels >= threshold &&
                      notification.metrics.maxScrollExtent > 0) {
                    ref.read(wishlistProvider.notifier).loadNextPage();
                  }
                  return false;
                },
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: MediaQuery.of(context).padding.top +
                            kToolbarHeight +
                            16.h,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: GlassToggle(
                          selectedIndex: _selectedToggleIndex,
                          labels: const ['My Wishlist', 'Household Wishlist'],
                          onChanged: (index) {
                            setState(() {
                              _selectedToggleIndex = index;
                            });
                            // Update provider when toggle changes
                            final isMine = index == 0;
                            ref.read(wishlistProvider.notifier).setIsMine(isMine);
                          },
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: 16.h),
                    ),
                    SliverToBoxAdapter(
                      child: _buildHeader(wishlistState.totalCount),
                    ),
                    if (isEmpty) ...[
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.favorite_border,
                                size: 64.sp,
                                color: Colors.grey.shade400,
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                'No recipes in wishlist',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Add recipes to your wishlist to see them here',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ] else ...[
                      SliverPadding(
                        padding: EdgeInsets.only(top: 16.h),
                        sliver: SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          sliver: SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12.w,
                              mainAxisSpacing: 12.h,
                              childAspectRatio: 0.54,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final recipe = wishlistState.recipes[index];
                                return RecipeCard(
                                  recipe: recipe,
                                  onTap: () {
                                    context.push(
                                      AppRoutes.recipeDetailRoute(
                                        recipe.unifiedId,
                                      ),
                                    );
                                  },
                                );
                              },
                              childCount: wishlistState.recipes.length,
                            ),
                          ),
                        ),
                      ),
                      if (wishlistState.isLoadingMore) ...[
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ],
                      if (wishlistState.loadMoreError != null) ...[
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Center(
                              child: Text(
                                'Failed to load more recipes. Pull to refresh.',
                                style:
                                    Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ),
                        ),
                      ],
                      SliverToBoxAdapter(
                        child: SizedBox(height: 120.h),
                      ),
                    ],
                  ],
                ),
              );
            }

            return buildList(isEmpty: wishlistState.recipes.isEmpty);
          },
        ),
      ),
    );
  }
}
