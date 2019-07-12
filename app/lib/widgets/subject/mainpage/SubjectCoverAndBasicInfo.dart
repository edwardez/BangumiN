import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/models/bangumi/subject/info/InfoBoxItem.dart';
import 'package:munin/shared/utils/bangumi/common.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/images/RoundedElevatedImage.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';
import 'package:quiver/core.dart';

class SubjectCoverAndBasicInfo extends StatelessWidget {
  final PreferredSubjectInfoLanguage preferredSubjectInfoLanguage;

  final BangumiSubject subject;

  /// Whether score info should be displayed at the end of info box rows
  final bool displayScore;
  final int coverFlex;
  final int curatedInfoBoxFlex;

  const SubjectCoverAndBasicInfo({
    Key key,
    @required this.subject,
    this.coverFlex = 2,
    this.curatedInfoBoxFlex = 4,
    this.displayScore = false,
    this.preferredSubjectInfoLanguage = PreferredSubjectInfoLanguage.Original,
  }) : super(key: key);

  _buildInfoWidgets(BuildContext context, BangumiSubject subject) {
    List<Widget> widgets = [];
    widgets.add(WrappableText(
      preferredNameFromSubjectBase(subject, preferredSubjectInfoLanguage),
      textStyle: Theme.of(context).textTheme.subtitle,
      fit: FlexFit.tight,
      outerWrapper: OuterWrapper.Row,
      maxLines: 3,
    ));

    Optional<String> maybeSecondaryTitle =
        secondaryNameFromSubjectBase(subject, preferredSubjectInfoLanguage);
    if (maybeSecondaryTitle.isPresent) {
      widgets.add(WrappableText(
        maybeSecondaryTitle.value,
        textStyle: Theme.of(context).textTheme.caption,
        fit: FlexFit.tight,
        outerWrapper: OuterWrapper.Row,
        maxLines: 3,
      ));
    }

    if (subject.curatedInfoBoxRows != null) {
      subject.curatedInfoBoxRows
          .forEachKey((String rowName, Iterable<InfoBoxItem> infoBoxItem) {
        String concatenatedInfoBoxItem = infoBoxItem
            .expand((InfoBoxItem infoBoxItem) => [infoBoxItem.name])
            .join('');
        widgets.add(WrappableText(
          '$rowName: $concatenatedInfoBoxItem',
          maxLines: 3,
          top: 3.0,
          bottom: 3.0,
        ));
      });
    }

    if (displayScore) {
      Widget scoreWidget = RichText(
        text: TextSpan(children: [
          TextSpan(
              text: subject.rating.score?.toString() ?? '-',
              style: scoreStyle(context)),
          TextSpan(text: '分  ', style: Theme.of(context).textTheme.body1),
          TextSpan(
              text: '${subject.rating.totalScoreVotesCount}人',
              style: Theme.of(context).textTheme.caption)
        ]),
      );

      widgets.add(scoreWidget);
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: RoundedElevatedImage(
            imageUrl: subject.cover.large,
            elevation: 2.0,
          ),
          flex: coverFlex,
          fit: FlexFit.tight,
        ),
        Flexible(
          flex: curatedInfoBoxFlex,
          fit: FlexFit.tight,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildInfoWidgets(context, subject),
            ),
          ),
        ),
      ],
    );
  }
}
