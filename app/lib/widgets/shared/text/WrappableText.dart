import 'package:flutter/material.dart';

enum OuterWrapper { NoWrapper, Row }

class WrappableText extends StatelessWidget {
  final String text;
  final int maxLines;
  final FlexFit fit;
  final TextStyle textStyle;

  /// The offset from the left.
  final double left;

  /// The offset from the top.
  final double top;

  /// The offset from the right.
  final double right;

  /// The offset from the bottom.
  final double bottom;

  /// whether create a outer wrapper widget, (Flexible needs a wrapper flex to work)
  final OuterWrapper outerWrapper;

  /// How visual overflow should be handled.
  final TextOverflow overflow;

  const WrappableText(
    this.text, {
    Key key,
    this.textStyle,
    this.maxLines = 1,
    this.fit = FlexFit.loose,
    this.left = 0,
    this.top = 0,
    this.right = 0,
    this.bottom = 0,
    this.outerWrapper = OuterWrapper.NoWrapper,
        this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);

  const WrappableText.smallVerticalPadding(
    this.text, {
    Key key,
    this.textStyle,
    this.maxLines = 1,
    this.fit = FlexFit.loose,
    this.left = 0,
    this.top = 4.0,
    this.right = 0,
    this.bottom = 4.0,
    this.outerWrapper = OuterWrapper.NoWrapper,
        this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);

  const WrappableText.mediumVerticalPadding(
    this.text, {
    Key key,
    this.textStyle,
    this.maxLines = 1,
    this.fit = FlexFit.loose,
    this.left = 0,
    this.top = 10.0,
    this.right = 0,
    this.bottom = 10.0,
    this.outerWrapper = OuterWrapper.NoWrapper,
        this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget flexibleText = Flexible(
      fit: fit,
      child: Padding(
        padding: EdgeInsets.only(
          left: left,
          top: top,
          right: right,
          bottom: bottom,
        ),
        child: Text(
          text,
          maxLines: maxLines,
          overflow: overflow,
          style: textStyle ?? Theme
              .of(context)
              .textTheme
              .body1,
        ),
      ),
    );

    if (outerWrapper == OuterWrapper.Row) {
      return Row(
        children: <Widget>[flexibleText],
      );
    }
    return flexibleText;
  }
}
