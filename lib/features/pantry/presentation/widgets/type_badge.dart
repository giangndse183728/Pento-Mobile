import 'package:flutter/material.dart';
import '../../../pantry/data/models/storage_models.dart';
import '../../../../core/constants/app_colors.dart';

class TypeBadge extends StatelessWidget {
  const TypeBadge({super.key, required this.type});
  final StorageType type;

  String get label {
    switch (type) {
      case StorageType.pantry:
        return 'Pantry';
      case StorageType.fridge:
        return 'Fridge';
      case StorageType.freezer:
        return 'Freezer';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.blueGray.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(color: AppColors.iceberg, fontFamily: 'MomoTrustDisplay', fontSize: 12),
      ),
    );
  }
}


