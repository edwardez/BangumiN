import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/subject/RelatedSubject.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/widgets/shared/common/HorizontalScrollableWidget.dart';
import 'package:munin/widgets/shared/images/RoundedElevatedImageWithBottomText.dart';

class HorizontalRelatedSubjects extends StatelessWidget {
  static const titleMaxLines = 2;
  static const subTitleMaxLines = 1;

  /// Each line of text occupies one factor, considering spacing the final factor
  /// is * 2
  static const double textSpaceScaleBaseFactor = 1.5;

  final BuiltListMultimap<String, RelatedSubject> relatedSubjects;
  final double horizontalImagePadding;
  final double imageWidth;
  final double imageHeight;

  const HorizontalRelatedSubjects({Key key,
    @required this.relatedSubjects,
    this.horizontalImagePadding = 8.0,
    this.imageWidth = 71,
    this.imageHeight = 100.0,
  })
      : super(key: key);

  List<RoundedElevatedImageWithBottomText> _buildCharacterLists(
      BuiltListMultimap<String, RelatedSubject> relatedSubjects) {
    List<RoundedElevatedImageWithBottomText> imageWidgets = [];
    for (var subject in relatedSubjects.values) {
      imageWidgets.add(RoundedElevatedImageWithBottomText(
        contentType: BangumiContent.Subject,
        imageUrl: subject.images.medium,
        id: subject.id?.toString(),
        imageWidth: imageWidth,
        imageHeight: imageHeight,
        horizontalImagePadding:
        imageWidgets.length == 0 ? 0 : horizontalImagePadding,
        title: subject.name,
        subtitle: subject.subjectSubTypeName,
        titleMaxLines: titleMaxLines,
        subTitleMaxLines: subTitleMaxLines,
      ));
    }

    return imageWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return HorizontalScrollableWidget(
      horizontalList: _buildCharacterLists(relatedSubjects),
      listHeight:
      imageHeight + Theme
          .of(context)
          .textTheme
          .caption
          .fontSize * (titleMaxLines + subTitleMaxLines) *
          textSpaceScaleBaseFactor,
    );
  }
}
