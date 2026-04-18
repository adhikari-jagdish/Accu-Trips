import 'package:flutter/material.dart';

class FontScaler {
  FontScaler._(); // prevents instantiation

  /// Base scaling using system accessibility settings
  static double scale(BuildContext context, double baseSize) {
    return MediaQuery.textScalerOf(context).scale(baseSize);
  }

  /// Optional: clamp font sizes to avoid extreme scaling
  static double clamp(
    BuildContext context,
    double baseSize, {
    double min = 10,
    double max = 30,
  }) {
    final scaled = scale(context, baseSize);
    return scaled.clamp(min, max);
  }
}
