import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/CollectionUpdateSingle.dart';
import 'package:munin/widgets/shared/common/UserListTile.dart';
import 'package:munin/widgets/shared/cover/CachedRoundedCover.dart';
import 'package:munin/widgets/shared/utils/common.dart';
import 'package:munin/widgets/timeline/TimelineBodyWidget.dart';
import 'package:munin/widgets/timeline/item/common/FeedMoreActionsMenu.dart';
import 'package:munin/widgets/timeline/item/common/TimelineCommonListTile.dart';
import 'package:quiver/strings.dart';

class CollectionUpdateSingleWidget extends StatelessWidget {
  final CollectionUpdateSingle collectionUpdateSingle;
  final DeleteFeedCallback onDeleteFeed;

  const CollectionUpdateSingleWidget({
    Key key,
    @required this.collectionUpdateSingle,
    @required this.onDeleteFeed
  }) : super(key: key);

  /// https://github.com/dart-lang/sdk/issues/11155
  /// currently there is no better way to optionally build a widget other than returns a container()
  _buildCommentWidget(String subjectComment) {
    if (isEmpty(subjectComment)) {
      return Container();
    }

    return Container(
      padding: EdgeInsets.only(
        bottom: 10,
      ),

      /// TODO: "This class is relatively expensive. Avoid using it where possible."
      child: IntrinsicHeight(
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Align(
                alignment: Alignment.topCenter,
                child: Transform.scale(
                  scale: -1,
                  child: Icon(Icons.format_quote),
                )),
            Expanded(
              child: Text(subjectComment),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Icon(Icons.format_quote))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserListTile.fromUser(
          user: collectionUpdateSingle.user,
          score: collectionUpdateSingle.subjectScore,
          trailing: buildTrailingWidget(collectionUpdateSingle, onDeleteFeed),
        ),
        _buildCommentWidget(collectionUpdateSingle.subjectComment),
        TimelineCommonListTile(
          leadingWidget: CachedRoundedCover.asGridSize(
            imageUrl: collectionUpdateSingle.subjectCover.medium,
          ),
          title: collectionUpdateSingle.subjectName,
          onTap: generateOnTapCallbackForBangumiContent(
              contentType: collectionUpdateSingle.bangumiContent,
              id: collectionUpdateSingle.subjectId,
              context: context),
        ),
      ],
    );
  }
}
