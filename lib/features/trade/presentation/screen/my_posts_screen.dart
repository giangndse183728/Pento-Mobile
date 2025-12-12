import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../../core/routing/app_routes.dart';
import '../providers/my_posts_provider.dart';
import '../widgets/my_post_card.dart';

class MyPostsScreen extends ConsumerStatefulWidget {
  const MyPostsScreen({super.key});

  @override
  ConsumerState<MyPostsScreen> createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends ConsumerState<MyPostsScreen> {
  @override
  Widget build(BuildContext context) {
    final asyncMyPosts = ref.watch(myPostsProvider);

    Future<void> refreshMyPosts() =>
        ref.read(myPostsProvider.notifier).refresh();

    return AppScaffold(
      title: 'My Posts',
      padding: EdgeInsets.zero,
      actions: [
        TextButton(
          onPressed: () => context.push(AppRoutes.createTradePost),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.blueGray,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add,
                size: 18.sp,
                color: AppColors.blueGray,
              ),
              SizedBox(width: 4.w),
              Text(
                'Create Post',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
      body: RefreshIndicator(
        onRefresh: refreshMyPosts,
        child: asyncMyPosts.when(
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
                      const Text('Failed to load posts'),
                      SizedBox(height: 8.h),
                      ElevatedButton(
                        onPressed: refreshMyPosts,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          data: (posts) {
            if (posts.isEmpty) {
              return CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).padding.top +
                          kToolbarHeight +
                          16.h,
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.post_add_outlined,
                            size: 64.w,
                            color: AppColors.blueGray.withValues(alpha: 0.5),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'No posts yet',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blueGray,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Create your first trade post',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.blueGray.withValues(alpha: 0.7),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          ElevatedButton.icon(
                            onPressed: () => context.push(AppRoutes.createTradePost),
                            icon: Icon(Icons.add, size: 18.sp),
                            label: const Text('Create Post'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.blueGray,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                                vertical: 12.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).padding.top +
                        kToolbarHeight +
                        16.h,
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final post = posts[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: MyPostCard(
                            post: post,
                            onTap: () {
                              context.push(
                                AppRoutes.postRequestsRoute(
                                  post.offerId,
                                  postTitle: post.foodName,
                                ),
                              );
                            },
                          ),
                        );
                      },
                      childCount: posts.length,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: 120.h),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}







