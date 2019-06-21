import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/models/bangumi/user/collection/full/CollectionOnUserList.dart';
import 'package:munin/shared/utils/time/TimeUtils.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/background/RoundedConcreteBackground.dart';
import 'package:munin/widgets/shared/bangumi/SubjectSkeleton.dart';
import 'package:munin/widgets/shared/common/MuninPadding.dart';
import 'package:munin/widgets/shared/common/SubjectStars.dart';
import 'package:munin/widgets/shared/utils/common.dart';

class CollectionOnUserListWidget extends StatelessWidget {
  static const int coverFlex = 2;
  static const int textFlex = 8;

  final CollectionOnUserList collection;

  final PreferredSubjectInfoLanguage preferredSubjectInfoLanguage;

  const CollectionOnUserListWidget({
    Key key,
    @required this.collection,
    @required this.preferredSubjectInfoLanguage,
  }) : super(key: key);

  String get collectionDate {
    return TimeUtils.formatMilliSecondsEpochTime(
      collection.collectedTimeMilliSeconds,
      displayTimeIn: DisplayTimeIn.AlwaysAbsolute,
      formatAbsoluteTimeAs: AbsoluteTimeFormat.DateOnly,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: MuninPadding(
        child: SubjectSkeleton(
          coverImageUrl: collection.subject.cover.medium,
          preferredSubjectInfoLanguage: preferredSubjectInfoLanguage,
          widgetsUnderTitle: <Widget>[
            Text(
              collection.subject.additionalInfo,
              style: defaultCaptionText(context),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: RoundedConcreteBackground(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (collection.tags.isNotEmpty)
                          Text(
                            '标签: ${collection.tags.join(' ')}',
                            style: defaultCaptionText(context),
                          ),
                        Row(
                          children: <Widget>[
                            if (collection.rating != null)
                              Padding(
                                padding: EdgeInsets.only(right: baseOffset),
                                child: SubjectStars(
                                  subjectScore: collection.rating.toDouble(),
                                  starSize: 12,
                                ),
                              ),
                            Text(
                              collectionDate,
                              style: defaultCaptionText(context),
                            ),
                          ],
                        ),
                        if (collection.comment != null)
                          Text(
                            collection.comment,
                            style: captionTextWithHigherOpacity(context),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
          chineseNameOwner: collection.subject,
        ),
      ),
      onTap: generateOnTapCallbackForBangumiContent(
        contentType: BangumiContent.Subject,
        id: collection.subject.id.toString(),
        context: context,
      ),
    );
  }
}
