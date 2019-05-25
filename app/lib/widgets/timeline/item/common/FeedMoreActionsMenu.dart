import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';
import 'package:munin/widgets/timeline/TimelineBodyWidget.dart';

buildTrailingWidget(TimelineFeed feed, DeleteFeedCallback onDeleteFeed) {
  if (onDeleteFeed == null) {
    return null;
  }

  return FeedMoreActionsMenu(
    feed: feed,
    onDeleteFeed: onDeleteFeed,
  );
}

class FeedMoreActionsMenu extends StatelessWidget {
  final DeleteFeedCallback onDeleteFeed;

  final TimelineFeed feed;

  const FeedMoreActionsMenu(
      {Key key, @required this.onDeleteFeed, @required this.feed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Icon moreActionsIcon = Icon(
      AdaptiveIcons.moreActionsIconData,
      size: smallerIconSize,
      color: Theme.of(context).textTheme.caption.color,
    );

    return InkWell(
        child: moreActionsIcon,
        onTap: () {
          showDialog(
              context: context,
              builder: (dialogContext) {
                return AlertDialog(
                  title: Text('要删除这条时间线吗？'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('不删除'),
                    ),
                    FlatButton(
                      onPressed: () {
                        onDeleteFeed(context, feed);
                        Navigator.of(context).pop();
                      },
                      child: Text('删除'),
                    ),
                  ],
                );
              });
        },
        borderRadius: BorderRadius.circular(defaultIconSize));
  }
}
