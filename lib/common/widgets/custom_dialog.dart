import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key, this.title, this.subtitle, this.borderRadius, this.padding, required this.child});

  final String? title;
  final String? subtitle;
  final double? borderRadius;
  final double? padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.all(size.width < 600 ? 12 : 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 12)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 650, maxHeight: size.height * 0.95),
        child: SingleChildScrollView(padding: EdgeInsets.all(padding ?? 20), child: child ?? const SizedBox.shrink()),
      ),
    );
  }
}
