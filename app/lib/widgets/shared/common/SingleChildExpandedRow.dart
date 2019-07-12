import 'package:flutter/material.dart';

/// A widget that has a row layout and a single child inside a
/// [Expanded].
class SingleChildExpandedRow extends StatelessWidget {
  final Widget child;

  const SingleChildExpandedRow({Key key, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: child,
        )
      ],
    );
  }
}
