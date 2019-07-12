import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/models/bangumi/subject/review/enum/SubjectReviewMainFilter.dart';
import 'package:munin/router/routes.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/bottomsheet/showMinHeightModalBottomSheet.dart';
import 'package:munin/widgets/shared/text/ScoreTextOrPlaceholder.dart';
import 'package:munin/widgets/subject/common/Common.dart';
import 'package:url_launcher/url_launcher.dart';

class SubjectRatingOverview extends StatelessWidget {
  static const wholeWebsiteScoreLabel = '全站评分';
  static const friendScoreLabel = '好友评分';
  static const myScoreLabel = '我的评分';

  final BangumiSubject subject;

  const SubjectRatingOverview({Key key, @required this.subject})
      : super(key: key);

  _navigateToReviews(BuildContext context, {
    friendOnly = false,
    popContext = false,
  }) {
    final route = Routes.subjectReviewsRoute.replaceAll(
      RoutesVariable.subjectIdParam,
      subject.id.toString(),
    );

    Map<String, String> queryParameters = {};

    queryParameters[RoutesQueryParameter.subjectReviewsFriendOnly] =
        friendOnly.toString();
    queryParameters[RoutesQueryParameter.subjectReviewsMainFilter] =
        SubjectReviewMainFilter.FromCompletedUsers.name;
    if (popContext) {
      Navigator.pop(context);
    }

    Application.router.navigateTo(
        context, '$route${Uri(queryParameters: queryParameters)}',
        transition: TransitionType.native);
  }

  String get semanticsScoreDescription {
    const placeHolder = ScoreTextOrPlaceholder.scorePlaceHolderText;
    return '$wholeWebsiteScoreLabel为${subject.rating.score ?? placeHolder},'
        '${subject.rating.totalScoreVotesCount}人评分。'
        '$friendScoreLabel为${subject.rating.friendScore ?? placeHolder},'
        '${subject.rating.friendScoreVotesCount}人评分。'
        '$myScoreLabel为${subject.userSubjectCollectionInfoPreview.score ??
        placeHolder},'
        '我的收藏状态为：$subjectActionText。';
  }

  String get subjectActionText =>
      CollectionStatus.chineseNameWithSubjectType(
          subject.userSubjectCollectionInfoPreview.status, subject.type,
          fallbackChineseName: '未收藏');

  _buildFriendScoreWidget(BuildContext context) {
    int friendScoreVotesCount = subject.rating.friendScoreVotesCount ?? 0;

    final friendScoreWidget = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(friendScoreLabel),
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
        _navigateToReviews(
          context,
          friendOnly: true,
        );
      },
    );
  }

  _buildAllUserScoreWidget(BuildContext context) {
    return InkWell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(wholeWebsiteScoreLabel),
          ScoreTextOrPlaceholder.fromScoreInDouble(subject.rating.score),
          Text(
            '${subject.rating.totalScoreVotesCount}人评分',
            style: defaultCaptionText(context),
          ),
        ],
      ),
      onTap: () {
        showMinHeightModalBottomSheet(context, [
          ListTile(
            title: Text('查看用户评论'),
            onTap: () {
              _navigateToReviews(
                context,
                popContext: true,
              );
            },
          ),
          ListTile(
            title: Text('$goToForsetiPrompt查看统计数据'),
            onTap: () {
              launch(
                  'https://${Application.environmentValue
                      .forsetiMainHost}/subject/${subject.id}/statistics');
            },
          ),
        ]);
      },
    );
  }

  _buildMyScoreWidget(context) {
    return InkWell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(myScoreLabel),
          ScoreTextOrPlaceholder.fromScoreInInt(
              subject.userSubjectCollectionInfoPreview.score),
          Text(
            subjectActionText,
            style: defaultCaptionText(context),
          ),
        ],
      ),
      onTap: () {
        showMinHeightModalBottomSheet(context, [
          ListTile(
            title: Text(collectionActionText(subject)),
            onTap: () {
              Navigator.pop(context);
              navigateToSubjectCollection(context, subject.id);
            },
          ),
        ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildAllUserScoreWidget(context),
          _buildFriendScoreWidget(context),
          _buildMyScoreWidget(context),
        ],
      ),
      label: semanticsScoreDescription,
    );
  }
}
