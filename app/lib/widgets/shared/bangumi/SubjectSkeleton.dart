import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/common/ChineseNameOwner.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/shared/utils/bangumi/common.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/images/RoundedElevatedImage.dart';

/// Skeleton of a bangumi subject. It contains:
/// A cover on the left, a name on the right side, with preferred name on the
/// top and secondary name on the second line.
/// Cover and text are in a [Row].
class SubjectSkeleton extends StatelessWidget {
  final int preferredTitleMaxLines;
  final int secondaryTitleMaxLines;

  /// [Flexible.flex] of the cover in the row.
  final int coverFlex;

  /// [Flexible.flex] of the right side text in the row.
  final int textFlex;

  final ChineseNameOwner chineseNameOwner;

  final String coverImageUrl;

  final PreferredSubjectInfoLanguage preferredSubjectInfoLanguage;

  /// Widgets that are under the subject title and on the right side of the
  /// [subject] cover.
  final List<Widget> widgetsUnderTitle;

  SubjectSkeleton({
    Key key,
    @required this.chineseNameOwner,
    @required this.coverImageUrl,
    @required this.preferredSubjectInfoLanguage,
    @required this.widgetsUnderTitle,
    this.coverFlex = 2,
    this.textFlex = 8,
    this.preferredTitleMaxLines = 2,
    this.secondaryTitleMaxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: RoundedElevatedImage(
            imageUrl: coverImageUrl ?? bangumiTextOnlySubjectCover,
          ),
          flex: coverFlex,
          fit: FlexFit.tight,
        ),
        Flexible(
          flex: textFlex,
          fit: FlexFit.tight,
          child: Padding(
            padding: const EdgeInsets.only(left: mediumOffset),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  preferredNameFromChineseNameOwner(
                    chineseNameOwner,
                    preferredSubjectInfoLanguage,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: preferredTitleMaxLines,
                ),
                if (chineseNameOwner.chineseName != null)
                  Text(
                    secondaryNameFromChineseNameOwner(
                      chineseNameOwner,
                      preferredSubjectInfoLanguage,
                    ).or(''),
                    style: defaultCaptionText(context),
                    overflow: TextOverflow.ellipsis,
                    maxLines: secondaryTitleMaxLines,
                  ),
                ...widgetsUnderTitle
              ],
            ),
          ),
        ),
      ],
    );
  }
}
