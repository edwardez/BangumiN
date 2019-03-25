import 'package:flutter/material.dart';
import 'package:munin/styles/theme/common.dart';

/// a simple layout with a scaffold and a inner SafeArea
class ScaffoldWithAppBar extends StatelessWidget {
  final Widget safeAreaChild;
  final AppBar appBar;
  final double safeAreaChildHorizontalPadding;

  const ScaffoldWithAppBar(
      {Key key, @required this.safeAreaChild, @required this.appBar, this.safeAreaChildHorizontalPadding = portraitDefaultHorizontalPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: safeAreaChildHorizontalPadding),
        child: safeAreaChild,
      )),
    );
  }
}
