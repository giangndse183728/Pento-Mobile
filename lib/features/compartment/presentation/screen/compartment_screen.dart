import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/circle_icon_button.dart';
import '../providers/board_ui_provider.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../providers/compartment_provider.dart';
import '../widgets/add_compartment_tile.dart';
import '../widgets/compartment_column.dart';
import '../../data/models/compartment_models.dart';

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
        data: (compartments) {
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
                itemBuilder: (context, index) {
                  if (index < compartments.length) {
                    final compartment = compartments[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: CompartmentColumn(
                        compartmentId: compartment.id,
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 8.w),
                  ...compartments.map(
                    (c) => Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: _buildDraggableCompartment(c),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: AddCompartmentTile(
                      storageId: storageId,
                      width: 200.w,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDraggableCompartment(Compartment compartment) {
    return DragTarget<Map<String, dynamic>>(
      onWillAcceptWithDetails: (details) => true,
      onAcceptWithDetails: (details) async {
        final data = details.data;
        final foodItemId = data['foodItemId'] as String;
        final sourceCompartmentId = data['compartmentId'] as String;
        final version = data['version'] as int;

        if (sourceCompartmentId != compartment.id) {
          // Move item to new compartment
          try {
            await ref
                .read(compartmentItemsProvider(sourceCompartmentId).notifier)
                .updateFoodItemCompartment(
                  foodItemId: foodItemId,
                  version: version,
                  newCompartmentId: compartment.id,
                );
            
            // Refresh both compartments
            if (mounted) {
              ref.invalidate(compartmentItemsProvider(sourceCompartmentId));
              ref.invalidate(compartmentItemsProvider(compartment.id));
            }
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to move item: $e'),
                  backgroundColor: Colors.red.shade400,
                ),
              );
            }
          }
        }
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: candidateData.isNotEmpty
                ? Border.all(
                    color: AppColors.blueGray.withValues(alpha: 0.5),
                    width: 2,
                  )
                : null,
          ),
          child: CompartmentColumn(
            compartmentId: compartment.id,
            title: compartment.name,
            subtitle: compartment.notes,
            width: 200.w,
            scale: 0.7,
          ),
        );
      },
    );
  }

}
