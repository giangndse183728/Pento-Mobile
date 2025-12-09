// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_plan_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaginatedMealPlanResponseImpl _$$PaginatedMealPlanResponseImplFromJson(
  Map<String, dynamic> json,
) => _$PaginatedMealPlanResponseImpl(
  currentPage: (json['currentPage'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
  totalCount: (json['totalCount'] as num).toInt(),
  hasPrevious: json['hasPrevious'] as bool,
  hasNext: json['hasNext'] as bool,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => MealPlanItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$PaginatedMealPlanResponseImplToJson(
  _$PaginatedMealPlanResponseImpl instance,
) => <String, dynamic>{
  'currentPage': instance.currentPage,
  'totalPages': instance.totalPages,
  'pageSize': instance.pageSize,
  'totalCount': instance.totalCount,
  'hasPrevious': instance.hasPrevious,
  'hasNext': instance.hasNext,
  'items': instance.items,
};

_$MealPlanItemImpl _$$MealPlanItemImplFromJson(Map<String, dynamic> json) =>
    _$MealPlanItemImpl(
      id: json['id'] as String,
      householdId: json['householdId'] as String?,
      name: json['name'] as String,
      scheduledDate: json['scheduledDate'] as String,
      mealType: json['mealType'] as String,
      servings: (json['servings'] as num?)?.toInt() ?? 1,
      notes: json['notes'] as String?,
      createdBy: json['createdBy'] as String?,
      createdOnUtc: json['createdOnUtc'] == null
          ? null
          : DateTime.parse(json['createdOnUtc'] as String),
      updatedOnUtc: json['updatedOnUtc'] == null
          ? null
          : DateTime.parse(json['updatedOnUtc'] as String),
      recipes:
          (json['recipes'] as List<dynamic>?)
              ?.map((e) => MealPlanRecipe.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      foodItems:
          (json['foodItems'] as List<dynamic>?)
              ?.map((e) => MealPlanFoodItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$MealPlanItemImplToJson(_$MealPlanItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'householdId': instance.householdId,
      'name': instance.name,
      'scheduledDate': instance.scheduledDate,
      'mealType': instance.mealType,
      'servings': instance.servings,
      'notes': instance.notes,
      'createdBy': instance.createdBy,
      'createdOnUtc': instance.createdOnUtc?.toIso8601String(),
      'updatedOnUtc': instance.updatedOnUtc?.toIso8601String(),
      'recipes': instance.recipes,
      'foodItems': instance.foodItems,
      'isDeleted': instance.isDeleted,
    };

_$MealPlanRecipeImpl _$$MealPlanRecipeImplFromJson(Map<String, dynamic> json) =>
    _$MealPlanRecipeImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      servings: (json['servings'] as num?)?.toInt() ?? 1,
      difficultyLevel: json['difficultyLevel'] as String?,
      status: json['recipeStatus'] as String?,
    );

Map<String, dynamic> _$$MealPlanRecipeImplToJson(
  _$MealPlanRecipeImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'imageUrl': instance.imageUrl,
  'servings': instance.servings,
  'difficultyLevel': instance.difficultyLevel,
  'recipeStatus': instance.status,
};

_$MealPlanFoodItemImpl _$$MealPlanFoodItemImplFromJson(
  Map<String, dynamic> json,
) => _$MealPlanFoodItemImpl(
  id: json['id'] as String,
  reservationId: json['reservationId'] as String?,
  name: json['name'] as String,
  foodReferenceName: json['foodReferenceName'] as String?,
  foodGroup: json['foodGroup'] as String?,
  imageUrl: json['imageUrl'] as String?,
  quantity: (json['quantity'] as num?)?.toDouble() ?? 0,
  unitAbbreviation: json['unitAbbreviation'] as String?,
  expirationDate: json['expirationDate'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$$MealPlanFoodItemImplToJson(
  _$MealPlanFoodItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'reservationId': instance.reservationId,
  'name': instance.name,
  'foodReferenceName': instance.foodReferenceName,
  'foodGroup': instance.foodGroup,
  'imageUrl': instance.imageUrl,
  'quantity': instance.quantity,
  'unitAbbreviation': instance.unitAbbreviation,
  'expirationDate': instance.expirationDate,
  'status': instance.status,
};

_$MissingIngredientImpl _$$MissingIngredientImplFromJson(
  Map<String, dynamic> json,
) => _$MissingIngredientImpl(
  ingredientId: json['ingredientId'] as String,
  foodRefId: json['foodRefId'] as String,
  name: json['name'] as String,
  requiredQuantity: (json['requiredQuantity'] as num).toDouble(),
  unitId: json['unitId'] as String,
  unitAbbreviation: json['unitAbbreviation'] as String,
);

Map<String, dynamic> _$$MissingIngredientImplToJson(
  _$MissingIngredientImpl instance,
) => <String, dynamic>{
  'ingredientId': instance.ingredientId,
  'foodRefId': instance.foodRefId,
  'name': instance.name,
  'requiredQuantity': instance.requiredQuantity,
  'unitId': instance.unitId,
  'unitAbbreviation': instance.unitAbbreviation,
};

_$RecipeReservationResponseImpl _$$RecipeReservationResponseImplFromJson(
  Map<String, dynamic> json,
) => _$RecipeReservationResponseImpl(
  mealPlanId: json['mealPlanId'] as String,
  reservations: json['reservations'] as List<dynamic>? ?? const [],
  missing:
      (json['missing'] as List<dynamic>?)
          ?.map((e) => MissingIngredient.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$RecipeReservationResponseImplToJson(
  _$RecipeReservationResponseImpl instance,
) => <String, dynamic>{
  'mealPlanId': instance.mealPlanId,
  'reservations': instance.reservations,
  'missing': instance.missing,
};
