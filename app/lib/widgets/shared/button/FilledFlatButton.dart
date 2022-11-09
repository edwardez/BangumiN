import 'package:flutter/material.dart';
import 'package:munin/styles/theme/Common.dart';

class FilledFlatButton extends StatelessWidget {
  final VoidCallback onPressed;

  final Widget child;

  const FilledFlatButton({
    Key key,
    @required this.onPressed,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: lightPrimaryDarkAccentColor(context),
        disabledBackgroundColor:
            lightPrimaryDarkAccentColor(context).withOpacity(0.1),
      ),
      onPressed: this.onPressed,
      child: child,
    );
  }
}
