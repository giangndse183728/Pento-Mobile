import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../../core/routing/app_routes.dart';
import '../../data/models/recipe_model.dart';
import '../providers/recipe_provider.dart';
import '../widgets/recipe_card.dart';
import '../widgets/recipe_filter_card.dart';

class RecipeScreen extends ConsumerStatefulWidget {
  const RecipeScreen({super.key});

  @override
  ConsumerState<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends ConsumerState<RecipeScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filters = ref.watch(recipeFiltersProvider);
    final asyncRecipes = ref.watch(recipesProvider);

    if (_searchController.text != filters.search) {
      _searchController.text = filters.search;
      _searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: _searchController.text.length),
      );
    }

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
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top +
                    kToolbarHeight +
                    16.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: RecipeFilterCard(
                  searchController: _searchController,
                  filters: filters,
                  totalCount: 0,
                  onSearchChanged: (value) {
                    ref.read(recipeFiltersProvider.notifier).state =
                        filters.copyWith(search: value);
                  },
                  onDifficultyChanged: (value) {
                    ref.read(recipeFiltersProvider.notifier).state =
                        filters.copyWith(
                      difficulty: value,
                      clearDifficulty: value == null,
                    );
                  },
                  onSortChanged: (value) {
                    ref.read(recipeFiltersProvider.notifier).state =
                        filters.copyWith(
                      sort: value,
                      clearSort: value == null,
                    );
                  },
                ),
              ),
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: RecipeFilterCard(
                  searchController: _searchController,
                  filters: filters,
                  totalCount: 0,
                  onSearchChanged: (value) {
                    ref.read(recipeFiltersProvider.notifier).state =
                        filters.copyWith(search: value);
                  },
                  onDifficultyChanged: (value) {
                    ref.read(recipeFiltersProvider.notifier).state =
                        filters.copyWith(
                      difficulty: value,
                      clearDifficulty: value == null,
                    );
                  },
                  onSortChanged: (value) {
                    ref.read(recipeFiltersProvider.notifier).state =
                        filters.copyWith(
                      sort: value,
                      clearSort: value == null,
                    );
                  },
                ),
              ),
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
            Widget buildList({required bool isEmpty}) {
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
                            kToolbarHeight +
                            16.h,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: RecipeFilterCard(
                          searchController: _searchController,
                          filters: filters,
                          totalCount: recipeState.totalCount,
                          onSearchChanged: (value) {
                            ref.read(recipeFiltersProvider.notifier).state =
                                filters.copyWith(search: value);
                          },
                          onDifficultyChanged: (value) {
                            ref.read(recipeFiltersProvider.notifier).state =
                                filters.copyWith(
                              difficulty: value,
                              clearDifficulty: value == null,
                            );
                          },
                          onSortChanged: (value) {
                            ref.read(recipeFiltersProvider.notifier).state =
                                filters.copyWith(
                              sort: value,
                              clearSort: value == null,
                            );
                          },
                        ),
                      ),
                    ),
                    if (isEmpty) ...[
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text(
                            'No recipes found',
                            style: Theme.of(context).textTheme.bodyLarge,
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

            return buildList(isEmpty: recipeState.recipes.isEmpty);
          },
        ),
      ),
    );
  }
}

