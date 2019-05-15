import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/text/ScoreTextOrPlaceholder.dart';

class SubjectRatingOverview extends StatelessWidget {
  final BangumiSubject subject;

  const SubjectRatingOverview({Key key, @required this.subject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('全站均分'),
            ScoreTextOrPlaceholder.fromScoreInDouble(subject.rating.score),
            Text(
              '${subject.rating.totalScoreVotesCount}人评分',
              style: defaultCaptionText(context),
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('好友评分'),
            ScoreTextOrPlaceholder.fromScoreInDouble(
                subject.rating.friendScore),
            Text(
              '${subject.rating.friendScoreVotesCount ?? 0}人评分',
              style: defaultCaptionText(context),
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('我的评分'),
            ScoreTextOrPlaceholder.fromScoreInInt(
                subject.userSubjectCollectionInfoPreview.score),
            Text(
              CollectionStatus.chineseNameWithSubjectType(
                  subject.userSubjectCollectionInfoPreview.status, subject.type,
                  fallbackChineseName: '未收藏'),
              style: defaultCaptionText(context),
            ),
          ],
        )
      ],
    );
  }
}
