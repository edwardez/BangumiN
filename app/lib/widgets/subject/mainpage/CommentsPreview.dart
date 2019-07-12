import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/models/bangumi/subject/review/SubjectReview.dart';
import 'package:munin/router/routes.dart';
import 'package:munin/shared/utils/collections/common.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/subject/common/SubjectReviewWidget.dart';
import 'package:munin/widgets/subject/mainpage/SubjectMoreItemsEntry.dart';

class CommentsPreview extends StatelessWidget {
  final BangumiSubject subject;

  const CommentsPreview({Key key, @required this.subject}) : super(key: key);

  Widget _buildCollectionDistributionText(BuildContext context) {
    final distribution = subject.collectionStatusDistribution;
    List<String> distributionText = [];

    _updateDistributionText(int count, CollectionStatus status) {
      if (count > 0) {
        distributionText.add(
            '$count人${CollectionStatus.chineseNameWithSubjectType(status, subject.type)}');
      }
    }

    _updateDistributionText(distribution.wish, CollectionStatus.Wish);
    _updateDistributionText(distribution.completed, CollectionStatus.Completed);
    _updateDistributionText(
        distribution.inProgress, CollectionStatus.InProgress);
    _updateDistributionText(distribution.onHold, CollectionStatus.OnHold);
    _updateDistributionText(distribution.dropped, CollectionStatus.Dropped);

    return Text(
      distributionText.join(' / '),
      style: defaultCaptionText(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> commentPreviewWidgets = [];

    commentPreviewWidgets.add(
      SubjectMoreItemsEntry(
        moreItemsText: '最近收藏',
        onTap: () {
          final route = Routes.subjectReviewsRoute.replaceAll(
            RoutesVariable.subjectIdParam,
            subject.id.toString(),
          );
          Application.router
              .navigateTo(context, route, transition: TransitionType.native);
        },
      ),
    );

    if (isIterableNullOrEmpty(subject.commentsPreview)) {
      assert(!subject.collectionStatusDistribution.hasAtLeastOneCollection);

      commentPreviewWidgets.add(Center(
        child: Text(
          '暂无用户收藏',
          style: captionTextWithBody1Size(context),
        ),
      ));
    } else {
      assert(subject.collectionStatusDistribution.hasAtLeastOneCollection);

      commentPreviewWidgets.add(_buildCollectionDistributionText(context));
      for (SubjectReview review in subject.commentsPreview) {
        commentPreviewWidgets.add(SubjectReviewWidget(
          subject: subject,
          review: review,
        ));
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: commentPreviewWidgets,
    );
  }
}
