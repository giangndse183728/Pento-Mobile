// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_reference.freezed.dart';
part 'food_reference.g.dart';

@freezed
class FoodReference with _$FoodReference {
  const factory FoodReference({
    required String id,
    required String name,
    @JsonKey(name: 'foodGroup') String? foodGroup,
    @JsonKey(name: 'dataType') String? dataType,
    String? notes,
    @JsonKey(name: 'typicalShelfLifeDays_Pantry')
    @Default(0)
    int typicalShelfLifeDaysPantry,
    @JsonKey(name: 'typicalShelfLifeDays_Fridge')
    @Default(0)
    int typicalShelfLifeDaysFridge,
    @JsonKey(name: 'typicalShelfLifeDays_Freezer')
    @Default(0)
    int typicalShelfLifeDaysFreezer,
    String? addedBy,
    String? imageUrl,
    String? brand,
    String? barcode,
    @JsonKey(name: 'createdAt') DateTime? createdAt,
    @JsonKey(name: 'updatedAt') DateTime? updatedAt,
    @JsonKey(name: 'isDeleted') @Default(false) bool isDeleted,
  }) = _FoodReference;

  factory FoodReference.fromJson(Map<String, dynamic> json) =>
      _$FoodReferenceFromJson(json);
}
