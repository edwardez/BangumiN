import 'package:munin/redux/setting/SettingActions.dart';
import 'package:munin/redux/setting/SettingState.dart';
import 'package:redux/redux.dart';

final settingReducers = combineReducers<SettingState>([
  TypedReducer<SettingState, UpdateThemeSettingAction>(
      updateThemeActionReducer),
]);

SettingState updateThemeActionReducer(
    SettingState settingState, UpdateThemeSettingAction action) {
  return settingState
      .rebuild((b) => b..themeSetting.replace(action.themeSetting));
}
