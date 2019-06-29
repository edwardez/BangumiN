import 'package:flutter/material.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/background/RoundedConcreteBackground.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';

class RoundedConcreteBackgroundWithChild extends StatelessWidget {
  final Widget child;

  const RoundedConcreteBackgroundWithChild(
    this.child, {
    Key key,
  }) : super(key: key);

  RoundedConcreteBackgroundWithChild.fromText(
    String text,
    BuildContext outerContext, {
    Key key,
    int maxLines,
  })  : child = WrappableText(
          text,
          textStyle: captionTextWithHigherOpacity(outerContext),
          outerWrapper: OuterWrapper.Row,
          maxLines: maxLines,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedConcreteBackground(
      child: child,
    );
  }
}
