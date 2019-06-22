import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/models/bangumi/subject/review/enum/SubjectReviewMainFilter.dart';
import 'package:munin/router/routes.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/text/ScoreTextOrPlaceholder.dart';

class SubjectRatingOverview extends StatelessWidget {
  final BangumiSubject subject;

  const SubjectRatingOverview({Key key, @required this.subject})
      : super(key: key);

  _buildFriendScoreWidget(BuildContext context) {
    int friendScoreVotesCount = subject.rating.friendScoreVotesCount ?? 0;

    final friendScoreWidget = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('好友评分'),
        ScoreTextOrPlaceholder.fromScoreInDouble(subject.rating.friendScore),
        Text(
          '$friendScoreVotesCount人评分',
          style: defaultCaptionText(context),
        ),
      ],
    );

    return InkWell(
      child: friendScoreWidget,
      onTap: () {
        final route = Routes.subjectReviewsRoute.replaceAll(
          RoutesVariable.subjectIdParam,
          subject.id.toString(),
        );

        Map<String, String> queryParameters = {};

        queryParameters[RoutesQueryParameter.subjectReviewsFriendOnly] = 'true';
        queryParameters[RoutesQueryParameter.subjectReviewsMainFilter] =
            SubjectReviewMainFilter.FromCompletedUsers.name;

        Application.router.navigateTo(
            context, '$route${Uri(queryParameters: queryParameters)}',
            transition: TransitionType.native);
      },
    );
  }

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
        _buildFriendScoreWidget(context),
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
