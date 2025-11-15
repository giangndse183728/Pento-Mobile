import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/food_reference.dart';
import '../../data/repositories/food_repository.dart';

part 'food_reference_provider.g.dart';

@immutable
class FoodReferenceFilter {
  const FoodReferenceFilter({
    this.page = 1,
    this.pageSize = 20,
    this.search,
    this.foodGroup,
  });

  final int page;
  final int pageSize;
  final String? search;
  final String? foodGroup;

  Map<String, dynamic> toQuery() => {
    'page': page,
    'pageSize': pageSize,
    if (search != null && search!.isNotEmpty) 'search': search,
    if (foodGroup != null && foodGroup!.isNotEmpty) 'foodGroup': foodGroup,
  };

  FoodReferenceFilter copyWith({
    int? page,
    int? pageSize,
    String? search,
    String? foodGroup,
  }) {
    return FoodReferenceFilter(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      search: search ?? this.search,
      foodGroup: foodGroup ?? this.foodGroup,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is FoodReferenceFilter &&
        other.page == page &&
        other.pageSize == pageSize &&
        other.search == search &&
        other.foodGroup == foodGroup;
  }

  @override
  int get hashCode =>
      Object.hash(page, pageSize, search ?? '', foodGroup ?? '');
}

@riverpod
class FoodReferences extends _$FoodReferences {
  late final FoodRepository _repository;
  late FoodReferenceFilter _filter;

  @override
  FutureOr<List<FoodReference>> build(FoodReferenceFilter filter) async {
    _repository = FoodRepository();
    _filter = filter;
    return await _repository.getFoodReferences(
      page: filter.page,
      pageSize: filter.pageSize,
      search: filter.search,
      foodGroup: filter.foodGroup,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _repository.getFoodReferences(
        page: _filter.page,
        pageSize: _filter.pageSize,
        search: _filter.search,
        foodGroup: _filter.foodGroup,
      );
    });
  }
}
