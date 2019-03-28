import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/subject/InfoBox/InfoBoxItem.dart';
import 'package:munin/models/Bangumi/subject/Subject.dart';
import 'package:munin/styles/theme/common.dart';
import 'package:munin/widgets/shared/images/RoundedElevatedImage.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';
import 'package:quiver/strings.dart';

class SubjectCoverAndBasicInfo extends StatelessWidget {
  final Subject subject;
  final int coverFlex;
  final int curatedInfoBoxFlex;

  const SubjectCoverAndBasicInfo({
    Key key,
    @required this.subject,
    this.coverFlex = 2,
    this.curatedInfoBoxFlex = 4,
  }) : super(key: key);

  _buildInfoWidgets(BuildContext context, Subject subject) {
    List<Widget> widgets = [];
    widgets.add(WrappableText(
      subject.name,
      textStyle: Theme.of(context).textTheme.subtitle,
      fit: FlexFit.tight,
      outerWrapper: OuterWrapper.Row,
      maxLines: 3,
    ));

    if (!isEmpty(subject.nameCn)) {
      widgets.add(WrappableText(
        subject.nameCn,
        textStyle: Theme
            .of(context)
            .textTheme
            .caption,
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

    Widget scoreWidget = RichText(
      text: TextSpan(children: [
        TextSpan(
            text: subject.rating.score?.toString() ?? '-',
            style: scoreStyle(context)),
        TextSpan(text: '分  ', style: Theme.of(context).textTheme.body1),
        TextSpan(
            text: '${subject.rating.total}人',
            style: Theme.of(context).textTheme.caption)
      ]),
    );

    widgets.add(scoreWidget);

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: RoundedElevatedImage(
            imageUrl: subject.images.large,
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
