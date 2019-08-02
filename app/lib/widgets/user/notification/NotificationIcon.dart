import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:redux/redux.dart';

class NotificationIcon extends StatelessWidget {
  /// Max badge count, if notification count is higher than this, max count
  /// will be displayed instead.
  static const _maxBadgeCount = 99;

  /// Padding content offset in pixel.
  static const baseBadgeEdgeOffset = 2.0;

  /// The child that badge is displayed on top of.
  final Widget child;

  /// position of the badge.
  final BadgePosition position;

  /// Padding inside the badge.
  final EdgeInsets padding;

  /// builder function for the badge content. Default to null and a red dot will
  /// be displayed.
  final Function(BuildContext context, int count) countWidgetBuilder;

  const NotificationIcon({
    Key key,
    @required this.child,
    @required this.position,
    this.padding = const EdgeInsets.all(baseBadgeEdgeOffset),
    this.countWidgetBuilder,
  }) : super(key: key);

  int maxDisplayableBadgeCount(int unreadCount) {
    return min(_maxBadgeCount, unreadCount);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, int>(
      distinct: true,
      converter: (Store<AppState> store) {
        return store.state.userState.notificationState?.unreadNotificationItems
                ?.length ??
            0;
      },
      builder: (BuildContext context, int unreadCount) {
        final maxDisplayableCount = maxDisplayableBadgeCount(unreadCount);
        return Badge(
          position: position,
          badgeColor: Colors.red[600],
          elevation: 0.5,
          showBadge: maxDisplayableCount > 0,
          padding: padding,
          badgeContent: countWidgetBuilder == null
              ? null
              : countWidgetBuilder(context, maxDisplayableCount),
          toAnimate: false,
          child: child,
        );
      },
    );
  }
}
