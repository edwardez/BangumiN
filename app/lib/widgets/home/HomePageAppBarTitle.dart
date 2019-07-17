import 'package:flutter/material.dart';
import 'package:munin/widgets/shared/button/FlatButtonWithTrailingIcon.dart';
import 'package:munin/widgets/shared/icons/MuninSmallTriangle.dart';

/// A common appbar title displayed across all home screens.
class HomePageAppBarTitle extends StatelessWidget {
  final String titleText;

  /// The callback that is called when the button is tapped or otherwise activated.
  final VoidCallback onPressed;

  const HomePageAppBarTitle({
    Key key,
    @required this.titleText,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButtonWithTrailingIcon(
      onPressed: onPressed,
      label: Text(titleText),
      icon: MuninSmallTriangle(),
    );
  }
}
