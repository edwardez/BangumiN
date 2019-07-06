import 'package:flutter/material.dart';
import 'package:munin/styles/theme/Common.dart';

/// A customized outline button which uses primary color for text and outline
/// for bright theme, and accent color for dark theme
class MuninOutlineButton extends StatelessWidget {
  /// The button's label.
  ///
  /// Often a [Text] widget in all caps.
  final Widget child;

  /// The callback that is called when the button is tapped or otherwise activated.
  ///
  /// If this is set to null, the button will be disabled.
  final VoidCallback onPressed;

  const MuninOutlineButton(
      {Key key, @required this.onPressed, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color mainColor = lightPrimaryDarkAccentColor(context);
    return OutlineButton(
      child: child,
      textColor: mainColor,
      borderSide: BorderSide(color: mainColor, width: 1.0),
      highlightedBorderColor: mainColor,
      onPressed: onPressed,
    );
  }
}
