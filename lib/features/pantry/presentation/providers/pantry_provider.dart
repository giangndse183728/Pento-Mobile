import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/storage_models.dart';
import '../../data/repositories/pantry_repository.dart';

part 'pantry_provider.g.dart';

@riverpod
class Pantry extends _$Pantry {
  late final PantryRepository _repository;

  @override
  FutureOr<List<Storage>> build() async {
    _repository = PantryRepository();
    return await _repository.getStorages();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _repository.getStorages();
    });
  }
}


