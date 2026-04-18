import 'package:accu_trips/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'figma_typography_tokens.dart';
import 'font_scaler.dart';

TextStyle textStyleFromToken(
  BuildContext context,
  TextToken token, {
  String fontFamily = 'Inter',
  bool clamp = true,
}) {
  final fontSize = clamp
      ? FontScaler.clamp(context, token.size)
      : FontScaler.scale(context, token.size);

  return TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize,
    fontWeight: FontWeight.values[((token.weight ~/ 100) - 1).clamp(0, 8)],
    height: token.lineHeight / token.size, // Figma → Flutter
    letterSpacing: token.letterSpacing,
    color: AppColors.primaryText,
  );
}
