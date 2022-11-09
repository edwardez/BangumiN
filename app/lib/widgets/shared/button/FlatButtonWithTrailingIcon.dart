import 'package:flutter/material.dart';

/// Eyeballed from flutter code, the only different is icon is after label
/// The type of of FlatButtons created with [FlatButton.icon].
///
/// This class only exists to give FlatButtons created with [FlatButton.icon]
/// a distinct class for the sake of [ButtonTheme]. It can not be instantiated.
class FlatButtonWithTrailingIcon extends TextButton {
  FlatButtonWithTrailingIcon({
    Key key,
    @required VoidCallback onPressed,
    VoidCallback onLongPress,
    ValueChanged<bool> onHover,
    ValueChanged<bool> onFocusChange,
    ButtonStyle style,
    FocusNode focusNode,
    bool autofocus,
    Clip clipBehavior,
    @required Widget icon,
    @required Widget label,
  })  : assert(icon != null),
        assert(label != null),
        super(
          key: key,
          onPressed: onPressed,
          onLongPress: onLongPress,
          onHover: onHover,
          onFocusChange: onFocusChange,
          style: style,
          focusNode: focusNode,
          autofocus: autofocus ?? false,
          clipBehavior: clipBehavior ?? Clip.none,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              label,
              const SizedBox(width: 4.0),
              icon,
            ],
          ),
        );
}
