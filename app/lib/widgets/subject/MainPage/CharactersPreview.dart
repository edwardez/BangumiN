import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/subject/BangumiSubject.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';
import 'package:munin/widgets/subject/common/HorizontalCharacters.dart';

class CharactersPreview extends StatelessWidget {
  final BangumiSubject subject;

  const CharactersPreview({Key key, @required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            WrappableText(
              '角色介绍',
              fit: FlexFit.tight,
            ),
            IconButton(
              icon: Icon(AdaptiveIcons.forwardIconData),
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
          ],
        ),
        HorizontalCharacters(
          characters: subject.characters,
        )
      ],
    );
  }
}