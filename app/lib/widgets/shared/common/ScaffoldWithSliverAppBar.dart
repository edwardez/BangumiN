import 'package:flutter/material.dart';
import 'package:munin/styles/theme/Common.dart';

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
  final Widget appBarMainTitle;

  /// if [changeAppBarTitleOnScroll] is set to true, this will be the AppBar title
  /// after scrolling
  final Widget appBarSecondaryTitle;
  final double appBarElevation;
  final List<Widget> appBarActions;
  final Widget nestedScrollViewBody;
  final EdgeInsetsGeometry safeAreaChildPadding;
  final bool enableLeftSafeArea;
  final bool enableTopSafeArea;
  final bool enableRightSafeArea;
  final bool enableBottomSafeArea;

  const ScaffoldWithSliverAppBar({
    Key key,
    @required this.nestedScrollViewBody,
    @required this.appBarMainTitle,
    this.appBarSecondaryTitle = const Text(''),
    this.appBarAutomaticallyImplyLeading = true,
    this.appBarPinned = true,
    this.changeAppBarTitleOnScroll = false,
    this.appBarElevation = defaultAppBarElevation,
    this.appBarActions = const [],
    this.safeAreaChildPadding = const EdgeInsets.only(
        left: defaultPortraitHorizontalPadding,
        right: defaultPortraitHorizontalPadding,
        top: largeVerticalPadding
    ),
    this.enableLeftSafeArea = true,
    this.enableTopSafeArea = false,
    this.enableRightSafeArea = true,
    this.enableBottomSafeArea = true,
  }) : super(key: key);

  _buildAppBarTitle(BuildContext context, bool changeAppBarTitleOnScroll,
      bool innerBoxIsScrolled,
      Widget appBarMainTitle, Widget appBarSecondaryTitle) {
    if (!changeAppBarTitleOnScroll) {
      return appBarMainTitle;
    }

    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 300),
      firstChild: appBarMainTitle,
      secondChild: appBarSecondaryTitle,
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
                title: _buildAppBarTitle(context, changeAppBarTitleOnScroll,
                    innerBoxIsScrolled, appBarMainTitle, appBarSecondaryTitle),
              )
            ];
          },
          body: Padding(
            padding: safeAreaChildPadding,
            child: nestedScrollViewBody,
          ),
        ),
        left: enableLeftSafeArea,
        top: enableTopSafeArea,
        right: enableRightSafeArea,
        bottom: enableBottomSafeArea,
      ),
    );
  }
}
