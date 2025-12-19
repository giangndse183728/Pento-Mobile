import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../providers/trade_offers_provider.dart';
import '../../../../core/routing/app_routes.dart';
import '../widgets/trade_offers_card.dart';
import '../../../../core/widgets/circle_icon_button.dart';

class TradeOffersScreen extends ConsumerStatefulWidget {
  const TradeOffersScreen({super.key});

  @override
  ConsumerState<TradeOffersScreen> createState() =>
      _TradeOffersScreenState();
}

class _TradeOffersScreenState extends ConsumerState<TradeOffersScreen> {
  @override
  Widget build(BuildContext context) {
    final asyncTradeOffers = ref.watch(tradeOffersProvider);

    Future<void> refreshTradeOffers() =>
        ref.read(tradeOffersProvider.notifier).refresh();


    return AppScaffold(
      title: 'Trade Offers',
      padding: EdgeInsets.zero,
      actions: [
        CircleIconButton(
          icon: Icons.chat_outlined,
          onTap: () => context.push(AppRoutes.tradeSessions),
        ),
        CircleIconButton(
          icon: Icons.notifications_outlined,
          onTap: () => context.push(AppRoutes.notifications),
        ),
      ],
      body: RefreshIndicator(
        onRefresh: refreshTradeOffers,
        child: asyncTradeOffers.when(
          loading: () => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top +
                    kToolbarHeight +
                    16.h,
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Failed to load trade offers'),
                      SizedBox(height: 8.h),
                      ElevatedButton(
                        onPressed: refreshTradeOffers,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          data: (tradeOfferState) {
            Widget buildList({required bool isEmpty}) {
              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.axis != Axis.vertical) {
                    return false;
                  }
                  final data = asyncTradeOffers.valueOrNull;
                  if (data == null ||
                      data.isLoadingMore ||
                      !data.hasNext) {
                    return false;
                  }

                  final threshold =
                      notification.metrics.maxScrollExtent - 120;
                  if (notification.metrics.pixels >= threshold &&
                      notification.metrics.maxScrollExtent > 0) {
                    ref.read(tradeOffersProvider.notifier).loadNextPage();
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
                    if (isEmpty) ...[
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text(
                            'No trade offers found',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    ] else ...[
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final tradeOffer =
                                  tradeOfferState.tradeOffers[index];
                              return Padding(
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: TradeOfferCard(
                                  tradeOffer: tradeOffer,
                                  onTap: () {
                                    // TODO: Navigate to detail screen
                                  },
                                ),
                              );
                            },
                            childCount: tradeOfferState.tradeOffers.length,
                          ),
                        ),
                      ),
                      if (tradeOfferState.isLoadingMore) ...[
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ],
                      if (tradeOfferState.loadMoreError != null) ...[
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Center(
                              child: Text(
                                'Failed to load more offers. Pull to refresh.',
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

            return buildList(
              isEmpty: tradeOfferState.tradeOffers.isEmpty,
            );
          },
        ),
      ),
    );
  }
}
