import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/circle_icon_button.dart';
import '../providers/board_ui_provider.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../providers/compartment_provider.dart';
import '../widgets/add_compartment_tile.dart';
import '../widgets/compartment_column.dart';

class CompartmentScreen extends ConsumerStatefulWidget {
  const CompartmentScreen({super.key});

  @override
  ConsumerState<CompartmentScreen> createState() => _CompartmentScreenState();
}

class _CompartmentScreenState extends ConsumerState<CompartmentScreen> {
  PageController? _pageController;

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  void _handleZoomToggle() {
    final boardUiCtrl = ref.read(compartmentBoardUiProvider.notifier);
    boardUiCtrl.toggleZoom();
  }

  void _navigateToLogs(BuildContext context) {
    context.push(AppRoutes.foodItemLogs);
  }

  @override
  Widget build(BuildContext context) {
    final storageId =
        GoRouterState.of(context).uri.queryParameters['storageId'] ?? '';
    final storageName =
        GoRouterState.of(context).uri.queryParameters['storageName'] ??
        'Storage';

    if (storageId.isEmpty) {
      return AppScaffold(
        title: 'Compartment',
        forcePillMode: true,
        showAvatarButton: false,
        showNotificationButton: false,
        showBackButton: true,
        body: const Center(child: Text('Invalid storage ID')),
      );
    }

    final asyncCompartments = ref.watch(compartmentsProvider(storageId));
    final boardUi = ref.watch(compartmentBoardUiProvider);

    return AppScaffold(
      title: storageName,
      forcePillMode: true,
      showAvatarButton: false,
      showNotificationButton: false,
      showBackButton: true,
      actions: [
        CircleIconButton(
          icon: boardUi.isZoomed ? Icons.zoom_out : Icons.zoom_in,
          onTap: _handleZoomToggle,
        ),
        SizedBox(width: 2.w),
        CircleIconButton(
          icon: Icons.history,
          onTap: () => _navigateToLogs(context),
        ),
      ],
      body: asyncCompartments.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Failed to load compartments'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => ref
                    .read(compartmentsProvider(storageId).notifier)
                    .refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (compartmentState) {
          final compartments = compartmentState.compartments;
          if (compartments.isEmpty) {
            return Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + kToolbarHeight,
                bottom: 24.h,
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AddCompartmentTile(storageId: storageId),
                    SizedBox(height: 16.h),
                    Text(
                      'No compartments found. Create one to get started.',
                      style: AppTextStyles.inputHint,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          void requestNextPage() {
            if (!compartmentState.hasNext || compartmentState.isLoadingMore) {
              return;
            }
            ref.read(compartmentsProvider(storageId).notifier).loadNextPage();
          }

          void handlePageChanged(int index) {
            if (index < compartments.length - 1) {
              return;
            }
            requestNextPage();
          }

          // Zoomed mode: Carousel
          if (boardUi.isZoomed) {
            _pageController ??= PageController();

            return Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + kToolbarHeight,
                bottom: 24.h,
              ),
              child: PageView.builder(
                controller: _pageController,
                itemCount: compartments.length + 1,
                onPageChanged: handlePageChanged,
                itemBuilder: (context, index) {
                  if (index < compartments.length) {
                    final compartment = compartments[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: CompartmentColumn(
                        compartmentId: compartment.id,
                        storageId: storageId,
                        title: compartment.name,
                        subtitle: compartment.notes,
                        width: MediaQuery.of(context).size.width - 32.w,
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: AddCompartmentTile(
                        storageId: storageId,
                        width: MediaQuery.of(context).size.width - 32.w,
                      ),
                    );
                  }
                },
              ),
            );
          }

          // Normal mode: Horizontal scroll (zoomed out)
          return Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + kToolbarHeight,
              bottom: 24.h,
            ),
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.axis != Axis.horizontal) {
                  return false;
                }
                final threshold =
                    notification.metrics.maxScrollExtent - 160.w;
                if (notification.metrics.pixels >= threshold &&
                    notification.metrics.maxScrollExtent > 0) {
                  requestNextPage();
                }
                return false;
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 8.w),
                    for (final c in compartments) ...[
                      CompartmentColumn(
                        compartmentId: c.id,
                        storageId: storageId,
                        title: c.name,
                        subtitle: c.notes,
                        width: 220.w,
                        scale: 0.7,
                      ),
                      SizedBox(width: 12.w),
                    ],
                    if (compartmentState.isLoadingMore) ...[
                      SizedBox(
                        width: 220.w,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(width: 12.w),
                    ],
                    if (compartmentState.loadMoreError != null) ...[
                      SizedBox(
                        width: 220.w,
                        child: Text(
                          'Failed to load more compartments. Pull down to refresh.',
                          style: AppTextStyles.inputHint,
                        ),
                      ),
                      SizedBox(width: 12.w),
                    ],
                    AddCompartmentTile(storageId: storageId, width: 220.w),
                    SizedBox(width: 12.w),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
