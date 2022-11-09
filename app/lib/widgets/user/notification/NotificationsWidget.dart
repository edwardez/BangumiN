import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/user/notification/BaseNotificationItem.dart';
import 'package:munin/models/bangumi/user/notification/NotificationState.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/user/UserActions.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/refresh/MuninRefresh.dart';
import 'package:munin/widgets/user/notification/NotificationItemWidget.dart';
import 'package:redux/redux.dart';

class NotificationsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotificationsWidgetState();
  }
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  final _muninRefreshKey = GlobalKey<MuninRefreshState>();

  bool onlyUnread = true;

  Widget _buildUnreadNotificationSummary(_ViewModel vm) {
    assert(vm.notificationState.unreadNotificationItems != null);

    final unreadCount =
        vm.notificationState.unreadNotificationItems?.length ?? 0;

    if (unreadCount == 0) {
      return ListTile(
        title: Text('暂无新通知'),
        subtitle: Text('暂不支持收件箱提醒'),
      );
    } else {
      return ListTile(
        title: Text('收到$unreadCount条新通知'),
        subtitle: Text('暂不支持收件箱提醒'),
        trailing: OutlinedButton(
          child: Text('全部标为已读'),
          onPressed: () async {
            clearNotification(context, () {
              return vm.clearNotifications(
                  ClearUnreadNotificationsAction.clearAll());
            }, true);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      onInitialBuild: (vm) {
        _muninRefreshKey.currentState?.callOnRefresh();
      },
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel vm) {
        BuiltList<BaseNotificationItem> notificationItems;
        final unreadNotificationItems =
            vm.notificationState.unreadNotificationItems;

        if (onlyUnread) {
          notificationItems = unreadNotificationItems;
        } else {
          notificationItems = vm.notificationState.allNotificationItems;
        }

        return MuninRefresh(
          key: _muninRefreshKey,
          onRefresh: () => vm.listNotifications(onlyUnread: onlyUnread),
          itemCount: notificationItems?.length ?? 0,
          showSnackbarOnError: true,
          topWidgets: <Widget>[
            if (unreadNotificationItems != null)
              _buildUnreadNotificationSummary(vm),
            SwitchListTile.adaptive(
              value: onlyUnread,
              title: Text('只看未读'),
              activeColor: lightPrimaryDarkAccentColor(context),
              onChanged: (newValue) {
                setState(() {
                  onlyUnread = newValue;
                  _muninRefreshKey.currentState?.callOnRefresh();
                });
              },
            )
          ],
          appBar: SliverAppBar(
            title: Text('通知'),
            pinned: true,
            elevation: defaultSliverAppBarElevation,
          ),
          onLoadMore: null,
          itemBuilder: (BuildContext context, int index) {
            return NotificationItemWidget(
              item: notificationItems[index],
              onlyUnreadMode: onlyUnread,
              onClearNotification: (int notificationId) {
                return vm.clearNotifications(
                    ClearUnreadNotificationsAction.clearSingle(notificationId));
              },
              onAddFriend: (int userId) {
                return vm.changeFriendRelationship(
                    ChangeFriendRelationshipRequestAction(
                  userId,
                  ChangeFriendRelationshipType.Add,
                ));
              },
            );
          },
        );
      },
    );
  }
}

class _ViewModel {
  final NotificationState notificationState;

  final Future Function({
    bool onlyUnread,
  }) listNotifications;

  final Future Function(ClearUnreadNotificationsAction action)
      clearNotifications;

  final Future Function(ChangeFriendRelationshipRequestAction action)
      changeFriendRelationship;

  factory _ViewModel.fromStore(
    Store<AppState> store,
  ) {
    Future<void> _listNotifications({
      onlyUnread = true,
    }) {
      final action = ListNotificationItemsAction(onlyUnread: onlyUnread);

      store.dispatch(action);

      return action.completer.future;
    }

    Future<void> _clearNotifications(ClearUnreadNotificationsAction action) {
      store.dispatch(action);

      return action.completer.future;
    }

    Future<void> _changeFriendRelationship(
        ChangeFriendRelationshipRequestAction action) {
      store.dispatch(action);

      // Refresh notifications on complete.
      action.completer.future.whenComplete(() {
        _listNotifications();
      });

      return action.completer.future;
    }

    return _ViewModel(
      store.state.userState.notificationState,
      _listNotifications,
      _clearNotifications,
      _changeFriendRelationship,
    );
  }

  _ViewModel(
    this.notificationState,
    this.listNotifications,
    this.clearNotifications,
    this.changeFriendRelationship,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          notificationState == other.notificationState;

  @override
  int get hashCode => notificationState.hashCode;
}
