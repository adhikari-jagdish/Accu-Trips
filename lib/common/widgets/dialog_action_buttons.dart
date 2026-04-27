import 'package:accu_trips/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DialogActionButtons extends StatelessWidget {
  const DialogActionButtons({super.key, this.positiveButtonText, this.onSave});

  final VoidCallback? onSave;
  final String? positiveButtonText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text("Close")),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: onSave ?? () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.colorPrimary),
          child: Text(positiveButtonText ?? "Save", style: TextStyle(color: Colors.white, fontSize: 12)),
        ),
      ],
    );
  }
}
