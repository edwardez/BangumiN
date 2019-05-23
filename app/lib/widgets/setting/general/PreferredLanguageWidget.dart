import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/widgets/setting/theme/Common.dart';
import 'package:munin/widgets/shared/common/TransparentDividerThemeContext.dart';

class PreferredLanguageWidget extends StatelessWidget {
  final PreferredSubjectInfoLanguage currentSubjectLanguage;

  final Function(PreferredSubjectInfoLanguage language) onSubjectLanguageUpdate;

  const PreferredLanguageWidget(
      {Key key,
      @required this.currentSubjectLanguage,
      @required this.onSubjectLanguageUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeWithTransparentDivider(
      child: ExpansionTile(
        key: PageStorageKey<String>(
            'general-setting-preferredSubjectInfoLanguage'),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text('作品标题优先使用'),
                ),
                Text(currentSubjectLanguage.chineseName),
              ],
            ),
          ],
        ),
        children: <Widget>[
          for (PreferredSubjectInfoLanguage language
              in PreferredSubjectInfoLanguage.values.toList())
            ListTile(
              title: Text(language.chineseName),
              trailing: buildTrailingIcon<PreferredSubjectInfoLanguage>(
                  context, currentSubjectLanguage, language),
              onTap: () {
                onSubjectLanguageUpdate(language);
              },
              subtitle: language == PreferredSubjectInfoLanguage.Chinese
                  ? Text('仅在信息可用时生效')
                  : null,
            )
        ],
      ),
    );
  }
}
