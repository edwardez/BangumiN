import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/user/notification/BaseNotificationItem.dart';
import 'package:munin/models/bangumi/user/notification/FriendshipRequestNotificationItem.dart';
import 'package:munin/shared/exceptions/utils.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/avatar/CachedCircleAvatar.dart';
import 'package:munin/widgets/shared/button/FilledFlatButton.dart';
import 'package:munin/widgets/shared/common/MuninPadding.dart';
import 'package:munin/widgets/shared/common/SnackBar.dart';
import 'package:munin/widgets/shared/dialog/common.dart';
import 'package:munin/widgets/shared/html/BangumiHtml.dart';

clearNotification(
  BuildContext context,
  Future Function() onClearNotification,
  bool clearAllNotifications,
) async {
  showTextOnSnackBar(
    context,
    '标为已读中...',
    shortDuration: true,
  );

  try {
    await onClearNotification();

    final howManyNotificationsLabel = clearAllNotifications ? '全部' : '此';

    showTextOnSnackBar(context, '已标记$howManyNotificationsLabel通知为已读');
  } catch (error) {
    showTextOnSnackBar(context, '无法清空通知:${formatErrorMessage(error)}');
  }
}

class NotificationItemWidget extends StatelessWidget {
  final bool onlyUnreadMode;
  final BaseNotificationItem item;

  final Future Function(int notificationId) onClearNotification;

  final Future Function(int userId) onAddFriend;

  const NotificationItemWidget({
    Key key,
    @required this.onlyUnreadMode,
    @required this.item,
    @required this.onClearNotification,
    @required this.onAddFriend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: MuninPadding(
        denseHorizontal: true,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CachedCircleAvatar(
              imageUrl: item.initiator.avatar.medium,
              username: item.initiator.username,
              navigateToUserRouteOnTap: true,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: baseOffset),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.initiator.nickname,
                    style: textTheme(context).subtitle1,
                  ),
                  BangumiHtml(
                    html: item.bodyContentHtml,
                  ),
                  if (item is FriendshipRequestNotificationItem &&
                      onlyUnreadMode)
                    Row(
                      children: <Widget>[
                        OutlineButton(
                          child: Text('忽略'),
                          onPressed: () {
                            clearNotification(context, () {
                              return onClearNotification(item.id);
                            }, false);
                          },
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: mediumOffset),
                        ),
                        FilledFlatButton(
                          child: Text('确认'),
                          onPressed: () async {
                            showTextOnSnackBar(
                              context,
                              '正在通过好友请求...',
                              shortDuration: true,
                            );

                            final nickname = item.initiator.nickname;
                            try {
                              await onAddFriend(item.initiator.id);

                              showTextOnSnackBar(
                                  context, '已成功添加 $nickname 为好友');
                            } catch (error) {
                              showTextOnSnackBar(
                                  context,
                                  '添加 $nickname 为好友时出错:'
                                  '${formatErrorMessage(error)}');
                            }
                          },
                        ),
                      ],
                    )
                ],
              ),
            )
          ],
        ),
      ),
      onTap: onlyUnreadMode
          ? () async {
              final isAddFriendRequest =
                  item is FriendshipRequestNotificationItem && onlyUnreadMode;
              final confirm = await showMuninYesNoDialog(
                context,
                title: Text('要标记此通知为已读吗？'),
                content: isAddFriendRequest ? Text('这条好友请求将会被忽略') : null,
                cancelAction: Text('否'),
                confirmAction: Text('是，标为已读'),
              );
              if (confirm == true) {
                clearNotification(context, () {
                  return onClearNotification(item.id);
                }, false);
              }
            }
          : null,
    );
  }
}
