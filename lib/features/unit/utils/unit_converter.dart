import '../data/models/unit_model.dart';

class UnitConverter {
  const UnitConverter._();

  static Unit? findById(List<Unit> units, String? id) {
    if (id == null) return null;
    try {
      return units.firstWhere((unit) => unit.id == id);
    } catch (_) {
      return null;
    }
  }

  static Unit? findByAbbreviation(List<Unit> units, String? abbreviation) {
    if (abbreviation == null || abbreviation.trim().isEmpty) {
      return null;
    }
    final normalized = abbreviation.trim().toLowerCase();
    try {
      return units.firstWhere(
        (unit) => unit.abbreviation.toLowerCase() == normalized,
      );
    } catch (_) {
      return null;
    }
  }

  static Unit? findByLabel(List<Unit> units, String? label) {
    if (label == null || label.trim().isEmpty) return null;
    final normalized = _normalize(label);

    try {
      return units.firstWhere((unit) {
        final abbreviation = _normalize(unit.abbreviation);
        final name = _normalize(unit.name);
        return abbreviation == normalized ||
            name == normalized ||
            abbreviation.contains(normalized) ||
            normalized.contains(abbreviation) ||
            name.contains(normalized) ||
            normalized.contains(name);
      });
    } catch (_) {
      return null;
    }
  }

  static String _normalize(String value) {
    return value
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]'), '');
  }

  static double? convert({
    required double quantity,
    required Unit fromUnit,
    required Unit toUnit,
  }) {
    if (fromUnit.toBaseFactor <= 0 || toUnit.toBaseFactor <= 0) {
      return null;
    }
    final quantityInBase = quantity / fromUnit.toBaseFactor;
    return quantityInBase * toUnit.toBaseFactor;
  }
}

