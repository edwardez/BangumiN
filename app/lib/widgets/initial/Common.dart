import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/redux/setting/SettingActions.dart';
import 'package:munin/redux/shared/utils.dart';

/// Checks update.
///
/// Returns true to indicate this method has been called.
bool checkUpdate(BuildContext context, bool hasCheckedUpdate) {
  if (!hasCheckedUpdate && Application.environmentValue.shouldCheckUpdate) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      findStore(context).dispatch(GetLatestMuninVersionRequestAction(
        context: context,
      ));
    });
  }

  return true;
}
