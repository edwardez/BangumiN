import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/widgets/subject/common/HorizontalCharacters.dart';
import 'package:munin/widgets/subject/mainpage/SubjectMoreItemsEntry.dart';

class CharactersPreview extends StatelessWidget {
  final BangumiSubject subject;

  const CharactersPreview({Key key, @required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SubjectMoreItemsEntry(
          moreItemsText: '角色介绍',
          onTap: () {},
        ),
        HorizontalCharacters(
          characters: subject.characters,
        )
      ],
    );
  }
}
