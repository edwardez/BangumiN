import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/setting/theme/MuninTheme.dart';
import 'package:munin/models/bangumi/setting/theme/ThemeSetting.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/setting/theme/Common.dart';

class ManualThemeOptions extends StatelessWidget {
  final bool showHiddenTheme;

  final ThemeSetting themeSetting;

  final Function(MuninTheme newTheme) onUpdateTheme;

  const ManualThemeOptions({
    Key key,
    @required this.onUpdateTheme,
    @required this.themeSetting,
    @required this.showHiddenTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(),
        ListTile(
          title: Text(
            '当前主题',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: lightPrimaryDarkAccentColor(context)),
          ),
        ),
        for (MuninTheme theme in MuninTheme.allAvailableThemes(showHiddenTheme))
          ListTile(
            title: Text(theme.chineseName),
            trailing: buildTrailingIcon<MuninTheme>(
                context, themeSetting.currentTheme, theme),
            onTap: () {
              onUpdateTheme(theme);
            },
          ),
      ],
    );
  }
}
