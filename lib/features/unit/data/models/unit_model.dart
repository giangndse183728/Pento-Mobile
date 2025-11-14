// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'unit_model.freezed.dart';
part 'unit_model.g.dart';

@freezed
class Unit with _$Unit {
  const factory Unit({
    required String id,
    required String name,
    required String abbreviation,
    @JsonKey(name: 'toBaseFactor') required double toBaseFactor,
    required String type,
  }) = _Unit;

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);
}

