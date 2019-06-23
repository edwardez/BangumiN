import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/config/application.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/router/routes.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/widgets/search/home/SearchHomeDelegate.dart';
import 'package:munin/widgets/shared/avatar/CachedCircleAvatar.dart';
import 'package:redux/redux.dart';

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
    return _OneMuninBarState();
  }
}

class _OneMuninBarState extends State<OneMuninBar> {
  SearchHomeDelegate searchHomeDelegate;

  @override
  void initState() {
    searchHomeDelegate = SearchHomeDelegate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String>(
      converter: (Store<AppState> store) =>
          store.state?.currentAuthenticatedUserBasicInfo?.avatar?.large ??
          bangumiAnonymousUserMediumAvatar,
      distinct: true,
      builder: (BuildContext context, String avatarUrl) {
        return SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            centerTitle: true,
            elevation: 0.5,
            title: widget.title,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                tooltip: '搜索',
                onPressed: () {
                  showSearch(context: context, delegate: searchHomeDelegate);
                },
              ),
              Padding(
                padding:
                    EdgeInsets.only(right: widget.appBarActionRightPadding),
                child: IconButton(
                  icon: CachedCircleAvatar(
                    imageUrl: avatarUrl,
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
      },
    );
  }
}
