import 'package:flutter/material.dart';

/// A context with transparent divider
/// It's can be used to hide Divider of ExpansionTile
class ThemeWithTransparentDivider extends StatelessWidget {
  final Widget child;

  const ThemeWithTransparentDivider({Key key, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: child,
    );
  }
}
