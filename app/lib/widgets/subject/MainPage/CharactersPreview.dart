import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/subject/Subject.dart';
import 'package:munin/widgets/shared/text/ClippedText.dart';
import 'package:munin/widgets/subject/common/HorizontalCharacters.dart';

class CharactersPreview extends StatelessWidget {
  final Subject subject;

  const CharactersPreview({Key key, @required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            ClippedText(
              '角色介绍',
              fit: FlexFit.tight,
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
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
