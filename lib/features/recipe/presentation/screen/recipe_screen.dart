import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../../core/routing/app_routes.dart';
import '../../data/models/recipe_model.dart';
import '../providers/recipe_provider.dart';
import '../widgets/recipe_card.dart';

class RecipeScreen extends ConsumerWidget {
  const RecipeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncRecipes = ref.watch(recipesProvider);

    Future<void> refreshRecipes() =>
        ref.read(recipesProvider.notifier).refresh();

    return AppScaffold(
      title: 'Recipes',
      padding: EdgeInsets.zero,
      body: RefreshIndicator(
        onRefresh: refreshRecipes,
        child: asyncRecipes.when(
          loading: () => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: const [
              SizedBox(
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
                height: MediaQuery.of(context).size.height * 0.4,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Failed to load recipes'),
                      SizedBox(height: 8.h),
                      ElevatedButton(
                        onPressed: refreshRecipes,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          data: (recipeState) {
            if (recipeState.recipes.isEmpty) {
              return ListView(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  Center(child: Text('No recipes found')),
                ],
              );
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.axis != Axis.vertical) {
                  return false;
                }
                final data = asyncRecipes.valueOrNull;
                if (data == null ||
                    data.isLoadingMore ||
                    !data.hasNext) {
                  return false;
                }

                final threshold =
                    notification.metrics.maxScrollExtent - 120;
                if (notification.metrics.pixels >= threshold &&
                    notification.metrics.maxScrollExtent > 0) {
                  ref.read(recipesProvider.notifier).loadNextPage();
                }
                return false;
              },
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).padding.top +
                          kToolbarHeight + 16.h,
                    ),
                  ),  
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    sliver: SliverGrid(
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                        childAspectRatio: 0.7,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final recipe = recipeState.recipes[index];
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
                        childCount: recipeState.recipes.length,
                      ),
                    ),
                  ),
                  if (recipeState.isLoadingMore) ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ],
                  if (recipeState.loadMoreError != null) ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Center(
                          child: Text(
                            'Failed to load more recipes. Pull to refresh.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                    ),
                  ],
                  SliverToBoxAdapter(
                    child: SizedBox(height: 120.h),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

