import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/subscription_models.dart';
import '../../data/repositories/subscription_repository.dart';

part 'subscription_provider.g.dart';

@Riverpod(keepAlive: true)
class Subscription extends _$Subscription {
  Subscription() : _repository = SubscriptionRepository();

  final SubscriptionRepository _repository;

  @override
  Future<List<SubscriptionItem>> build() async {
    return _repository.getSubscriptions();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_repository.getSubscriptions);
  }
}


