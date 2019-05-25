import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/BlogCreationSingle.dart';
import 'package:munin/widgets/shared/common/UserListTile.dart';
import 'package:munin/widgets/timeline/TimelineBodyWidget.dart';
import 'package:munin/widgets/timeline/item/common/FeedMoreActionsMenu.dart';

class BlogCreationSingleWidget extends StatelessWidget {
  final BlogCreationSingle blogCreationSingle;
  final DeleteFeedCallback onDeleteFeed;

  BlogCreationSingleWidget(
      {@required this.blogCreationSingle, @required this.onDeleteFeed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserListTile.fromUser(
          user: blogCreationSingle.user,
          trailing: buildTrailingWidget(blogCreationSingle, onDeleteFeed),
        ),
        Column(
          children: <Widget>[
            Center(
              child: RichText(
                  maxLines: 1, // blog title is forced to have 1 max line
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: blogCreationSingle.title,
                    style: Theme.of(context).textTheme.body2,
                  )),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: blogCreationSingle.summary,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
