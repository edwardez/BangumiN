import 'package:badges/badges.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/redux/shared/utils.dart';
import 'package:munin/router/routes.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/widgets/search/home/SearchHomeDelegate.dart';
import 'package:munin/widgets/shared/avatar/CachedCircleAvatar.dart';
import 'package:munin/widgets/user/notification/NotificationIcon.dart';
import 'package:munin/widgets/user/notification/NotificationsWidget.dart';

/// A unified app bar that's displayed on the top of each munin home page
/// TODO: change avatar to actual user avatar and change fixed constants to
/// variables
/// TODO: figure out whether this appbar can be initialized fewer times
class OneMuninBar extends StatefulWidget {
  /// Right side padding of actions from edge.
  /// A hacky way to pad app bar from right edge
  final double appBarActionRightPadding;

  final Widget title;

  /// Whether a notification widget should be attached to the left side of the
  /// app bar.
  final bool addNotificationWidget;

  const OneMuninBar({
    Key key,
    this.appBarActionRightPadding = 8.0,
    @required this.title,
    this.addNotificationWidget = false,
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

  _navigateToNotification() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              Scaffold(
                body: NotificationsWidget(),
              )),
    );
  }

  Widget _buildCountWidget(BuildContext context, int count) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    final textScaleFactor = MediaQuery
        .of(context)
        .textScaleFactor;

    final badgeTextStyle = textTheme.caption.copyWith(
        color: Colors.white, fontSize: textTheme.caption.fontSize * 0.85);

    // 2.5: padding on each side plus 0.5 buffer
    final size =
        (badgeTextStyle.fontSize + NotificationIcon.baseBadgeEdgeOffset * 2.5) *
            textScaleFactor;

    return InkWell(
      child: Container(
        constraints: BoxConstraints.tight(Size.square(size)),
        child: Center(
            child: Text(
              '$count',
              style: badgeTextStyle,
            )),
      ),
      onTap: () {
        _navigateToNotification();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        automaticallyImplyLeading: false,
        pinned: true,
        centerTitle: true,
        elevation: 0.5,
        title: title,
        leading: widget.addNotificationWidget
            ? NotificationIcon(
          child: IconButton(
                  icon: Icon(isCupertinoPlatform()
                      ? CupertinoIcons.bell
                      : Icons.notifications_none_rounded),
                  onPressed: () {
                    _navigateToNotification();
                  },
                ),
                position: BadgePosition.topEnd(top: 10, end: 10),
                countWidgetBuilder: _buildCountWidget,
              )
            : null,
        actions: <Widget>[
          IconButton(
            icon: Icon(isCupertinoPlatform() ? CupertinoIcons.search : Icons
                .search_rounded),
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
