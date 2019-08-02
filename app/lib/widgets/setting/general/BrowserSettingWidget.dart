import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/setting/general/browser/LaunchBrowserPreference.dart';
import 'package:munin/widgets/shared/selection/MuninExpansionSelection.dart';

class BrowserSettingWidget extends StatelessWidget {
  final LaunchBrowserPreference currentLaunchBrowserPreference;

  final Function(LaunchBrowserPreference launchBrowserPreference) onTapOption;

  const BrowserSettingWidget({
    Key key,
    @required this.currentLaunchBrowserPreference,
    @required this.onTapOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MuninExpansionSelection<LaunchBrowserPreference>(
      expansionKey:
          PageStorageKey<String>('general-setting-LaunchBrowserPreference'),
      title: Text('打开链接时使用'),
      optionTitleBuilder: (selection) => Text(selection.chineseName),
      optionSubTitleBuilder: (selection) {
        return Text(selection.subChineseName);
      },
      options: LaunchBrowserPreference.values,
      currentSelection: currentLaunchBrowserPreference ??
          LaunchBrowserPreference.DefaultInApp,
      onTapOption: onTapOption,
    );
  }
}
