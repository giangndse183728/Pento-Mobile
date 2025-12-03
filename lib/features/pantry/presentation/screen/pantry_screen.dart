import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/layouts/app_scaffold.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/circle_icon_button.dart';
import '../../data/models/storage_models.dart';
import '../../data/repositories/pantry_repository.dart';
import '../providers/pantry_provider.dart';
import '../widgets/add_storage_card.dart';
import '../widgets/freezer_card.dart';
import '../widgets/small_storage_card.dart';
import '../../../log/presentation/providers/food_item_log_summary_provider.dart';
import '../../../log/presentation/widgets/food_item_log_summary_chart.dart';

class PantryScreen extends ConsumerWidget {
  const PantryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStorages = ref.watch(pantryProvider);
    Future<void> refreshStorages() async {
      await ref.read(pantryProvider.notifier).refresh();
      await ref.read(foodItemLogSummaryDataProvider.notifier).refresh();
    }

    Future<void> onAddStorage([StorageType initialType = StorageType.pantry]) async {
      final nameCtrl = TextEditingController();
      StorageType selected = initialType;
      final repo = PantryRepository();
      final ok = await showDialog<bool>(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Add Storage'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: 12),
                StatefulBuilder(
                  builder: (ctx, setState) {
                    return DropdownButton<StorageType>(
                      value: selected,
                      items: const [
                        DropdownMenuItem(
                          value: StorageType.pantry,
                          child: Text('Pantry'),
                        ),
                        DropdownMenuItem(
                          value: StorageType.fridge,
                          child: Text('Fridge'),
                        ),
                        DropdownMenuItem(
                          value: StorageType.freezer,
                          child: Text('Freezer'),
                        ),
                      ],
                      onChanged: (v) {
                        if (v != null) {
                          setState(() => selected = v);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Add'),
              ),
            ],
          );
        },
      );
      if (ok == true && nameCtrl.text.trim().isNotEmpty) {
        await repo.createStorage(
          name: nameCtrl.text.trim(),
          type: selected,
        );
        if (context.mounted) {
          await ref.read(pantryProvider.notifier).refresh();
        }
      }
    }

    String labelForType(StorageType type) {
      switch (type) {
        case StorageType.pantry:
          return 'Add Pantry';
        case StorageType.fridge:
          return 'Add Fridge';
        case StorageType.freezer:
          return 'Add Freezer';
      }
    }

    Widget buildTile({
      required int index,
      required List<Storage> storages,
      required StorageType type,
    }) {
      if (index >= storages.length) {
        return AddStorageCard(
          label: labelForType(type),
          onTap: () => onAddStorage(type),
        );
      }
      return SmallStorageCard(
        storage: storages[index],
      );
    }

    int totalItemsFor(List<Storage> storages) => storages.length + 1;

    return AppScaffold(
      title: 'Pantry',
      actions: [
        CircleIconButton(
          icon: Icons.search,
          onTap: () {
            context.push(AppRoutes.foodItems);
          },
        ),
        CircleIconButton(
          icon: Icons.notifications_outlined,
          onTap: () {
            // TODO: Navigate to notifications screen once available
          },
        ),
      ],
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.axis != Axis.vertical) {
            return false;
          }
          final data = asyncStorages.valueOrNull;
          if (data == null || data.isLoadingMore || !data.hasNext) {
            return false;
          }
          final threshold = notification.metrics.maxScrollExtent - 120;
          if (notification.metrics.pixels >= threshold &&
              notification.metrics.maxScrollExtent > 0) {
            ref.read(pantryProvider.notifier).loadNextPage();
          }
          return false;
        },
        child: RefreshIndicator(
          onRefresh: refreshStorages,
          child: asyncStorages.when(
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
                      const Text('Failed to load pantry items'),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: refreshStorages,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          data: (pantryState) {
            final storages = pantryState.storages;
            if (storages.isEmpty) {
              return Stack(
                children: [
                  ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: const [
                      SizedBox(height: 160),
                      Center(child: Text('No storages found')),
                    ],
                  ),
                ],
              );
            }
            final freezer = storages
                .where((s) => s.type == StorageType.freezer)
                .toList();
            final pantryItems = storages
                .where((s) => s.type == StorageType.pantry)
                .toList();
            final fridgeItems = storages
                .where((s) => s.type == StorageType.fridge)
                .toList();

            void handlePageChanged(int index, int totalPages) {
              if (totalPages == 0 ||
                  index < totalPages - 1 ||
                  pantryState.isLoadingMore ||
                  !pantryState.hasNext) {
                return;
              }
              ref.read(pantryProvider.notifier).loadNextPage();
            }

            return Stack(
              children: [
                ListView(
                  padding: EdgeInsets.only(bottom: 24.h),
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).padding.top +
                          kToolbarHeight,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
                      child: FoodItemLogSummaryChart(),
                    ),
                    if (pantryItems.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'Pantry',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            fontFamily: 'MomoTrustDisplay',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 120,
                        child: Builder(
                          builder: (context) {
                            final totalItems = totalItemsFor(pantryItems);
                            final pageCount = (totalItems / 2).ceil();
                            return PageView.builder(
                              controller:
                                  PageController(viewportFraction: 0.92),
                              padEnds: false,
                              itemCount: pageCount,
                              onPageChanged: (index) => handlePageChanged(
                                index,
                                pageCount,
                              ),
                              itemBuilder: (context, pageIndex) {
                                final start = pageIndex * 2;
                                final end =
                                    (start + 2).clamp(0, totalItems);
                                if (start >= pantryItems.length &&
                                    end - start == 1) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: AddStorageCard(
                                      label: labelForType(StorageType.pantry),
                                      onTap: () => onAddStorage(
                                        StorageType.pantry,
                                      ),
                                    ),
                                  );
                                }
                                final first = buildTile(
                                  index: start,
                                  storages: pantryItems,
                                  type: StorageType.pantry,
                                );
                                final bool hasSecond = end - start > 1;
                                final Widget second = hasSecond
                                    ? buildTile(
                                        index: start + 1,
                                        storages: pantryItems,
                                        type: StorageType.pantry,
                                      )
                                    : const SizedBox.shrink();
                                return Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Row(
                                    children: [
                                      Expanded(child: first),
                                      const SizedBox(width: 12),
                                      Expanded(child: second),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    if (fridgeItems.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'Fridge',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            fontFamily: 'MomoTrustDisplay',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 120,
                        child: Builder(
                          builder: (context) {
                            final totalItems = totalItemsFor(fridgeItems);
                            final pageCount = (totalItems / 2).ceil();
                            return PageView.builder(
                              controller:
                                  PageController(viewportFraction: 0.92),
                              padEnds: false,
                              itemCount: pageCount,
                              onPageChanged: (index) => handlePageChanged(
                                index,
                                pageCount,
                              ),
                              itemBuilder: (context, pageIndex) {
                                final start = pageIndex * 2;
                                final end =
                                    (start + 2).clamp(0, totalItems);
                                if (start >= fridgeItems.length &&
                                    end - start == 1) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: AddStorageCard(
                                      label: labelForType(StorageType.fridge),
                                      onTap: () => onAddStorage(
                                        StorageType.fridge,
                                      ),
                                    ),
                                  );
                                }
                                final first = buildTile(
                                  index: start,
                                  storages: fridgeItems,
                                  type: StorageType.fridge,
                                );
                                final bool hasSecond = end - start > 1;
                                final Widget second = hasSecond
                                    ? buildTile(
                                        index: start + 1,
                                        storages: fridgeItems,
                                        type: StorageType.fridge,
                                      )
                                    : const SizedBox.shrink();
                                return Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Row(
                                    children: [
                                      Expanded(child: first),
                                      const SizedBox(width: 12),
                                      Expanded(child: second),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    if (freezer.isNotEmpty) ...[
                      SizedBox(
                        height: 120,
                        child: Builder(
                          builder: (context) {
                            final totalItems = freezer.length + 1;
                            final pageCount = totalItems;
                            return PageView.builder(
                              controller:
                                  PageController(viewportFraction: 0.9),
                              padEnds: false,
                              itemCount: pageCount,
                              onPageChanged: (index) => handlePageChanged(
                                index,
                                pageCount,
                              ),
                              itemBuilder: (context, index) {
                                if (index >= freezer.length) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: AddStorageCard(
                                      label: labelForType(StorageType.freezer),
                                      onTap: () => onAddStorage(
                                        StorageType.freezer,
                                      ),
                                    ),
                                  );
                                }
                                final storage = freezer[index];
                                return Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: FreezerCard(storage: storage),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (pantryState.isLoadingMore) ...[
                      const SizedBox(height: 12),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                    if (pantryState.loadMoreError != null) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Text(
                          'Failed to load more storages. Pull to refresh.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                    const SizedBox(height: 80),
                  ],
                ),
         
              ],
            );
          },
        ),
      ),
    ),
  );
  }
}
