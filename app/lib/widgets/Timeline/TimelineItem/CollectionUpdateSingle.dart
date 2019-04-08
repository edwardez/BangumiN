import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/timeline/CollectionUpdateSingle.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/TimelineCommonListTile.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/TimelineUserListTile.dart';
import 'package:munin/widgets/shared/cover/CachedRoundedCover.dart';
import 'package:quiver/strings.dart';

class CollectionUpdateSingleWidget extends StatelessWidget {
  final CollectionUpdateSingle collectionUpdateSingle;

  const CollectionUpdateSingleWidget({
    Key key,
    @required this.collectionUpdateSingle,
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
        TimelineUserListTile.fromUser(
          user: collectionUpdateSingle.user,
          score: collectionUpdateSingle.subjectScore,
        ),
        _buildCommentWidget(collectionUpdateSingle.subjectComment),
        TimelineCommonListTile(
          leadingWidget: CachedRoundedCover.asGridSize(
            imageUrl: collectionUpdateSingle.subjectImageUrl,
          ),
          title: collectionUpdateSingle.subjectTitle,
          onTap: () {
            Application
                .router
                .navigateTo(context,
                '/subject/${collectionUpdateSingle.subjectId}',
                transition: TransitionType.native);
          },
        ),
      ],
    );
  }
}
