import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

// Changes android system ui overlay style to match currency system brightness.
changeAndroidSystemUIOverlay() async {
  if (!Platform.isAndroid) {
    return;
  }

  final brightness = WidgetsBinding.instance.window.platformBrightness;
  switch (brightness) {
    case Brightness.dark:
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
      break;
    case Brightness.light:
    default:
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ));
      if (brightness != Brightness.light) {
        print('Unhandled brightness enum $brightness, falling back to light');
      }
  }
}