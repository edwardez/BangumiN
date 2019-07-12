import 'package:flutter/material.dart';

class SpoilerText extends StatefulWidget {
  final String text;
  final bool showSpoiler;

  const SpoilerText({Key key, this.showSpoiler = false, @required this.text})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SpoilerTextState();
  }
}

class _SpoilerTextState extends State<SpoilerText> {
  bool showSpoiler;

  @override
  void initState() {
    super.initState();
    showSpoiler = widget.showSpoiler;
  }

  @override
  void didUpdateWidget(SpoilerText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.showSpoiler != widget.showSpoiler) {
      showSpoiler = widget.showSpoiler;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = showSpoiler ? Colors.white : Colors.transparent;
    bool isAppBackgroundPureDark =
        Theme.of(context).backgroundColor == Colors.black;
    Color textBackground = isAppBackgroundPureDark
        ? Theme.of(context).primaryColor
        : Colors.black54;

    return GestureDetector(
      child: RichText(
        text: TextSpan(
            text: widget.text,
            style: Theme.of(context).textTheme.body1.copyWith(
                  color: textColor,

                  /// Should this also be theme-aware?
                  background: Paint()..color = textBackground,
                )),
      ),
      onTapDown: (TapDownDetails details) {
        setState(() {
          showSpoiler = !showSpoiler;
        });
      },
    );
  }
}
