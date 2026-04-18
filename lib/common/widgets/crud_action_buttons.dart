import 'package:flutter/material.dart';

class CrudActionButtons extends StatelessWidget {
  const CrudActionButtons({super.key, this.onEdit, this.onDelete, this.onView});
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onView;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (onView != null) _btn(Icons.visibility_outlined, const Color(0xFF2563EB), onView!),
        if (onEdit != null) ...[const SizedBox(width: 4), _btn(Icons.edit_outlined, const Color(0xFF113C7C), onEdit!)],
        if (onDelete != null) ...[const SizedBox(width: 4), _btn(Icons.delete_outline, const Color(0xFFDC2626), onDelete!)],
      ],
    );
  }

  Widget _btn(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(color: color.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(6)),
        child: Icon(icon, size: 15, color: color),
      ),
    );
  }
}
