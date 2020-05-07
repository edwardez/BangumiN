import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A short cut for [RichText] that displays multiple text spans.
///
/// This is a simple wrapper around the official widget to reduce boilerplate.
class MuninTextSpans extends StatelessWidget {
  final List<MuninTextSpanConfig> children;

  const MuninTextSpans({Key key, @required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          for (var textConfig in children)
            TextSpan(
              text: textConfig.text,
              style:
                  textConfig.textStyle ?? Theme.of(context).textTheme.bodyText2,
            )
        ],
      ),
    );
  }
}

class MuninTextSpanConfig {
  final String text;
  final TextStyle textStyle;

  MuninTextSpanConfig(this.text, [this.textStyle]);
}
