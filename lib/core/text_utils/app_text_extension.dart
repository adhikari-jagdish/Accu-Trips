import 'package:accu_trips/core/text_utils/figma_typography_tokens.dart';
import 'package:flutter/material.dart';
import 'text_style_from_token.dart';

extension AppText on BuildContext {
  TextStyle typographyBold32() =>
      textStyleFromToken(this, FigmaTypographyTokens.typographyBold32);

  TextStyle typographyExtraBold20() =>
      textStyleFromToken(this, FigmaTypographyTokens.typographyExtraBold20);

  TextStyle typographyBold18() =>
      textStyleFromToken(this, FigmaTypographyTokens.typographyBold18);

  TextStyle typographyMedium18() =>
      textStyleFromToken(this, FigmaTypographyTokens.typographyMedium18);

  TextStyle typographyRegular18() =>
      textStyleFromToken(this, FigmaTypographyTokens.typographyRegular18);

  TextStyle typographyLight18() =>
      textStyleFromToken(this, FigmaTypographyTokens.typographyLight18);

  TextStyle typographyRegular14() =>
      textStyleFromToken(this, FigmaTypographyTokens.typographyRegular14);

  TextStyle typographyMedium11() =>
      textStyleFromToken(this, FigmaTypographyTokens.typographyMedium11);

  TextStyle typographyBold11() =>
      textStyleFromToken(this, FigmaTypographyTokens.typographyBold11);
}
