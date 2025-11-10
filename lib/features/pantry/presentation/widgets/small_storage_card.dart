import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../pantry/data/models/storage_models.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routing/app_routes.dart';

class SmallStorageCard extends StatelessWidget {
  const SmallStorageCard({
    super.key,
    required this.storage,
    this.onEdit,
    this.onDelete,
  });
  final Storage storage;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  String? get _iconAssetPath {
    switch (storage.type) {
      case StorageType.pantry:
        return 'assets/image/foodbox.png';
      case StorageType.fridge:
        return 'assets/image/fridge.png';
      case StorageType.freezer:
        return null; // Not used here
    }
  }

  // Removed type label usage; only asset icon is shown for Pantry/Fridge

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(
          '${AppRoutes.compartment}?storageId=${storage.id}&storageName=${Uri.encodeComponent(storage.name)}',
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            AppColors.babyBlue.withOpacity(0.35),
            AppColors.iceberg.withOpacity(0.15),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        image: storage.type == StorageType.pantry
            ? const DecorationImage(
                image: AssetImage('assets/image/pantry-border.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white54,
                  BlendMode.srcATop,
                ),
              )
            : storage.type == StorageType.fridge
                ? const DecorationImage(
                    image: AssetImage('assets/image/small-border.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.white70,
                      BlendMode.srcATop,
                    ),
                  )
                : null,
        border: Border.all(
          color: AppColors.powderBlue.withOpacity(0.35),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.powderBlue.withOpacity(0.12),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_iconAssetPath != null) ...[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.powderBlue.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Image.asset(
                      _iconAssetPath!,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              Text(
                storage.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          // 3-dot menu button at top-right corner
          Positioned(
            top: -8,
            right: -8,
            child: PopupMenuButton<String>(
              icon: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.powderBlue.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.more_vert,
                  size: 16,
                  color: Colors.black54,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              itemBuilder: (context) => [
                PopupMenuItem<String>(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        size: 18,
                        color: AppColors.powderBlue,
                      ),
                      const SizedBox(width: 8),
                      const Text('Edit'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        size: 18,
                        color: Colors.red.shade300,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Delete',
                        style: TextStyle(color: Colors.red.shade300),
                      ),
                    ],
                  ),
                ),
              ],
              onSelected: (value) {
                if (value == 'edit' && onEdit != null) {
                  onEdit!();
                } else if (value == 'delete' && onDelete != null) {
                  onDelete!();
                }
              },
            ),
          ),
        ],
      ),
      ),
    );
  }
}


