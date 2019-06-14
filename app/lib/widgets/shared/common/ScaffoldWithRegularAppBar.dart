import 'package:flutter/material.dart';
import 'package:munin/styles/theme/Common.dart';

/// a simple layout with a scaffold, an AppBat and a inner SafeArea
/// where AppBar is the built-in app bar for [Scaffold]
class ScaffoldWithRegularAppBar extends StatelessWidget {
  final Widget safeAreaChild;
  final PreferredSizeWidget appBar;
  final double safeAreaChildHorizontalPadding;

  const ScaffoldWithRegularAppBar(
      {Key key, @required this.safeAreaChild, @required this.appBar, this.safeAreaChildHorizontalPadding = defaultPortraitHorizontalOffset})
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
