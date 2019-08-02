import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/widgets/shared/selection/MuninExpansionSelection.dart';

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
    return MuninExpansionSelection<PreferredSubjectInfoLanguage>(
      expansionKey: PageStorageKey<String>(
          'general-setting-preferredSubjectInfoLanguage'),
      title: Text('作品标题优先使用'),
      optionTitleBuilder: (selection) =>
          Text(selection.chineseName),
      optionSubTitleBuilder: (language) {
        return language == PreferredSubjectInfoLanguage.Chinese
            ? Text('仅在信息可用时生效')
            : null;
      },
      options: PreferredSubjectInfoLanguage.values,
      currentSelection: currentSubjectLanguage,
      onTapOption: (language) {
        onSubjectLanguageUpdate(language);
      },
    );
  }
}
