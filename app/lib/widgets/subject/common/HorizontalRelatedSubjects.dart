import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/models/bangumi/subject/RelatedSubject.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/shared/utils/bangumi/common.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/common/HorizontalScrollableWidget.dart';
import 'package:munin/widgets/shared/images/RoundedElevatedImageWithBottomText.dart';

class HorizontalRelatedSubjects extends StatelessWidget {
  static const titleMaxLines = 2;
  static const subTitleMaxLines = 1;

  /// Each line of text occupies one factor, considering spacing the final factor
  /// is * 2
  static const double textSpaceScaleBaseFactor = 1.5;

  final Iterable<RelatedSubject> relatedSubjects;
  final PreferredSubjectInfoLanguage preferredSubjectInfoLanguage;

  final double imageWidth;
  final double imageHeight;

  final bool displaySubtitle;

  const HorizontalRelatedSubjects({
    Key key,
    @required this.relatedSubjects,
    @required this.preferredSubjectInfoLanguage,
    this.imageWidth = 71,
    this.imageHeight = 100.0,
    this.displaySubtitle = true,
  }) : super(key: key);

  List<RoundedElevatedImageWithBottomText> _buildCharacterLists(
      Iterable<RelatedSubject> relatedSubjects) {
    List<RoundedElevatedImageWithBottomText> imageWidgets = [];
    for (var subject in relatedSubjects) {
      imageWidgets.add(RoundedElevatedImageWithBottomText(
        contentType: BangumiContent.Subject,
        imageUrl: subject.cover.medium,
        id: subject.id?.toString(),
        imageWidth: imageWidth,
        imageHeight: imageHeight,
        padding: EdgeInsets.only(right: mediumOffset),
        title:
            preferredNameFromSubjectBase(subject, preferredSubjectInfoLanguage),
        subtitle: displaySubtitle ? subject.subjectSubTypeName : null,
        titleMaxLines: titleMaxLines,
        subTitleMaxLines: subTitleMaxLines,
      ));
    }

    return imageWidgets;
  }

  @override
  Widget build(BuildContext context) {
    final titleLines = titleMaxLines + (displaySubtitle ? subTitleMaxLines : 0);

    return HorizontalScrollableWidget(
      horizontalList: _buildCharacterLists(relatedSubjects),
      listHeight: imageHeight +
          Theme.of(context).textTheme.caption.fontSize *
              titleLines *
              textSpaceScaleBaseFactor *
              MediaQuery
                  .of(context)
                  .textScaleFactor,
    );
  }
}
