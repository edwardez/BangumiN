import 'dart:math' as math;
import 'dart:ui';

/// Computes color ratio according to
/// http://www.w3.org/TR/2008/REC-WCAG20-20081211/#contrast-ratiodef
double computeContrastRatio(
  Color foreground,
  Color background,
) {
  final double lightness1 = foreground.computeLuminance() + 0.05;
  final double lightness2 = background.computeLuminance() + 0.05;
  return math.max(lightness1, lightness2) / math.min(lightness1, lightness2);
}
