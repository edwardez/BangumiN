import 'package:flutter/material.dart';

/// a simple layout with a scaffold and a inner SafeArea
class ScaffoldWithAppBar extends StatelessWidget {
  final Widget safeAreaChild;
  final AppBar appBar;

  const ScaffoldWithAppBar(
      {Key key, @required this.safeAreaChild, @required this.appBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(child: safeAreaChild),
    );
  }
}
