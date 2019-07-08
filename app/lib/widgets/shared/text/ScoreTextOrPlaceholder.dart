import 'package:flutter/material.dart';
import 'package:munin/shared/utils/bangumi/common.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:quiver/core.dart';

/// Shows score or a place holder caption text.
/// One and only one of scoreInDouble and scoreInInt must not be null.
/// Placer holder text is supposed to be smaller than or equal to score text.
class ScoreTextOrPlaceholder extends StatelessWidget {
  static const scorePlaceHolderText = '暂无';

  /// User rating as text
  final Optional<String> scoreText;

  final String placeholderText;

  /// default to [scoreStyle]
  final TextStyle scoreTextStyle;

  /// default to [defaultCaptionText]
  final TextStyle placeholderTextStyle;

  /// Whether placeholder text should align with score even if their size
  /// might be different.
  /// Note: this is done in a hack way and probably needs to be improved.
  final bool placeholderAlignWithScore;

  ScoreTextOrPlaceholder.fromScoreInDouble(double scoreInDouble,
      {Key key,
        this.placeholderText = scorePlaceHolderText,
        this.placeholderAlignWithScore = true,
        this.scoreTextStyle,
        this.placeholderTextStyle})
      : this.scoreText = isValidDoubleScore(scoreInDouble)
      ? Optional.of(scoreInDouble.toString())
      : Optional.absent(),
        super(key: key);

  ScoreTextOrPlaceholder.fromScoreInInt(int scoreInInt,
      {Key key,
        this.placeholderText = scorePlaceHolderText,
        this.placeholderAlignWithScore = true,
        this.scoreTextStyle,
        this.placeholderTextStyle})
      : this.scoreText = isValidIntScore(scoreInInt)
      ? Optional.of(scoreInInt.toString())
      : Optional.absent(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double scoreSize = (scoreTextStyle ?? scoreStyle(context)).fontSize;

    if (scoreText.isNotPresent) {
      /// HACK: use a transparent score to make sure place holder text occupies same
      /// size as score size
      if (placeholderAlignWithScore) {
        return Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Semantics(
              child: Text('',
                  style: placeholderTextStyle ??
                      defaultCaptionText(context).copyWith(
                          fontSize: scoreSize, color: Colors.transparent)),
              hidden: true,
            ),
            Text(placeholderText,
                style: placeholderTextStyle ?? defaultCaptionText(context)),
          ],
        );
      }

      return Text(placeholderText,
          style: placeholderTextStyle ?? defaultCaptionText(context));
    }

    return Text(scoreText.value, style: scoreTextStyle ?? scoreStyle(context));
  }
}
