import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/unit_model.dart';
import '../../data/repositories/unit_repository.dart';

part 'unit_provider.g.dart';

@Riverpod(keepAlive: true)
class Units extends _$Units {
  late final UnitRepository _repository;

  @override
  FutureOr<List<Unit>> build() async {
    _repository = UnitRepository();
    return await _repository.getUnits();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _repository.getUnits();
    });
  }
}

