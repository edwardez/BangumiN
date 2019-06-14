import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/search/result/SubjectSearchResultItem.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/models/bangumi/subject/Rating.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/shared/utils/bangumi/common.dart';
import 'package:munin/widgets/search/MonoSearchResultWidget.dart';
import 'package:munin/widgets/shared/images/RoundedElevatedImage.dart';
import 'package:munin/widgets/shared/utils/common.dart';
import 'package:quiver/core.dart';

/// TODO: we should reuse code in this class and [MonoSearchResultWidget]
class SubjectSearchResultWidget extends StatelessWidget {
  final SubjectSearchResultItem subjectSearchResult;
  final PreferredSubjectInfoLanguage preferredSubjectInfoLanguage;

  static const double paddingBetweenSubject = 8.0;
  static const double coverTextPadding = 10.0;
  static const int coverFlex = 2;
  static const int textFlex = 8;

  const SubjectSearchResultWidget({Key key,
    @required this.subjectSearchResult,
    @required this.preferredSubjectInfoLanguage})
      : super(key: key);

  List<Widget> _buildSubInfoRows(BuildContext context) {
    List<Widget> subInfoRows = [];
    const titleMaxLines = 2;
    const subtitleMaxLines = 1;
    const miscMaxLines = 1;
    TextStyle captionStyle = Theme.of(context).textTheme.caption;

    subInfoRows.add(Text(
      preferredName(subjectSearchResult.name,
          subjectSearchResult.nameCn,
          preferredSubjectInfoLanguage),
      maxLines: titleMaxLines,
      overflow: TextOverflow.ellipsis,
    ));

    Optional<String> maybeSecondaryTitle = secondaryName(
        subjectSearchResult.name,
        subjectSearchResult.nameCn,
        preferredSubjectInfoLanguage);

    if (maybeSecondaryTitle.isPresent) {
      subInfoRows.add(Text(
        maybeSecondaryTitle.value,
        style: captionStyle,
        maxLines: subtitleMaxLines,
        overflow: TextOverflow.ellipsis,
      ));
    }

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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: RoundedElevatedImage(
                imageUrl: subjectSearchResult.image?.large,
              ),
              flex: coverFlex,
              fit: FlexFit.tight,
            ),
            Flexible(
              flex: textFlex,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(left: coverTextPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildSubInfoRows(context),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: generateOnTapCallbackForBangumiContent(
          contentType: BangumiContent.Subject,
          id: subjectSearchResult.id.toString(),
          context: context),
    );
  }
}
