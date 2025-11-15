// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compartment_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompartmentImpl _$$CompartmentImplFromJson(Map<String, dynamic> json) =>
    _$CompartmentImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      storageId: json['storageId'] as String,
      notes: json['notes'] as String? ?? '',
    );

Map<String, dynamic> _$$CompartmentImplToJson(_$CompartmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'storageId': instance.storageId,
      'notes': instance.notes,
    };

_$CompartmentItemImpl _$$CompartmentItemImplFromJson(
  Map<String, dynamic> json,
) => _$CompartmentItemImpl(
  id: json['id'] as String,
  compartmentId: json['compartmentId'] as String?,
  householdId: json['householdId'] as String?,
  name: json['name'] as String,
  foodGroup: json['foodGroup'] as String?,
  imageUrl: json['imageUrl'] as String?,
  quantity: (json['quantity'] as num?)?.toInt() ?? 0,
  unitAbbreviation: json['unitAbbreviation'] as String? ?? '',
  expirationDateUtc: json['expirationDateUtc'] == null
      ? null
      : DateTime.parse(json['expirationDateUtc'] as String),
  version: (json['version'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$$CompartmentItemImplToJson(
  _$CompartmentItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'compartmentId': instance.compartmentId,
  'householdId': instance.householdId,
  'name': instance.name,
  'foodGroup': instance.foodGroup,
  'imageUrl': instance.imageUrl,
  'quantity': instance.quantity,
  'unitAbbreviation': instance.unitAbbreviation,
  'expirationDateUtc': instance.expirationDateUtc?.toIso8601String(),
  'version': instance.version,
};

_$CompartmentItemDetailImpl _$$CompartmentItemDetailImplFromJson(
  Map<String, dynamic> json,
) => _$CompartmentItemDetailImpl(
  id: json['id'] as String,
  foodReferenceName: json['foodReferenceName'] as String?,
  storageName: json['storageName'] as String?,
  storageType: json['storageType'] as String?,
  compartmentName: json['compartmentName'] as String?,
  name: json['name'] as String,
  foodGroup: json['foodGroup'] as String?,
  imageUrl: json['imageUrl'] as String?,
  quantity: (json['quantity'] as num?)?.toInt() ?? 0,
  unitAbbreviation: json['unitAbbreviation'] as String? ?? '',
  expirationDateUtc: json['expirationDateUtc'] == null
      ? null
      : DateTime.parse(json['expirationDateUtc'] as String),
  notes: json['notes'] as String?,
  sourceItemId: json['sourceItemId'] as String?,
  addedAt: json['addedAt'] == null
      ? null
      : DateTime.parse(json['addedAt'] as String),
  lastModifiedAt: json['lastModifiedAt'] == null
      ? null
      : DateTime.parse(json['lastModifiedAt'] as String),
  addedBy: json['addedBy'] == null
      ? null
      : FoodItemUser.fromJson(json['addedBy'] as Map<String, dynamic>),
  lastModifiedBy: json['lastModifiedBy'] == null
      ? null
      : FoodItemUser.fromJson(json['lastModifiedBy'] as Map<String, dynamic>),
  version: (json['version'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$$CompartmentItemDetailImplToJson(
  _$CompartmentItemDetailImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'foodReferenceName': instance.foodReferenceName,
  'storageName': instance.storageName,
  'storageType': instance.storageType,
  'compartmentName': instance.compartmentName,
  'name': instance.name,
  'foodGroup': instance.foodGroup,
  'imageUrl': instance.imageUrl,
  'quantity': instance.quantity,
  'unitAbbreviation': instance.unitAbbreviation,
  'expirationDateUtc': instance.expirationDateUtc?.toIso8601String(),
  'notes': instance.notes,
  'sourceItemId': instance.sourceItemId,
  'addedAt': instance.addedAt?.toIso8601String(),
  'lastModifiedAt': instance.lastModifiedAt?.toIso8601String(),
  'addedBy': instance.addedBy,
  'lastModifiedBy': instance.lastModifiedBy,
  'version': instance.version,
};

_$FoodItemUserImpl _$$FoodItemUserImplFromJson(Map<String, dynamic> json) =>
    _$FoodItemUserImpl(
      id: json['userId'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$$FoodItemUserImplToJson(_$FoodItemUserImpl instance) =>
    <String, dynamic>{
      'userId': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avatarUrl': instance.avatarUrl,
    };
