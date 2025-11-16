import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../pantry/data/models/storage_models.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routing/app_routes.dart';
import 'type_badge.dart';

class FreezerCard extends StatelessWidget {
  const FreezerCard({
    super.key,
    required this.storage,
    this.onEdit,
    this.onDelete,
  });
  final Storage storage;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(
          '${AppRoutes.compartment}?storageId=${storage.id}&storageName=${Uri.encodeComponent(storage.name)}',
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            AppColors.babyBlue.withOpacity(0.45),
            AppColors.iceberg.withOpacity(0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        image: const DecorationImage(
          image: AssetImage('assets/image/big-border.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.white70,
            BlendMode.srcATop,
          ),
        ),
        border: Border.all(
          color: AppColors.powderBlue.withOpacity(0.45),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.powderBlue.withOpacity(0.14),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: SizedBox(
        height: 75,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Row: icon + title centered inside the card
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.powderBlue.withOpacity(0.28),
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Center(
                      child: Image.asset(
                        'assets/image/snowflake.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      storage.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'MomoTrustDisplay',
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Badge at top-left corner
            Positioned(
              top: -10,
              left: -10,
              child: TypeBadge(type: StorageType.freezer),
            ),
            // 3-dot menu button at top-right corner
            Positioned(
              top: -20,
              right: -20,
              child: PopupMenuButton<String>(
                icon: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.powderBlue.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.more_vert,
                    size: 18,
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
      ),
    );
  }
}
