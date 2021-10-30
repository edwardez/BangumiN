import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/setting/theme/MuninTheme.dart';
import 'package:munin/models/bangumi/setting/theme/ThemeSetting.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/selection/MuninExpansionSelection.dart';

class FollowSystemThemeOptions extends StatefulWidget {
  final bool showHiddenTheme;

  final ThemeSetting themeSetting;

  final Function(MuninTheme newTheme) onLightThemePreferenceChange;

  final Function(MuninTheme newTheme) onDarkThemePreferenceChange;

  const FollowSystemThemeOptions(
      {Key key,
      this.showHiddenTheme,
      this.themeSetting,
      this.onLightThemePreferenceChange,
      this.onDarkThemePreferenceChange})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FollowSystemThemeOptionsState();
  }
}

class _FollowSystemThemeOptionsState extends State<FollowSystemThemeOptions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Divider(),
        ListTile(
          title: Text(
            '主题偏好',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: lightPrimaryDarkAccentColor(context)),
          ),
        ),
        MuninExpansionSelection<MuninTheme>(
          expansionKey: PageStorageKey<String>(
              'theme-setting-follow-system-bright-preference'),
          title: Text('明亮模式下偏好主题'),
          optionTitleBuilder: (selection) => Text(selection.chineseName),
          options: MuninTheme.availableLightThemes(widget.showHiddenTheme),
          currentSelection: widget.themeSetting.preferredFollowSystemLightTheme,
          onTapOption: (theme) {
            widget.onLightThemePreferenceChange(theme);
          },
          transparentDivider: false,
        ),
        MuninExpansionSelection<MuninTheme>(
          expansionKey: PageStorageKey<String>(
              'theme-setting-follow-system-dark-preference'),
          title: Text('黑暗模式下偏好主题'),
          optionTitleBuilder: (selection) => Text(selection.chineseName),
          options: MuninTheme.availableDarkThemes(),
          currentSelection: widget.themeSetting.preferredFollowSystemDarkTheme,
          onTapOption: (theme) {
            widget.onDarkThemePreferenceChange(theme);
          },
          transparentDivider: false,
        ),
      ],
    );
  }
}
