import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/setting/ThemeSetting.dart';

/// Updates the whole theme settings.
class UpdateThemeSettingAction {
  final ThemeSetting themeSetting;

  /// Whether theme setting should be persisted to disk after updating
  /// default to false
  final bool persistToDisk;

  UpdateThemeSettingAction(
      {@required this.themeSetting, this.persistToDisk = false});
}
