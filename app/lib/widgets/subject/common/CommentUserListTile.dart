import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/subject/comment/ReviewMetaInfo.dart';
import 'package:munin/widgets/shared/text/ListTileSubtitleWidget.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';

class CommentUserListTile extends StatelessWidget {
  final ReviewMetaInfo metaInfo;

  const CommentUserListTile({Key key, @required this.metaInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(metaInfo.images.medium),
      ),
      title: Padding(
        ///without this magical padding, the first star won't align properly
        ///with user name https://imgur.com/a/YqKVClo
        ///(may be using a custom Clip, or custom icon?)
        padding: const EdgeInsets.only(left: 0.7),
        child: WrappableText(
          metaInfo.nickName,
          outerWrapper: OuterWrapper.Row,
        ),
      ),
      subtitle: ListTileSubtitleWidget(
        actionName: metaInfo.actionName,
        updatedAt: metaInfo.updatedAt,
        score: metaInfo.score,
      ),
    );
  }
}
