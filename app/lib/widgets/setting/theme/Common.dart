import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/setting/theme/MuninTheme.dart';
import 'package:munin/models/bangumi/setting/theme/ThemeSetting.dart';
import 'package:munin/models/bangumi/setting/theme/ThemeSwitchMode.dart';
import 'package:munin/widgets/setting/Common.dart';

Icon buildSwitchModeTrailingIcon(BuildContext context, ThemeSetting setting,
    ThemeSwitchMode currentOptionMode) {
  if (setting.themeSwitchMode == currentOptionMode) {
    return selectedOptionTrailingIcon(context);
  } else {
    return null;
  }
}

Icon buildThemeStyleTrailingIcon(BuildContext context, MuninTheme selectedTheme,
    MuninTheme currentThemeOption) {
  if (selectedTheme == currentThemeOption) {
    return selectedOptionTrailingIcon(context);
  } else {
    return null;
  }
}
