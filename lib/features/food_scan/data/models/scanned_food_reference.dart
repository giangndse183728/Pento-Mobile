// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'scanned_food_reference.freezed.dart';
part 'scanned_food_reference.g.dart';

@freezed
class ScannedFoodReference with _$ScannedFoodReference {
  const factory ScannedFoodReference({
    required String name,
    String? foodGroup,
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
    String? unitType,
    dynamic imageUrl,
    String? barcode,
    String? referenceId,
    @Default(false) bool isExistingReference,
  }) = _ScannedFoodReference;

  factory ScannedFoodReference.fromJson(Map<String, dynamic> json) =>
      _$ScannedFoodReferenceFromJson(json);
}

/// Response model for barcode scanning
@freezed
class ScanBarcodeResponse with _$ScanBarcodeResponse {
  const factory ScanBarcodeResponse({
    @Default(false) bool success,
    ScannedFoodReference? item,
    String? createdId,
    String? error,
  }) = _ScanBarcodeResponse;

  factory ScanBarcodeResponse.fromJson(Map<String, dynamic> json) =>
      _$ScanBarcodeResponseFromJson(json);
}

@freezed
class ScanFoodResponse with _$ScanFoodResponse {
  const factory ScanFoodResponse({
    @Default(true) bool success,
    @Default([]) List<ScannedFoodReference> items,
    @Default([]) List<String> createdIds,
    String? error,
  }) = _ScanFoodResponse;

  factory ScanFoodResponse.fromJson(Map<String, dynamic> json) =>
      _$ScanFoodResponseFromJson(json);
}


