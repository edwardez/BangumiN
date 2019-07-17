import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/redux/shared/utils.dart';
import 'package:munin/router/routes.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/widgets/search/home/SearchHomeDelegate.dart';
import 'package:munin/widgets/shared/avatar/CachedCircleAvatar.dart';

/// A unified app bar that's displayed on the top of each munin home page
/// TODO: change avatar to actual user avatar and change fixed constants to
/// variables
/// TODO: figure out whether this appbar can be initialized fewer times
class OneMuninBar extends StatefulWidget {
  /// Right side padding of actions from edge.
  /// A hacky way to pad app bar from right edge
  final double appBarActionRightPadding;

  final Widget title;

  const OneMuninBar({
    Key key,
    this.appBarActionRightPadding = 8.0,
    @required this.title,
  })  : assert(title != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return OneMuninBarState();
  }
}

class OneMuninBarState extends State<OneMuninBar> {
  SearchHomeDelegate searchHomeDelegate;
  Widget title;

  @override
  void initState() {
    super.initState();
    searchHomeDelegate = SearchHomeDelegate();
    title = widget.title;
  }

  void setNewTitle(Widget newTitle) {
    setState(() {
      title = newTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        automaticallyImplyLeading: false,
        pinned: true,
        centerTitle: true,
        elevation: 0.5,
        title: title,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: '搜索',
            onPressed: () {
              showSearch(context: context, delegate: searchHomeDelegate);
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: widget.appBarActionRightPadding),
            child: IconButton(
              icon: CachedCircleAvatar(
                imageUrl: findAppState(context)
                    ?.currentAuthenticatedUserBasicInfo
                    ?.avatar
                    ?.large ??
                    bangumiAnonymousUserMediumAvatar,
                radius: 15.0,
                navigateToUserRouteOnTap: false,

                /// maybe avoid hard coding this value?
              ),
              tooltip: '头像，更多选项',
              onPressed: () {
                Application.router.navigateTo(context, Routes.settingRoute,
                    transition: TransitionType.native);
              },
            ),
          )
        ]);
  }
}
