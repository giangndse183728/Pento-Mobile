import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/trade_offers_model.dart';
import '../../data/repositories/trade_offers_repository.dart';

part 'my_posts_provider.g.dart';

@Riverpod(keepAlive: true)
class MyPosts extends _$MyPosts {
  late final TradeOfferRepository _repository;

  @override
  FutureOr<List<MyPost>> build() async {
    _repository = TradeOfferRepository();
    return await _loadPosts();
  }

  Future<List<MyPost>> _loadPosts() async {
    return await _repository.getMyPosts();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_loadPosts);
  }
}







