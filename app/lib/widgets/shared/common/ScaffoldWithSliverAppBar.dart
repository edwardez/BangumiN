import 'package:flutter/material.dart';
import 'package:munin/styles/theme/common.dart';

/// uses [NestedScrollView] to implement a [SliverAppBar]
class ScaffoldWithSliverAppBar extends StatelessWidget {
  /// be aware that if appBarAutomaticallyImplyLeading is set to false
  /// User might not be able to go back(automaticallyImplyLeading might generate
  /// a 'go back' button for user)
  final bool appBarAutomaticallyImplyLeading;
  final bool appBarPinned;

  /// whether appbar title should be changed when user scrolls down
  final bool changeAppBarTitleOnScroll;

  /// if [changeAppBarTitleOnScroll] is set to false, this will always be the
  /// AppBar title
  final String appBarMainTitle;

  /// if [changeAppBarTitleOnScroll] is set to true, this will be the AppBar title
  /// after scrolling
  final String appBarSecondaryTitle;
  final double appBarElevation;
  final List<Widget> appBarActions;
  final Widget nestedScrollViewBody;
  final double safeAreaChildHorizontalPadding;

  const ScaffoldWithSliverAppBar({
    Key key,
    @required this.nestedScrollViewBody,
    @required this.appBarMainTitle,
    this.appBarSecondaryTitle = '',
    this.appBarAutomaticallyImplyLeading = true,
    this.appBarPinned = true,
    this.changeAppBarTitleOnScroll = false,
    this.appBarElevation = defaultAppBarElevation,
    this.appBarActions = const [],
    this.safeAreaChildHorizontalPadding = defaultPortraitHorizontalPadding,
  }) : super(key: key);

  _buildAppBarTitle(bool changeAppBarTitleOnScroll, bool innerBoxIsScrolled,
      String appBarMainTitle, String appBarSecondaryTitle) {
    if (!changeAppBarTitleOnScroll) {
      return Text(appBarMainTitle);
    }

    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 300),
      firstChild: Text(appBarMainTitle),
      secondChild: Text(appBarSecondaryTitle),
      firstCurve: Curves.easeOutQuad,
      secondCurve: Curves.easeOutQuad,
      crossFadeState: !innerBoxIsScrolled
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: appBarAutomaticallyImplyLeading,
                pinned: appBarAutomaticallyImplyLeading,
                actions: appBarActions,
                title: _buildAppBarTitle(changeAppBarTitleOnScroll,
                    innerBoxIsScrolled, appBarMainTitle, appBarSecondaryTitle),
              )
            ];
          },
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: defaultPortraitHorizontalPadding),
            child: nestedScrollViewBody,
          ),
        ),
      ),
    );
  }
}
