// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeImpl _$$RecipeImplFromJson(Map<String, dynamic> json) => _$RecipeImpl(
  id: json['id'] as String?,
  recipeId: json['recipeId'] as String?,
  title: json['title'] as String?,
  recipeTitle: json['recipeTitle'] as String?,
  description: json['description'] as String? ?? '',
  totalTimes: (json['totalTimes'] as num?)?.toInt(),
  prepTimeMinutes: (json['prepTimeMinutes'] as num?)?.toInt() ?? 0,
  cookTimeMinutes: (json['cookTimeMinutes'] as num?)?.toInt() ?? 0,
  totalTimeMinutes: (json['totalTimeMinutes'] as num?)?.toInt() ?? 0,
  notes: json['notes'] as String? ?? '',
  servings: (json['servings'] as num?)?.toInt() ?? 1,
  difficultyLevel: json['difficultyLevel'] as String? ?? 'Medium',
  imageUrl: json['imageUrl'] as String?,
  createdBy: json['createdBy'] as String?,
  isPublic: json['isPublic'] as bool? ?? false,
  createdOnUtc: json['createdOnUtc'] == null
      ? null
      : DateTime.parse(json['createdOnUtc'] as String),
  updatedOnUtc: json['updatedOnUtc'] == null
      ? null
      : DateTime.parse(json['updatedOnUtc'] as String),
  ingredients:
      (json['ingredients'] as List<dynamic>?)
          ?.map((e) => RecipeIngredient.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  directions:
      (json['directions'] as List<dynamic>?)
          ?.map((e) => RecipeDirection.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$RecipeImplToJson(_$RecipeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recipeId': instance.recipeId,
      'title': instance.title,
      'recipeTitle': instance.recipeTitle,
      'description': instance.description,
      'totalTimes': instance.totalTimes,
      'prepTimeMinutes': instance.prepTimeMinutes,
      'cookTimeMinutes': instance.cookTimeMinutes,
      'totalTimeMinutes': instance.totalTimeMinutes,
      'notes': instance.notes,
      'servings': instance.servings,
      'difficultyLevel': instance.difficultyLevel,
      'imageUrl': instance.imageUrl,
      'createdBy': instance.createdBy,
      'isPublic': instance.isPublic,
      'createdOnUtc': instance.createdOnUtc?.toIso8601String(),
      'updatedOnUtc': instance.updatedOnUtc?.toIso8601String(),
      'ingredients': instance.ingredients,
      'directions': instance.directions,
    };

_$RecipeIngredientImpl _$$RecipeIngredientImplFromJson(
  Map<String, dynamic> json,
) => _$RecipeIngredientImpl(
  ingredientId: json['ingredientId'] as String,
  foodRefId: json['foodRefId'] as String?,
  foodRefName: json['foodRefName'] as String?,
  imageUrl: json['imageUrl'] as String?,
  quantity: (json['quantity'] as num?)?.toDouble() ?? 0,
  unitId: json['unitId'] as String?,
  unitName: json['unitName'] as String?,
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$$RecipeIngredientImplToJson(
  _$RecipeIngredientImpl instance,
) => <String, dynamic>{
  'ingredientId': instance.ingredientId,
  'foodRefId': instance.foodRefId,
  'foodRefName': instance.foodRefName,
  'imageUrl': instance.imageUrl,
  'quantity': instance.quantity,
  'unitId': instance.unitId,
  'unitName': instance.unitName,
  'notes': instance.notes,
};

_$RecipeDirectionImpl _$$RecipeDirectionImplFromJson(
  Map<String, dynamic> json,
) => _$RecipeDirectionImpl(
  directionId: json['directionId'] as String,
  stepNumber: (json['stepNumber'] as num).toInt(),
  description: json['description'] as String,
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$$RecipeDirectionImplToJson(
  _$RecipeDirectionImpl instance,
) => <String, dynamic>{
  'directionId': instance.directionId,
  'stepNumber': instance.stepNumber,
  'description': instance.description,
  'imageUrl': instance.imageUrl,
};

_$PaginatedRecipesImpl _$$PaginatedRecipesImplFromJson(
  Map<String, dynamic> json,
) => _$PaginatedRecipesImpl(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => Recipe.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  currentPage: (json['currentPage'] as num?)?.toInt() ?? 1,
  totalPages: (json['totalPages'] as num?)?.toInt() ?? 1,
  pageSize: (json['pageSize'] as num?)?.toInt() ?? 12,
  totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
  hasPrevious: json['hasPrevious'] as bool? ?? false,
  hasNext: json['hasNext'] as bool? ?? false,
);

Map<String, dynamic> _$$PaginatedRecipesImplToJson(
  _$PaginatedRecipesImpl instance,
) => <String, dynamic>{
  'items': instance.items,
  'currentPage': instance.currentPage,
  'totalPages': instance.totalPages,
  'pageSize': instance.pageSize,
  'totalCount': instance.totalCount,
  'hasPrevious': instance.hasPrevious,
  'hasNext': instance.hasNext,
};
