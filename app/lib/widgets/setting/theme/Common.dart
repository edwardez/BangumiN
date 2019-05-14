import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/setting/MuninTheme.dart';
import 'package:munin/models/bangumi/setting/ThemeSetting.dart';
import 'package:munin/models/bangumi/setting/ThemeSwitchMode.dart';
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
