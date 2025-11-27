import 'package:freezed_annotation/freezed_annotation.dart';

part 'grocery_models.freezed.dart';
part 'grocery_models.g.dart';

@freezed
class GroceryList with _$GroceryList {
  const factory GroceryList({
    required String id,
    required String name,
    @Default(false) bool isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _GroceryList;

  factory GroceryList.fromJson(Map<String, dynamic> json) =>
      _$GroceryListFromJson(json);
}

@freezed
class GroceryListDetail with _$GroceryListDetail {
  const factory GroceryListDetail({
    required String id,
    required String name,
    @Default([]) List<GroceryListItem> items,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _GroceryListDetail;

  factory GroceryListDetail.fromJson(Map<String, dynamic> json) =>
      _$GroceryListDetailFromJson(json);
}

@freezed
class GroceryListItem with _$GroceryListItem {
  const factory GroceryListItem({
    required String id,
    required String listId,
    String? foodRefId,
    String? foodRefName,
    String? foodRefImageUrl,
    String? customName,
    @Default(0) double quantity,
    String? unitId,
    String? unitName,
    String? priority,
    String? notes,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _GroceryListItem;

  factory GroceryListItem.fromJson(Map<String, dynamic> json) =>
      _$GroceryListItemFromJson(json);
}

