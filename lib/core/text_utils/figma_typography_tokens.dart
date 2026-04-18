class FigmaTypographyTokens {
  FigmaTypographyTokens._();

  //Font Size 32
  static const typographyBold32 = TextToken(
    size: 32,
    weight: 700,
    lineHeight: 28,
    letterSpacing: -0.1,
  );

  //Font Size 20
  static const typographyExtraBold20 = TextToken(
    size: 20,
    weight: 900,
    lineHeight: 28,
    letterSpacing: -0.07,
  );

  //Font Size 18
  static const typographyBold18 = TextToken(
    size: 18,
    weight: 600,
    lineHeight: 24,
    letterSpacing: -0.06,
  );

  static const typographyMedium18 = TextToken(
    size: 18,
    weight: 500,
    lineHeight: 20,
    letterSpacing: -0.06,
  );
  static const typographyLight18 = TextToken(
    size: 18,
    weight: 500,
    lineHeight: 16,
    letterSpacing: -0.06,
  );

  static const typographyRegular18 = TextToken(
    size: 18,
    weight: 400,
    lineHeight: 24,
    letterSpacing: -0.06,
  );

  //Font Size 14
  static const typographyRegular14 = TextToken(
    size: 14,
    weight: 400,
    lineHeight: 24,
    letterSpacing: -0.06,
  );

  //Font Size 11
  static const typographyMedium11 = TextToken(
    size: 11,
    weight: 500,
    lineHeight: 24,
    letterSpacing: -0.06,
  );

  static const typographyBold11 = TextToken(
    size: 11,
    weight: 900,
    lineHeight: 24,
    letterSpacing: -0.06,
  );
}

class TextToken {
  final double size;
  final int weight;
  final double lineHeight;
  final double letterSpacing;

  const TextToken({
    required this.size,
    required this.weight,
    required this.lineHeight,
    required this.letterSpacing,
  });
}
