import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/search/result/SubjectSearchResultItem.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/models/bangumi/subject/Rating.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/widgets/search/MonoSearchResultWidget.dart';
import 'package:munin/widgets/shared/bangumi/SubjectSkeleton.dart';
import 'package:munin/widgets/shared/utils/common.dart';

/// TODO: we should reuse code in this class and [MonoSearchResultWidget]
class SubjectSearchResultWidget extends StatelessWidget {
  final SubjectSearchResultItem subjectSearchResult;
  final PreferredSubjectInfoLanguage preferredSubjectInfoLanguage;

  static const double paddingBetweenSubject = 8.0;
  static const double coverTextPadding = 10.0;
  static const int coverFlex = 2;
  static const int textFlex = 8;

  const SubjectSearchResultWidget(
      {Key key,
      @required this.subjectSearchResult,
      @required this.preferredSubjectInfoLanguage})
      : super(key: key);

  List<Widget> _buildSubInfoRows(BuildContext context) {
    List<Widget> subInfoRows = [];
    const miscMaxLines = 1;

    List<String> miscellaneousInfo = [];
    miscellaneousInfo.add(subjectSearchResult.type.chineseName);
    if (subjectSearchResult.rating != null) {
      Rating rating = subjectSearchResult.rating;
      miscellaneousInfo.add('${rating.score}分');
      miscellaneousInfo.add('${rating.totalScoreVotesCount}人评分');
    }

    if (subjectSearchResult.isStartDateValid) {
      miscellaneousInfo.add(subjectSearchResult.startDate);
    }

    subInfoRows.add(Text(
      miscellaneousInfo.join(' / '),
      style: Theme.of(context).textTheme.caption,
      maxLines: miscMaxLines,
      overflow: TextOverflow.ellipsis,
    ));

    return subInfoRows;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: paddingBetweenSubject),
        child: SubjectSkeleton(
          widgetsUnderTitle: _buildSubInfoRows(context),
          coverImageUrl: subjectSearchResult.image?.large,
          preferredSubjectInfoLanguage: preferredSubjectInfoLanguage,
          chineseNameOwner: subjectSearchResult,
        ),
      ),
      onTap: generateOnTapCallbackForBangumiContent(
          contentType: BangumiContent.Subject,
          id: subjectSearchResult.id.toString(),
          context: context),
    );
  }
}
