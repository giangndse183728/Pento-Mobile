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
import '../widgets/compartment_filter_card.dart';
import '../../../../core/constants/app_enum.dart';
import '../../data/models/compartment_models.dart';

class CompartmentScreen extends ConsumerStatefulWidget {
  const CompartmentScreen({super.key});

  @override
  ConsumerState<CompartmentScreen> createState() => _CompartmentScreenState();
}

class _CompartmentScreenState extends ConsumerState<CompartmentScreen> {
  static const List<String> _foodGroups = [
    'Meat',
    'Seafood',
    'FruitsVegetables',
    'Dairy',
    'CerealGrainsPasta',
    'LegumesNutsSeeds',
    'FatsOils',
    'Confectionery',
    'Beverages',
    'Condiments',
    'MixedDishes',
  ];

  final TextEditingController _searchCtrl = TextEditingController();
  PageController? _pageController;
  ScrollController? _scrollController;
  int _currentNormalViewIndex = 0;
  List<Compartment> _compartments = [];
  bool _isScrollingToPosition = false;
  bool _shouldScrollToPosition = false;
  String _searchQuery = '';
  String? _selectedFoodGroup;
  FoodItemStatusFilter _statusFilter = FoodItemStatusFilter.all;
  QuantitySortOption _quantitySort = QuantitySortOption.none;

  @override
  void dispose() {
    _searchCtrl.dispose();
    _pageController?.dispose();
    _scrollController?.dispose();
    super.dispose();
  }

  void _handleZoomToggle(BuildContext context) {
    final boardUiCtrl = ref.read(compartmentBoardUiProvider.notifier);
    final boardUi = ref.read(compartmentBoardUiProvider);
    
    if (!boardUi.isZoomed) {
      // Zooming in: calculate which compartment is most visible/centered
      if (_scrollController != null && _scrollController!.hasClients && _compartments.isNotEmpty) {
        final scrollPosition = _scrollController!.offset;
        final screenWidth = MediaQuery.of(context).size.width;
        final viewportCenter = scrollPosition + (screenWidth / 2);
        
        // Calculate the center position of each compartment
        // Initial padding: 8.w
        // Each compartment: 220.w width + 12.w spacing
        final itemWidth = 220.w + 12.w;
        final compartmentWidth = 220.w;
        
        int closestIndex = 0;
        double minDistance = double.infinity;
        
        for (int i = 0; i < _compartments.length; i++) {
          // Calculate compartment center position
          final compartmentStart = 8.w + (i * itemWidth);
          final compartmentCenter = compartmentStart + (compartmentWidth / 2);
          
          // Find the compartment whose center is closest to viewport center
          final distance = (viewportCenter - compartmentCenter).abs();
          if (distance < minDistance) {
            minDistance = distance;
            closestIndex = i;
          }
        }
        
        _currentNormalViewIndex = closestIndex;
      }
      
      // Initialize or update PageController at the current position
      if (_pageController == null || !_pageController!.hasClients) {
        _pageController?.dispose();
        _pageController = PageController(initialPage: _currentNormalViewIndex);
      } else {
        // Jump to the correct page if controller already exists
        final currentPage = _pageController!.page?.round() ?? 0;
        if (currentPage != _currentNormalViewIndex) {
          _pageController!.jumpToPage(_currentNormalViewIndex);
        }
      }
    } else {
      // Zooming out: remember current page position and mark for scroll
      if (_pageController != null && _pageController!.hasClients) {
        final currentPage = _pageController!.page?.round() ?? 0;
        _currentNormalViewIndex = currentPage.clamp(0, _compartments.length - 1);
        _shouldScrollToPosition = true;
      }
    }
    
    boardUiCtrl.toggleZoom();
  }

  void _navigateToLogs(BuildContext context) {
    context.push(AppRoutes.foodItemLogs);
  }

  Widget _buildZoomedView(
    BuildContext context,
    List<Compartment> compartments,
    String storageId,
    void Function(int) handlePageChanged,
  ) {
    // PageController should already be initialized with correct page in _handleZoomToggle
    if (_pageController == null) {
      _pageController = PageController(initialPage: _currentNormalViewIndex);
    }

    return PageView.builder(
      key: const ValueKey('zoomed_view'),
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
    );
  }

  Widget _buildNormalView(
    BuildContext context,
    List<Compartment> compartments,
    String storageId,
    CompartmentListState compartmentState,
    void Function() requestNextPage, {
    required String searchQuery,
    required String? foodGroupFilter,
    required FoodItemStatusFilter statusFilter,
    required QuantitySortOption quantitySort,
  }) {
    // Initialize scroll controller and scroll to saved position
    if (_scrollController == null) {
      _scrollController = ScrollController();
      
      // Add listener to track scroll position and update index
      _scrollController!.addListener(() {
        if (_isScrollingToPosition || !_scrollController!.hasClients || _compartments.isEmpty) {
          return;
        }
        
        final scrollPosition = _scrollController!.offset;
        final viewportWidth = _scrollController!.position.viewportDimension;
        final viewportCenter = scrollPosition + (viewportWidth / 2);
        
        // Calculate the center position of each compartment
        final itemWidth = 220.w + 12.w;
        final compartmentWidth = 220.w;
        
        int closestIndex = 0;
        double minDistance = double.infinity;
        
        for (int i = 0; i < _compartments.length; i++) {
          final compartmentStart = 8.w + (i * itemWidth);
          final compartmentCenter = compartmentStart + (compartmentWidth / 2);
          final distance = (viewportCenter - compartmentCenter).abs();
          
          if (distance < minDistance) {
            minDistance = distance;
            closestIndex = i;
          }
        }
        
        if (closestIndex != _currentNormalViewIndex) {
          _currentNormalViewIndex = closestIndex;
        }
      });
    }
    
    // Scroll to center the saved compartment when zooming out
    if (_shouldScrollToPosition) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController != null && 
            _scrollController!.hasClients && 
            compartments.isNotEmpty &&
            _currentNormalViewIndex < compartments.length &&
            mounted) {
          final screenWidth = MediaQuery.of(context).size.width;
          final itemWidth = 220.w + 12.w;
          final compartmentWidth = 220.w;
          
          // Calculate compartment center position
          final compartmentStart = 8.w + (_currentNormalViewIndex * itemWidth);
          final compartmentCenter = compartmentStart + (compartmentWidth / 2);
          
          // Calculate target scroll position to center the compartment
          final targetOffset = compartmentCenter - (screenWidth / 2);
          
          // Clamp to valid scroll range
          final clampedOffset = targetOffset.clamp(
            0.0,
            _scrollController!.position.maxScrollExtent,
          );
          
          if ((clampedOffset - _scrollController!.offset).abs() > 1.0) {
            _isScrollingToPosition = true;
            _scrollController!.animateTo(
              clampedOffset,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
            ).then((_) {
              if (mounted) {
                _isScrollingToPosition = false;
                _shouldScrollToPosition = false;
              }
            });
          } else {
            _shouldScrollToPosition = false;
          }
        }
      });
    }

    return NotificationListener<ScrollNotification>(
      key: const ValueKey('normal_view'),
      onNotification: (notification) {
        if (notification.metrics.axis != Axis.horizontal) {
          return false;
        }
        final threshold = notification.metrics.maxScrollExtent - 160.w;
        if (notification.metrics.pixels >= threshold &&
            notification.metrics.maxScrollExtent > 0) {
          requestNextPage();
        }
        return false;
      },
      child: SingleChildScrollView(
        controller: _scrollController,
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
                searchQuery: searchQuery,
                foodGroupFilter: foodGroupFilter,
                statusFilter: statusFilter,
                quantitySort: quantitySort,
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
    );
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
          onTap: () => _handleZoomToggle(context),
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
          _compartments = compartments;
          
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

          return Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + kToolbarHeight,
              bottom: 24.h,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CompartmentFilterCard(
                    isZoomed: boardUi.isZoomed,
                    searchController: _searchCtrl,
                    searchQuery: _searchQuery,
                    onSearchChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    foodGroups: _foodGroups,
                    selectedFoodGroup: _selectedFoodGroup,
                    onFoodGroupChanged: (value) {
                      setState(() {
                        _selectedFoodGroup = value;
                      });
                    },
                    statusFilter: _statusFilter,
                    onStatusChanged: (value) {
                      setState(() {
                        _statusFilter = value;
                      });
                    },
                    quantitySort: _quantitySort,
                    onQuantityChanged: (value) {
                      setState(() {
                        _quantitySort = value;
                      });
                    },
                  ),
                ),
                if (!boardUi.isZoomed) SizedBox(height: 16.h),
                Expanded(
                  child: Stack(
                    children: [
                      // Normal view (zoomed out)
                      IgnorePointer(
                        ignoring: boardUi.isZoomed,
                        child: AnimatedOpacity(
                          opacity: boardUi.isZoomed ? 0.0 : 1.0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: AnimatedScale(
                            scale: boardUi.isZoomed ? 0.85 : 1.0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: _buildNormalView(
                              context,
                              compartments,
                              storageId,
                              compartmentState,
                              requestNextPage,
                              searchQuery: _searchQuery,
                              foodGroupFilter: _selectedFoodGroup,
                              statusFilter: _statusFilter,
                              quantitySort: _quantitySort,
                            ),
                          ),
                        ),
                      ),
                      // Zoomed view (carousel)
                      IgnorePointer(
                        ignoring: !boardUi.isZoomed,
                        child: AnimatedOpacity(
                          opacity: boardUi.isZoomed ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: AnimatedScale(
                            scale: boardUi.isZoomed ? 1.0 : 0.85,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: _buildZoomedView(
                              context,
                              compartments,
                              storageId,
                              handlePageChanged,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
