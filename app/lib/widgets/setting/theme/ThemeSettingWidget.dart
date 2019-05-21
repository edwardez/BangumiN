import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/setting/theme/MuninTheme.dart';
import 'package:munin/models/bangumi/setting/theme/ThemeSetting.dart';
import 'package:munin/models/bangumi/setting/theme/ThemeSwitchMode.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/setting/SettingActions.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/setting/theme/Common.dart';
import 'package:munin/widgets/setting/theme/FollowScreenBrightnessThemeOptions.dart';
import 'package:munin/widgets/setting/theme/ManualThemeOptions.dart';
import 'package:munin/widgets/shared/common/ScaffoldWithSliverAppBar.dart';
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

  bool hasActivatedHiddenThemeTrigger = false;
  int hiddenThemeTriggerTappedTimes = 0;

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
        return ScaffoldWithSliverAppBar(
          enableTopSafeArea: false,
          enableBottomSafeArea: false,
          safeAreaChildPadding: const EdgeInsets.only(
              left: 0, right: 0, top: largeVerticalPadding),
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
                    style: Theme.of(context).textTheme.body2,
                  ),
                  subtitle: Text(
                    '只在手动更改设置后切换',
                  ),
                  trailing: buildSwitchModeTrailingIcon(
                      context, vm.themeSetting, ThemeSwitchMode.Manual),
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
                    style: Theme.of(context).textTheme.body2,
                  ),
                  subtitle: Text(
                    '跟随屏幕亮度自动切换',
                  ),
                  trailing: buildSwitchModeTrailingIcon(context,
                      vm.themeSetting, ThemeSwitchMode.FollowScreenBrightness),
                  onTap: () {
                    setState(() {
                      if (vm.themeSetting.themeSwitchMode !=
                          ThemeSwitchMode.FollowScreenBrightness) {
                        vm.updateThemeSetting(vm.themeSetting.rebuild((b) => b
                          ..themeSwitchMode =
                              ThemeSwitchMode.FollowScreenBrightness));
                      }
                    });
                  },
                ),

//              ListTile(
//                  title: Text(
//                    '跟随系统',
//                    style: Theme.of(context).textTheme.body2,
//                  ),
//                  subtitle: Text(
//                    '跟随系统主题设置（需设备支持系统系黑暗主题）',
//                  )),
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
              ],
            ),
          ),
        );
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
