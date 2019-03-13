import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/timeline/BlogCreationSingle.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/TimelineUserListTile.dart';

class BlogCreationSingleWidget extends StatelessWidget {
  final BlogCreationSingle blogCreationSingle;

  BlogCreationSingleWidget({@required this.blogCreationSingle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TimelineUserListTile(
          user: blogCreationSingle.user,
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
