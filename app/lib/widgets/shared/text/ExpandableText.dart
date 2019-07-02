import 'package:flutter/material.dart';
import 'package:munin/widgets/shared/common/ExpandableChild.dart';

/// A widget that hides long text by default and allows user to see full text
/// by clicking 'read more' button.
/// If text is not too long, expand button won't show up.
class ExpandableText extends StatelessWidget {
  final String text;

  /// Render of the text. [text] in parameters are passed-in, however
  /// whether to render [text] or something different is at the discretion
  /// of the widget user. In the latter case, [text] is actually just used as
  /// a predicate.
  final Widget Function(String text) textRenderer;

  /// If [text] is longer than [textLengthThreshold], some text should be
  /// hided.
  final int textLengthThreshold;

  final String expandButtonText;

  const ExpandableText(
    this.text, {
    Key key,
    this.textRenderer,
    this.textLengthThreshold = 200,
    this.expandButtonText = '展开全部',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final visibleAndTotalTextRatio = textLengthThreshold / text.length;
    return ExpandableChild(
      child: textRenderer == null ? Text(text) : textRenderer(text),
      isExpanded: visibleAndTotalTextRatio >= 1,
      initialVisiblePortion: visibleAndTotalTextRatio,
      expandButtonText: expandButtonText,
    );
  }
}
