import 'package:built_collection/built_collection.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:munin/redux/setting/SettingActions.dart';
import 'package:munin/redux/setting/SettingState.dart';
import 'package:redux/redux.dart';

final settingReducers = combineReducers<SettingState>([
  TypedReducer<SettingState, UpdateGeneralSettingAction>(
      updateGeneralSettingReducer),
  TypedReducer<SettingState, UpdateThemeSettingAction>(
      updateThemeActionReducer),
  TypedReducer<SettingState, UpdateMuteSettingAction>(updateMuteSettingReducer),
  TypedReducer<SettingState, UpdatePrivacySettingAction>(
      updatePrivacySettingActionReducer),
  TypedReducer<SettingState, MuteUserAction>(muteUserReducer),
  TypedReducer<SettingState, UnmuteUserAction>(unmuteUserReducer),
  TypedReducer<SettingState, MuteGroupAction>(muteGroupReducer),
  TypedReducer<SettingState, UnmuteGroupAction>(unmuteGroupReducer),
  TypedReducer<SettingState, ImportBlockedBangumiUsersResponseSuccessAction>(
      importBlockedBangumiUsersResponseReducer),
  TypedReducer<SettingState, ImportBlockedBangumiUsersConfirmAction>(
      importBlockedBangumiUsersConfirmReducer),
  TypedReducer<SettingState, ImportBlockedBangumiUsersCleanupAction>(
      importBlockedBangumiUsersCleanupReducer),
]);

///General-related
/// Mute-related
SettingState updateGeneralSettingReducer(
    SettingState settingState, UpdateGeneralSettingAction action) {
  return settingState
      .rebuild((b) => b..generalSetting.replace(action.generalSetting));
}

/// Theme-related
SettingState updateThemeActionReducer(
    SettingState settingState, UpdateThemeSettingAction action) {
  return settingState
      .rebuild((b) => b..themeSetting.replace(action.themeSetting));
}

/// Privacy-related
SettingState updatePrivacySettingActionReducer(
    SettingState settingState, UpdatePrivacySettingAction action) {
  return settingState
      .rebuild((b) => b..privacySetting.replace(action.privacySetting));
}

/// Mute-related
SettingState updateMuteSettingReducer(
    SettingState settingState, UpdateMuteSettingAction action) {
  return settingState
      .rebuild((b) => b..muteSetting.replace(action.muteSetting));
}

SettingState muteUserReducer(SettingState settingState, MuteUserAction action) {
  return settingState.rebuild((b) => b
    ..muteSetting
        .mutedUsers
        .addAll({action.mutedUser.username: action.mutedUser}));
}

SettingState unmuteUserReducer(
    SettingState settingState, UnmuteUserAction action) {
  return settingState.rebuild(
      (b) => b..muteSetting.mutedUsers.remove(action.mutedUser.username));
}

SettingState muteGroupReducer(
    SettingState settingState, MuteGroupAction action) {
  return settingState.rebuild((b) => b
    ..muteSetting
        .mutedGroups
        .addAll({action.mutedGroup.groupId: action.mutedGroup}));
}

SettingState unmuteGroupReducer(
    SettingState settingState, UnmuteGroupAction action) {
  return settingState
      .rebuild((b) => b..muteSetting.mutedGroups.remove(action.groupId));
}

SettingState importBlockedBangumiUsersResponseReducer(SettingState settingState,
    ImportBlockedBangumiUsersResponseSuccessAction action) {
  return settingState.rebuild(
      (b) => b..muteSetting.importedBangumiBlockedUsers.replace(action.users));
}

SettingState importBlockedBangumiUsersConfirmReducer(
    SettingState settingState, ImportBlockedBangumiUsersConfirmAction action) {
  BuiltMap<String, MutedUser> users =
      settingState.muteSetting.importedBangumiBlockedUsers ??
          BuiltMap<String, MutedUser>();

  return settingState
      .rebuild((b) => b..muteSetting.mutedUsers.addAll(users.toMap()));
}

SettingState importBlockedBangumiUsersCleanupReducer(
    SettingState settingState, ImportBlockedBangumiUsersCleanupAction action) {
  return settingState
      .rebuild((b) => b..muteSetting.importedBangumiBlockedUsers = null);
}
