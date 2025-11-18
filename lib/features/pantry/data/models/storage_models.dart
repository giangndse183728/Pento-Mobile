// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'storage_models.freezed.dart';
part 'storage_models.g.dart';

enum StorageType { pantry, fridge, freezer }

class _StorageTypeConverter
    implements JsonConverter<StorageType, Object?> {
  const _StorageTypeConverter();

  @override
  StorageType fromJson(Object? json) {
    if (json is String) {
      final lowerJson = json.toLowerCase();
      switch (lowerJson) {
        case 'pantry':
          return StorageType.pantry;
        case 'fridge':
          return StorageType.fridge;
        case 'freezer':
          return StorageType.freezer;
        default:
          return StorageType.pantry;
      }
    }
    
    return StorageType.pantry;
  }

  @override
  Object toJson(StorageType object) {
    switch (object) {
      case StorageType.pantry:
        return 0;
      case StorageType.fridge:
        return 1;
      case StorageType.freezer:
        return 2;
    }
  }
}

int storageTypeToInt(StorageType object) {
  switch (object) {
    case StorageType.pantry:
      return 0;
    case StorageType.fridge:
      return 1;
    case StorageType.freezer:
      return 2;
  }
}

@freezed
class Storage with _$Storage {
  const factory Storage({
    required String id,
    required String name,
    @_StorageTypeConverter() required StorageType type,
    @Default('') String notes,
  }) = _Storage;

  factory Storage.fromJson(Map<String, dynamic> json) =>
      _$StorageFromJson(json);
}

@freezed
class PaginatedStorages with _$PaginatedStorages {
  const factory PaginatedStorages({
    required int currentPage,
    required int totalPages,
    required int pageSize,
    required int totalCount,
    required bool hasPrevious,
    required bool hasNext,
    @Default(<Storage>[]) List<Storage> items,
  }) = _PaginatedStorages;
}


