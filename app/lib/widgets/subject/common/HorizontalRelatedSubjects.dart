import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/subject/RelatedSubject.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/widgets/shared/common/HorizontalScrollableWidget.dart';
import 'package:munin/widgets/shared/images/RoundedImageWithVerticalText.dart';

class HorizontalRelatedSubjects extends StatelessWidget {
  final BuiltListMultimap<String, RelatedSubject> relatedSubjects;
  final double horizontalImagePadding;
  final double imageWidth;
  final double imageHeight;

  /// related subject has title, subtitle, each counts for 1 factor, we add 1 more for spacing
  final int textFactor = 3;

  HorizontalRelatedSubjects(
      {Key key,
      @required this.relatedSubjects,
      this.horizontalImagePadding = 2.0,
      this.imageHeight = 48.0,
      this.imageWidth = 48.0})
      : super(key: key);

  List<RoundedImageWithVerticalText> _buildCharacterLists(
      BuiltListMultimap<String, RelatedSubject> relatedSubjects) {
    List<RoundedImageWithVerticalText> imageWidgets = [];
    for (var subject in relatedSubjects.values) {
      imageWidgets.add(RoundedImageWithVerticalText(
        contentType: BangumiContent.Subject,
        imageUrl: subject.images.medium,
        id: subject.id?.toString(),
        imageHeight: imageHeight,
        imageWidth: imageWidth,
        horizontalImagePadding:
            imageWidgets.length == 0 ? 0 : horizontalImagePadding,
        title: subject.name,
        subtitle: subject.subjectSubTypeName,
      ));
    }

    return imageWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return HorizontalScrollableWidget(
      horizontalList: _buildCharacterLists(relatedSubjects),
      listHeight:
          imageHeight + Theme.of(context).textTheme.body1.fontSize * textFactor,
    );
  }
}
