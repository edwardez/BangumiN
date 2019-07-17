import 'package:flutter/material.dart';
import 'package:munin/widgets/shared/icons/MuninIcons.dart';

class MuninSmallTriangle extends StatelessWidget {
  /// Size of the icon, if unset, a special tiny size is used(see code).
  final double size;

  const MuninSmallTriangle({
    Key key,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      MuninIcons.muninRoundedTriangle,
      size: size ??
          Theme.of(context).textTheme.subhead.fontSize *
              MediaQuery.of(context).textScaleFactor /
              4.2,
    );
  }
}
