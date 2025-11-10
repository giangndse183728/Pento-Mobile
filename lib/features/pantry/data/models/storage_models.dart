// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'storage_models.freezed.dart';
part 'storage_models.g.dart';

enum StorageType { pantry, fridge, freezer }

/// Converter for parsing API response string enum names (e.g., "Pantry", "Fridge", "Freezer") to StorageType for UI display.
/// This is ONLY used when deserializing Storage from JSON (API responses).
/// For request bodies, use [storageTypeToInt] to convert StorageType to int (0,1,2).
class _StorageTypeConverter
    implements JsonConverter<StorageType, Object?> {
  const _StorageTypeConverter();

  /// Parses string enum names from API response to StorageType for UI display.
  /// API returns: "Pantry", "Fridge", "Freezer" (case-insensitive)
  @override
  StorageType fromJson(Object? json) {
    if (json is String) {
      // Handle string enum names from API (case-insensitive)
      final lowerJson = json.toLowerCase();
      switch (lowerJson) {
        case 'pantry':
          return StorageType.pantry;
        case 'fridge':
          return StorageType.fridge;
        case 'freezer':
          return StorageType.freezer;
        default:
          return StorageType.pantry; // Default fallback
      }
    }
    
    // Default fallback if json is not a string
    return StorageType.pantry;
  }

  /// Converts StorageType to int (0,1,2) for JSON serialization.
  /// Note: This is NOT used - we use [storageTypeToInt] for request bodies instead.
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


