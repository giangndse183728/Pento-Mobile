import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/exceptions/network_exception.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../../core/utils/toast_helper.dart';
import '../../data/models/grocery_models.dart';
import '../providers/grocery_provider.dart';
import '../providers/grocery_list_detail_provider.dart';
import '../widgets/grocery_list_card.dart';
import '../widgets/add_grocery_dialog.dart';
import '../widgets/add_grocery_item_sheet.dart';
import '../widgets/grocery_items_list.dart';

class GroceryScreen extends ConsumerWidget {
  const GroceryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groceryAsync = ref.watch(groceryProvider);
    final topSpacing = MediaQuery.of(context).padding.top + kToolbarHeight;

    return AppScaffold(
      title: 'Grocery Lists',
      forcePillMode: true,
      showBackButton: true,
      body: groceryAsync.when(
        data: (groceryLists) {
          return RefreshIndicator(
            onRefresh: () => ref.read(groceryProvider.notifier).refresh(),
            child: groceryLists.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: topSpacing),
                    children: [
                      SizedBox(height: 40.h),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 80.sp,
                              color: AppColors.powderBlue,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'No grocery lists yet',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Tap + to create your first list',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black38,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(
                      top: topSpacing,
                      bottom: 80.h,
                    ),
                    itemCount: groceryLists.length,
                    itemBuilder: (context, index) {
                      final groceryList = groceryLists[index];
                      final detailAsync =
                          ref.watch(groceryListItemsProvider(groceryList.id));

                      final body = detailAsync.when(
                        data: (detail) => GroceryItemsList(
                          items: detail.items,
                          onEdit: (item) => _showEditItemSheet(context, item),
                          onDelete: (item) =>
                              _confirmDeleteItem(context, ref, item),
                        ),
                        loading: () => const GroceryItemsLoading(),
                        error: (error, stack) => GroceryItemsError(
                          onRetry: () => ref
                              .read(
                                groceryListItemsProvider(groceryList.id).notifier,
                              )
                              .refresh(),
                        ),
                      );

                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 6.h,
                        ),
                        child: GroceryListCard(
                          groceryList: groceryList,
                          body: body,
                          onAddItem: () =>
                              _showAddItemSheet(context, groceryList.id),
                          onEdit: () => _showEditDialog(
                            context,
                            ref,
                            groceryList.id,
                            groceryList.name,
                          ),
                          onDelete: () {
                            _showDeleteConfirmation(
                              context,
                              ref,
                              groceryList.id,
                              groceryList.name,
                            );
                          },
                        ),
                      );
                    },
                  ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: AppColors.blueGray,
          ),
        ),
        error: (error, stack) => Center(
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
                'Failed to load grocery lists',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () => ref.read(groceryProvider.notifier).refresh(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blueGray,
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            _showAddDialog(context, ref);
          },
          icon: Icon(
            Icons.add,
            color: AppColors.blueGray,
            size: 24.sp,
          ),
        ),
        SizedBox(width: 8.w),
      ],
    );
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (dialogContext) => AddGroceryDialog(
        onAdd: (name) async {
          if (dialogContext.mounted) {
            Navigator.pop(dialogContext);
          }
          try {
            await ref.read(groceryProvider.notifier).createGroceryList(name: name);
          } on NetworkException catch (e) {
            if (context.mounted) {
              ToastHelper.showError(context, e.message);
            }
          } catch (e) {
            if (context.mounted) {
              ToastHelper.showError(
                context,
                'Failed to create grocery list. Please try again.',
              );
            }
          }
        },
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    WidgetRef ref,
    String id,
    String currentName,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AddGroceryDialog(
        initialName: currentName,
        isEdit: true,
        onAdd: (name) async {
          if (dialogContext.mounted) {
            Navigator.pop(dialogContext);
          }
          try {
            await ref.read(groceryProvider.notifier).updateGroceryList(
                  id: id,
                  name: name,
                );
          } on NetworkException catch (e) {
            if (context.mounted) {
              ToastHelper.showError(context, e.message);
            }
          } catch (e) {
            if (context.mounted) {
              ToastHelper.showError(
                context,
                'Failed to update grocery list. Please try again.',
              );
            }
          }
        },
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    String id,
    String name,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Grocery List'),
        content: Text('Are you sure you want to delete "$name"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await ref.read(groceryProvider.notifier).deleteGroceryList(id: id);
                if (dialogContext.mounted) {
                  Navigator.pop(dialogContext);
                }
              } on NetworkException catch (e) {
                if (dialogContext.mounted) {
                  Navigator.pop(dialogContext);
                  ToastHelper.showError(context, e.message);
                }
              } catch (e) {
                if (dialogContext.mounted) {
                  Navigator.pop(dialogContext);
                  ToastHelper.showError(
                    context,
                    'Failed to delete grocery list. Please try again.',
                  );
                }
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showAddItemSheet(BuildContext context, String listId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddGroceryListItemSheet(listId: listId),
    );
  }

  void _showEditItemSheet(BuildContext context, GroceryListItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => EditGroceryListItemSheet(item: item),
    );
  }

  Future<void> _confirmDeleteItem(
    BuildContext context,
    WidgetRef ref,
    GroceryListItem item,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete item'),
        content: Text(
          'Remove "${_resolveItemName(item)}" from this list?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await ref
          .read(groceryListItemsProvider(item.listId).notifier)
          .deleteItem(item.id);
      if (context.mounted) {
        ToastHelper.showSuccess(context, 'Item removed');
      }
    } on NetworkException catch (e) {
      if (context.mounted) {
        ToastHelper.showError(context, e.message);
      }
    } catch (_) {
      if (context.mounted) {
        ToastHelper.showError(context, 'Failed to delete item');
      }
    }
  }

  String _resolveItemName(GroceryListItem item) {
    if (item.customName != null && item.customName!.isNotEmpty) {
      return item.customName!;
    }
    if (item.foodRefName != null && item.foodRefName!.isNotEmpty) {
      return item.foodRefName!;
    }
    return 'Unnamed item';
  }
}
