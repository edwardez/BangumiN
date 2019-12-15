import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/setting/theme/MuninTheme.dart';
import 'package:munin/models/bangumi/setting/theme/ThemeSetting.dart';
import 'package:munin/models/bangumi/setting/theme/ThemeSwitchMode.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/setting/SettingActions.dart';
import 'package:munin/shared/utils/misc/DeviceInfo.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/setting/theme/Common.dart';
import 'package:munin/widgets/setting/theme/FollowScreenBrightnessThemeOptions.dart';
import 'package:munin/widgets/setting/theme/FollowSystemThemeOptions.dart';
import 'package:munin/widgets/setting/theme/ManualThemeOptions.dart';
import 'package:munin/widgets/shared/common/ScrollViewWithSliverAppBar.dart';
import 'package:munin/widgets/shared/dialog/common.dart';
import 'package:redux/redux.dart';

class ThemeSettingWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ThemeSettingWidgetState();
  }
}

class _ThemeSettingWidgetState extends State<ThemeSettingWidget> {
  static const hiddenThemeTriggerTappedTimesThreshold = 7;
  static const optionsFadeInDurationInMilliSeconds = 500;

  var hasActivatedHiddenThemeTrigger = false;
  var hiddenThemeTriggerTappedTimes = 0;

  /// Support info for dark mode.
  ///
  /// Relevant settings should be disabled if this is null.
  DarkModeSupportInfo darkModeSupportInfo;

  showHiddenThemeConfirmationDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('iuz iyon =tagl-du igur-ea?'),
          actions: <Widget>[
            FlatButton(
              child: Text("gee"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("hau"),
              onPressed: () {
                setState(() {
                  hasActivatedHiddenThemeTrigger = true;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool showOptionsUnderSwitchMode(
      ThemeSwitchMode targetMode, ThemeSetting setting) {
    if (setting.themeSwitchMode == targetMode) {
      return true;
    }

    return false;
  }

  Future<void> onSelectFollowSystemTheme(_ViewModel vm) async {
    final showAlertDialog = darkModeSupportInfo.darkModeAvailability ==
            DarkModeAvailability.unavailable ||
        darkModeSupportInfo.darkModeAvailability ==
            DarkModeAvailability.unknown;
    if (showAlertDialog) {
      final concatSupportedVersions =
          darkModeSupportInfo.minimumSupportedPlatformVersion.join('\n');
      final shouldEnable = await showMuninYesNoDialog(context,
          title: Text('不受支持的选项'),
          content: Text(''
              '主题跟随系统仅支持:\n'
              '$concatSupportedVersions\n'
              '检测当前系统版本为一个不受支持的版本: ${darkModeSupportInfo.currentSystemVersion}\n'
              '如果你确信这是一个错误，可以尝试启用此模式，但此选项可能无效，或带来未知的后果'),
          confirmAction: Text('仍然启用'),
          cancelAction: Text('放弃更改'));

      if (!shouldEnable) return;
    }

    setState(() {
      if (vm.themeSetting.themeSwitchMode !=
          ThemeSwitchMode.FollowSystemThemeSetting) {
        vm.updateThemeSetting(vm.themeSetting.rebuild((b) =>
            b..themeSwitchMode = ThemeSwitchMode.FollowSystemThemeSetting));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      distinct: true,
      onInit: (Store<AppState> store) {
        hasActivatedHiddenThemeTrigger =
            store.state.settingState.themeSetting.hasSelectedHiddenTheme;
      },
      onDispose: (Store<AppState> store) {
        store.dispatch(UpdateThemeSettingAction(
            themeSetting: store.state.settingState.themeSetting,
            persistToDisk: true));
      },
      builder: (BuildContext context, _ViewModel vm) {
        return ScrollViewWithSliverAppBar(
          enableTopSafeArea: false,
          enableBottomSafeArea: false,
          safeAreaChildPadding:
              const EdgeInsets.only(left: 0, right: 0, top: largeOffset),
          appBarMainTitle: GestureDetector(
            child: Text(
              '主题',
            ),
            onTap: () {
              hiddenThemeTriggerTappedTimes++;
              if (hiddenThemeTriggerTappedTimes >=
                      hiddenThemeTriggerTappedTimesThreshold &&
                  !hasActivatedHiddenThemeTrigger) {
                showHiddenThemeConfirmationDialog();
              }
            },
          ),
          nestedScrollViewBody: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Text(
                    '切换方式',
                    style: Theme.of(context)
                        .textTheme
                        .body2
                        .copyWith(color: lightPrimaryDarkAccentColor(context)),
                  ),
                ),
                ListTile(
                  title: Text(
                    '手动',
                    style: Theme
                        .of(context)
                        .textTheme
                        .body2,
                  ),
                  subtitle: Text(
                    '只在手动更改设置后切换',
                  ),
                  trailing: buildTrailingIcon<ThemeSwitchMode>(context,
                      vm.themeSetting.themeSwitchMode, ThemeSwitchMode.Manual),
                  onTap: () {
                    setState(() {
                      if (vm.themeSetting.themeSwitchMode !=
                          ThemeSwitchMode.Manual) {
                        vm.updateThemeSetting(vm.themeSetting.rebuild((b) =>
                        b..themeSwitchMode = ThemeSwitchMode.Manual));
                      }
                    });
                  },
                ),
                ListTile(
                  title: Text(
                    '跟随屏幕亮度',
                    style: Theme
                        .of(context)
                        .textTheme
                        .body2,
                  ),
                  subtitle: Text(
                    '跟随屏幕亮度自动切换',
                  ),
                  trailing: buildTrailingIcon<ThemeSwitchMode>(
                      context,
                      vm.themeSetting.themeSwitchMode,
                      ThemeSwitchMode.FollowScreenBrightness),
                  onTap: () {
                    setState(() {
                      if (vm.themeSetting.themeSwitchMode !=
                          ThemeSwitchMode.FollowScreenBrightness) {
                        vm.updateThemeSetting(vm.themeSetting.rebuild((b) =>
                        b
                          ..themeSwitchMode =
                              ThemeSwitchMode.FollowScreenBrightness));
                      }
                    });
                  },
                ),
                ListTile(
                  enabled: darkModeSupportInfo != null,
                  title: Text(
                    '跟随系统',
                    style: darkModeSupportInfo != null
                        ? Theme
                        .of(context)
                        .textTheme
                        .body2
                        : null,
                  ),
                  subtitle: Text(
                    darkModeSupportInfo != null
                        ? '跟随系统主题设置（需设备支持）'
                        : '获取信息中...',
                  ),
                  trailing: buildTrailingIcon<ThemeSwitchMode>(context,
                      vm.themeSetting.themeSwitchMode,
                      ThemeSwitchMode.FollowSystemThemeSetting),
                  onTap: () => onSelectFollowSystemTheme(vm),
                ),
                if (showOptionsUnderSwitchMode(
                  ThemeSwitchMode.Manual,
                  vm.themeSetting,
                ))
                  ManualThemeOptions(
                    themeSetting: vm.themeSetting,
                    showHiddenTheme: hasActivatedHiddenThemeTrigger,
                    onUpdateTheme: (MuninTheme newTheme) {
                      setState(() {
                        vm.updateThemeSetting(vm.themeSetting
                            .rebuild((b) => b..currentTheme = newTheme));
                      });
                    },
                  ),
                if (showOptionsUnderSwitchMode(
                  ThemeSwitchMode.FollowScreenBrightness,
                  vm.themeSetting,
                ))
                  FollowScreenBrightnessThemeOptions(
                    themeSetting: vm.themeSetting,
                    showHiddenTheme: hasActivatedHiddenThemeTrigger,
                    onBrightnessSwitchThresholdChange:
                        (int newBrightnessThreshold) {
                      vm.updateThemeSetting(vm.themeSetting.rebuild((b) => b
                        ..preferredFollowBrightnessSwitchThreshold =
                            newBrightnessThreshold));
                    },
                    onLightThemePreferenceChange: (MuninTheme newTheme) {
                      vm.updateThemeSetting(vm.themeSetting.rebuild((b) =>
                      b..preferredFollowBrightnessLightTheme = newTheme));
                    },
                    onDarkThemePreferenceChange: (MuninTheme newTheme) {
                      vm.updateThemeSetting(vm.themeSetting.rebuild((b) =>
                      b..preferredFollowBrightnessDarkTheme = newTheme));
                    },
                  ),

                if (showOptionsUnderSwitchMode(
                  ThemeSwitchMode.FollowSystemThemeSetting,
                  vm.themeSetting,
                ))
                  FollowSystemThemeOptions(
                    themeSetting: vm.themeSetting,
                    showHiddenTheme: hasActivatedHiddenThemeTrigger,
                    onLightThemePreferenceChange: (MuninTheme newTheme) {
                      vm.updateThemeSetting(vm.themeSetting.rebuild((b) =>
                      b..preferredFollowSystemLightTheme = newTheme));
                    },
                    onDarkThemePreferenceChange: (MuninTheme newTheme) {
                      vm.updateThemeSetting(vm.themeSetting.rebuild((b) =>
                      b..preferredFollowSystemDarkTheme = newTheme));
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    checkDarkThemeSupport().then(
          (v) =>
      {
        setState(() {
          darkModeSupportInfo = v;
        })
      },
    );
  }
}

class _ViewModel {
  final ThemeSetting themeSetting;
  final void Function(ThemeSetting themeSetting) updateThemeSetting;

  factory _ViewModel.fromStore(Store<AppState> store) {
    _updateThemeSetting(
      ThemeSetting themeSetting, {
      persisToDisk = true,
    }) {
      store.dispatch(UpdateThemeSettingAction(
          themeSetting: themeSetting, persistToDisk: persisToDisk));
    }

    return _ViewModel(
      themeSetting: store.state.settingState.themeSetting,
      updateThemeSetting: _updateThemeSetting,
    );
  }

  _ViewModel({@required this.themeSetting, @required this.updateThemeSetting});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          themeSetting == other.themeSetting;

  @override
  int get hashCode => themeSetting.hashCode;
}
