import 'package:accu_trips/common/widgets/crud_action_buttons.dart';
import 'package:accu_trips/common/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';

class CrudTableRow<T> extends StatelessWidget {
  const CrudTableRow({super.key, required this.item, required this.index, required this.cells, required this.onEdit, required this.onDelete, this.getId, this.getName});

  final T item;
  final int index;

  /// Build row cells dynamically
  final List<Widget> Function(T item, int index) cells;

  /// Actions
  final void Function(T item) onEdit;
  final Future<void> Function(T item) onDelete;

  /// Optional helpers (for confirmation dialog etc.)
  final String? Function(T item)? getName;
  final dynamic Function(T item)? getId;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: index.isEven ? Colors.white : const Color(0xFFF9FAFB),
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 20),
      child: Row(
        children: [
          ...cells(item, index),

          /// Actions column
          Expanded(
            flex: 2,
            child: CrudActionButtons(
              onEdit: () => onEdit(item),
              onDelete: () async {
                final name = getName?.call(item) ?? 'item';
                final id = getId?.call(item);

                if (id == null) return;

                final ok = await showDeleteAlertDialog(context);

                if (ok) {
                  await onDelete(item);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
