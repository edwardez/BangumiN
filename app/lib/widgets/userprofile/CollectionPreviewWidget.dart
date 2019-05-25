import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/models/bangumi/user/collection/CollectionPreview.dart';
import 'package:munin/models/bangumi/user/collection/SubjectPreview.dart';
import 'package:munin/widgets/shared/cover/ClickableCachedRoundedCover.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';
import 'package:url_launcher/url_launcher.dart';

class CollectionPreviewWidget extends StatelessWidget {
  static const double coverPadding = 8.0;
  static const double outerBottomPadding = 8.0;

  final String userName;
  final CollectionPreview preview;

  const CollectionPreviewWidget(
      {Key key, @required this.preview, @required this.userName})
      : super(key: key);

  String _formatWithBulletPoint(String subjectName) => '•  $subjectName';

  _navigateToCollectionPage(SubjectType subjectType) {
    String url =
        'https://${Application.environmentValue.bangumiMainHost}/${subjectType.toString().toLowerCase()}/list/$userName';
    launch(url, forceSafariVC: false);
  }

  @override
  Widget build(BuildContext context) {
    if (preview.collectionDistribution.keys.isEmpty) {
      debugPrint('Unexpected empty collection preview $preview');
      return Container();
    }
    CollectionStatus firstNonEmptyStatus = preview.subjects.keys.first;
    SubjectType subjectType = preview.subjectType;
    Row commonHeader = Row(
      children: <Widget>[
        WrappableText(
          '${subjectType.chineseName}收藏',
          textStyle: Theme.of(context).textTheme.subhead,
          fit: FlexFit.tight,
        ),
        Row(
          children: <Widget>[
            Text(
              '${preview.totalCollectionCount}',
              style: Theme.of(context).textTheme.caption,
            ),
            Icon(
              AdaptiveIcons.forwardIconData,
              size: Theme.of(context).textTheme.caption.fontSize,
              color: Theme.of(context).textTheme.caption.color,
            )
          ],
        )
      ],
    );

    Widget collectionWidget;
    if (preview.subjects[firstNonEmptyStatus].isEmpty) {
      debugPrint('Unexpected collection empty preview subjetcs $preview');
      collectionWidget = Container();
    } else if (preview.onPlainTextPanel) {
      List<Widget> subjects =
          preview.subjects[firstNonEmptyStatus].map((SubjectPreview subject) {
        return RichText(
          text: TextSpan(children: [
            TextSpan(
                text: _formatWithBulletPoint(subject.name),
                style: Theme.of(context).textTheme.body1),
          ]),
        );
      }).toList();
      collectionWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          commonHeader,
          Text(
              '${CollectionStatus.chineseNameWithSubjectType(firstNonEmptyStatus, subjectType)}'),
          ...subjects
        ],
      );
    } else {
      List<Widget> subjects =
          preview.subjects[firstNonEmptyStatus].map((SubjectPreview subject) {
        return ClickableCachedRoundedCover.asGridSize(
          imageUrl: subject.cover.medium,
          contentType: BangumiContent.Subject,
          id: subject.id.toString(),
        );
      }).toList();
      collectionWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          commonHeader,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
                '${CollectionStatus.chineseNameWithSubjectType(firstNonEmptyStatus, subjectType)}'),
          ),
          Wrap(
            runSpacing: coverPadding,
            spacing: coverPadding,
            children: [...subjects],
          )
        ],
      );
    }

    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(bottom: outerBottomPadding),
        child: collectionWidget,
      ),
      onTap: () {
        _navigateToCollectionPage(subjectType);
      },
    );
  }
}
