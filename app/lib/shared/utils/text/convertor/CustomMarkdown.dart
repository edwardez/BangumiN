import 'package:charcode/ascii.dart';
import 'package:markdown/markdown.dart';
import 'package:munin/shared/utils/text/convertor/common.dart';

/// A inline spoiler markup. It's similar to discord's spoiler syntax.
///
/// Theoretically speaking, || should be set with [requiresDelimiterRun]= true.
/// However relaxing this limitation can give users more freedom.
class SpoilerInlineSyntax extends TagSyntax {
  SpoilerInlineSyntax()
      : super(
          r'\|\|+',
          requiresDelimiterRun: false,
        );

  @override
  bool onMatchEnd(InlineParser parser, Match match, TagState state) {
    parser.addNode(Element(BangumiHtmlTag.inlineSpoiler, state.children));
    return true;
  }
}

class _DelimiterRun {
  static final String punctuation = r'''!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~''';

  // TODO(srawlins): Unicode whitespace
  static final String whitespace = ' \t\r\n';

  final int char;
  final int length;
  final bool isLeftFlanking;
  final bool isRightFlanking;
  final bool isPrecededByPunctuation;
  final bool isFollowedByPunctuation;

  _DelimiterRun._(
      {this.char,
      this.length,
      this.isLeftFlanking,
      this.isRightFlanking,
      this.isPrecededByPunctuation,
      this.isFollowedByPunctuation});

  static _DelimiterRun tryParse(InlineParser parser, int runStart, int runEnd) {
    bool leftFlanking,
        rightFlanking,
        precededByPunctuation,
        followedByPunctuation;
    String preceding, following;
    if (runStart == 0) {
      rightFlanking = false;
      preceding = '\n';
    } else {
      preceding = parser.source.substring(runStart - 1, runStart);
    }
    precededByPunctuation = punctuation.contains(preceding);

    if (runEnd == parser.source.length - 1) {
      leftFlanking = false;
      following = '\n';
    } else {
      following = parser.source.substring(runEnd + 1, runEnd + 2);
    }
    followedByPunctuation = punctuation.contains(following);

    // http://spec.commonmark.org/0.28/#left-flanking-delimiter-run
    if (whitespace.contains(following)) {
      leftFlanking = false;
    } else {
      leftFlanking = !followedByPunctuation ||
          whitespace.contains(preceding) ||
          precededByPunctuation;
    }

    // http://spec.commonmark.org/0.28/#right-flanking-delimiter-run
    if (whitespace.contains(preceding)) {
      rightFlanking = false;
    } else {
      rightFlanking = !precededByPunctuation ||
          whitespace.contains(following) ||
          followedByPunctuation;
    }

    if (!leftFlanking && !rightFlanking) {
      // Could not parse a delimiter run.
      return null;
    }

    return _DelimiterRun._(
        char: parser.charAt(runStart),
        length: runEnd - runStart + 1,
        isLeftFlanking: leftFlanking,
        isRightFlanking: rightFlanking,
        isPrecededByPunctuation: precededByPunctuation,
        isFollowedByPunctuation: followedByPunctuation);
  }

  String toString() =>
      '<char: $char, length: $length, isLeftFlanking: $isLeftFlanking, '
      'isRightFlanking: $isRightFlanking>';

  // Whether a delimiter in this run can open emphasis or strong emphasis.
  bool get canOpen =>
      isLeftFlanking &&
      (char == $asterisk || !isRightFlanking || isPrecededByPunctuation);

  // Whether a delimiter in this run can close emphasis or strong emphasis.
  bool get canClose =>
      isRightFlanking &&
      (char == $asterisk || !isLeftFlanking || isFollowedByPunctuation);
}
