// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grocery_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroceryListImpl _$$GroceryListImplFromJson(Map<String, dynamic> json) =>
    _$GroceryListImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      isDeleted: json['isDeleted'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$GroceryListImplToJson(_$GroceryListImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$GroceryListDetailImpl _$$GroceryListDetailImplFromJson(
  Map<String, dynamic> json,
) => _$GroceryListDetailImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => GroceryListItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$GroceryListDetailImplToJson(
  _$GroceryListDetailImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'items': instance.items,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

_$GroceryListItemImpl _$$GroceryListItemImplFromJson(
  Map<String, dynamic> json,
) => _$GroceryListItemImpl(
  id: json['id'] as String,
  listId: json['listId'] as String,
  foodRefId: json['foodRefId'] as String?,
  foodRefName: json['foodRefName'] as String?,
  imageUrl: json['imageUrl'] as String?,
  customName: json['customName'] as String?,
  quantity: (json['quantity'] as num?)?.toDouble() ?? 0,
  unitId: json['unitId'] as String?,
  unitName: json['unitName'] as String?,
  priority: json['priority'] as String?,
  notes: json['notes'] as String?,
  isCompleted: json['isCompleted'] as bool?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$GroceryListItemImplToJson(
  _$GroceryListItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'listId': instance.listId,
  'foodRefId': instance.foodRefId,
  'foodRefName': instance.foodRefName,
  'imageUrl': instance.imageUrl,
  'customName': instance.customName,
  'quantity': instance.quantity,
  'unitId': instance.unitId,
  'unitName': instance.unitName,
  'priority': instance.priority,
  'notes': instance.notes,
  'isCompleted': instance.isCompleted,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};
