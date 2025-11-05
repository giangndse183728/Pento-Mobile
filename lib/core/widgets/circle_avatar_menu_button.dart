import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CircleAvatarMenuButton extends StatefulWidget {
  const CircleAvatarMenuButton({
    super.key,
    this.imageUrl,
    this.initials,
    this.onMenuItemSelected,
    this.menuItems = const [],
  });

  final String? imageUrl;
  final String? initials;
  final ValueChanged<int>? onMenuItemSelected;
  final List<PopupMenuItemData> menuItems;

  @override
  State<CircleAvatarMenuButton> createState() => _CircleAvatarMenuButtonState();
}

class _CircleAvatarMenuButtonState extends State<CircleAvatarMenuButton> {
  void _showMenu() {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final Offset position = button.localToGlobal(Offset.zero, ancestor: overlay);
    
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx - 80, // Position menu to the left of button
        position.dy + button.size.height + 6,
        position.dx + button.size.width,
        position.dy + button.size.height + 6,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 8,
      items: widget.menuItems.map((item) => PopupMenuItem<int>(
        value: item.index,
        child: Row(
          children: [
            Icon(item.icon, color: AppColors.blueGray, size: 20),
            const SizedBox(width: 12),
            Text(
              item.label,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      )).toList(),
    ).then((value) {
      if (value != null) {
        widget.onMenuItemSelected?.call(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showMenu,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              AppColors.babyBlue.withOpacity(0.4),
              AppColors.powderBlue.withOpacity(0.3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: AppColors.powderBlue.withOpacity(0.5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.powderBlue.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipOval(
          child: widget.imageUrl != null
              ? Image.network(
                  widget.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => _buildInitials(),
                )
              : _buildInitials(),
        ),
      ),
    );
  }

  Widget _buildInitials() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            AppColors.blueGray.withOpacity(0.8),
            AppColors.powderBlue.withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          widget.initials ?? 'U',
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
class PopupMenuItemData {
  const PopupMenuItemData({
    required this.index,
    required this.label,
    required this.icon,
  });

  final int index;
  final String label;
  final IconData icon;
}

