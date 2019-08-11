import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:munin/models/bangumi/setting/theme/ThemeSetting.dart';
import 'package:munin/models/bangumi/setting/theme/ThemeSwitchMode.dart';
import 'package:munin/models/bangumi/setting/version/MuninVersionInfo.dart';
import 'package:munin/providers/bangumi/BangumiCookieService.dart';
import 'package:munin/providers/bangumi/user/BangumiUserService.dart';
import 'package:munin/redux/app/AppActions.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/setting/Common.dart';
import 'package:munin/redux/setting/SettingActions.dart';
import 'package:munin/shared/exceptions/utils.dart';
import 'package:munin/shared/utils/analytics/Constants.dart';
import 'package:munin/shared/utils/misc/Launch.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';
import 'package:package_info/package_info.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:screen/screen.dart';
import 'package:upgrader/upgrader.dart';

const Duration listenToBrightnessChangeInterval = const Duration(seconds: 5);

List<Epic<AppState>> createSettingEpics(BangumiUserService bangumiUserService,
    BangumiCookieService httpService,) {
  final changeThemeByScreenBrightnessEpic =
  _createChangeThemeByScreenBrightnessEpic();

  final updateThemeSettingEpic = _createUpdateThemeSettingEpic();

  final createImportBlockedBangumiUsersEpic =
  _createImportBlockedBangumiUsersEpic(bangumiUserService);

  final getLatestVersionEpic = _createGetLatestVersionEpic();

  return [
    changeThemeByScreenBrightnessEpic,
    updateThemeSettingEpic,
    createImportBlockedBangumiUsersEpic,
    getLatestVersionEpic,
  ];
}

/// Note: [Screen.brightness] returns value between 0 and 1 so we need to manually
/// convert it to 0~100 scale
Stream<dynamic> _changeThemeByScreenBrightness(UpdateThemeSettingAction action,
) async* {
  ThemeSetting themeSetting = action.themeSetting;

  bool shouldChangeToDarkTheme(int roundedDeviceBrightness) {
    return roundedDeviceBrightness <=
        themeSetting.preferredFollowBrightnessSwitchThreshold &&
        themeSetting.currentTheme !=
            action.themeSetting.preferredFollowBrightnessDarkTheme;
  }

  bool shouldChangeToLightTheme(int currentDeviceBrightness) {
    return currentDeviceBrightness >
        themeSetting.preferredFollowBrightnessSwitchThreshold &&
        themeSetting.currentTheme !=
            action.themeSetting.preferredFollowBrightnessLightTheme;
  }

  try {
    if (themeSetting.themeSwitchMode ==
        ThemeSwitchMode.FollowScreenBrightness) {
      int roundedDeviceBrightness =
      roundDeviceBrightnessToPercentage(await Screen.brightness);
      if (shouldChangeToDarkTheme(roundedDeviceBrightness)) {
        yield UpdateThemeSettingAction(
          themeSetting: themeSetting.rebuild(
                  (b) =>
              b
                ..currentTheme = b.preferredFollowBrightnessDarkTheme),
          persistToDisk: true,
        );
      } else if (shouldChangeToLightTheme(roundedDeviceBrightness)) {
        yield UpdateThemeSettingAction(
          themeSetting: themeSetting.rebuild(
                  (b) =>
              b
                ..currentTheme = b.preferredFollowBrightnessLightTheme),
          persistToDisk: true,
        );
      }
    }
  } catch (error, stack) {
    reportError(error, stack: stack);
  }
}

/// Starts or aborts listening to screen brightness depends on user settings
/// We don't need to manually unsubscribe to stream here since `switchMap` handles
/// it
Epic<AppState> _createChangeThemeByScreenBrightnessEpic() {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<UpdateThemeSettingAction>())
        .switchMap<UpdateThemeSettingAction>((action) {
      if (action.themeSetting.themeSwitchMode ==
          ThemeSwitchMode.FollowScreenBrightness) {
        /// If theme mode has changed to [ThemeSwitchMode.FollowScreenBrightness]
        /// Start endlessly listening to screen brightness
        /// A special `Observable.just` with same action is attached to the stream
        /// since `Observable.periodic` starts emitting values only after first
        /// `listenToBrightnessChangeInterval` is ended and user expects to see
        /// changes immediately after they modified relevant `themeSetting` values
        return Observable.concat([
          Observable.just(action),
          Observable.periodic(listenToBrightnessChangeInterval, (i) => action)
        ]);
      } else {
        /// Otherwise, just emit a empty value to abort the stream
        return Observable.empty();
      }
    }).switchMap((action) => _changeThemeByScreenBrightness(action));
  };
}

Stream<dynamic> _updateThemeSetting(EpicStore<AppState> store,
    UpdateThemeSettingAction action,
) async* {
  try {
    /// New theme must be either light or dark theme
    assert(action.themeSetting.currentTheme.isLightTheme ||
        action.themeSetting.currentTheme.isDarkTheme);
    if (action.persistToDisk) {
      final newState = store.state.rebuild(
              (b) => b.settingState.themeSetting.replace(action.themeSetting));
      yield PersistAppStateAction(
        basicAppStateOnly: true,
        appState: newState,
      );
    }
  } catch (error, stack) {
    reportError(error, stack: stack);
  }
}

Epic<AppState> _createUpdateThemeSettingEpic() {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<UpdateThemeSettingAction>())
        .switchMap((action) => _updateThemeSetting(store, action));
  };
}

Stream<dynamic> _createImportBlockedBangumiUsers(BangumiUserService bangumiUserService,
    ImportBlockedBangumiUsersRequestAction action,
) async* {
  try {
    BuiltMap<String, MutedUser> users =
    await bangumiUserService.importBlockedUser();
    yield ImportBlockedBangumiUsersResponseSuccessAction(users: users);
  } catch (error, stack) {
    print(error.toString());
    print(stack);
  }
}

Epic<AppState> _createImportBlockedBangumiUsersEpic(BangumiUserService bangumiUserService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<ImportBlockedBangumiUsersRequestAction>())
        .switchMap((action) =>
        _createImportBlockedBangumiUsers(bangumiUserService, action));
  };
}

final _lineSplitter = LineSplitter();

Stream<dynamic> _getLatestVersionEpic(Appcast appcast,
    EpicStore<AppState> store,
    GetLatestMuninVersionRequestAction action,) async* {
  try {
    await appcast.parseAppcastItemsFromUri(upgradeInfoUrl);

    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = Version.parse(packageInfo.version);
    final bestItem = appcast.bestItem();
    // Version info in store, might be null.
    var muninVersionInStore = store.state.settingState.muninVersionInfo;

    // note that [criticalUpdateItem] might be different from [bestItem]
    // i.e. A minor fix is released after a critical update.
    AppcastItem availableCriticalUpdate;
    for (var item in appcast.items) {
      final itemVersion = Version.parse(item.versionString);
      if (itemVersion.compareTo(currentVersion) <= 0) {
        break;
      } else {
        if (item.isCriticalUpdate ?? false) {
          availableCriticalUpdate = item;
        }
      }
    }

    bool userRefuseInstallLatestCriticalUpdate = false;
    final currentMutedUpdateVersion = muninVersionInStore?.mutedUpdateVersion;
    print('$currentMutedUpdateVersion $availableCriticalUpdate');
    if (currentMutedUpdateVersion != null && availableCriticalUpdate != null) {
      if (Version.parse(availableCriticalUpdate.versionString)
          .compareTo(Version.parse(currentMutedUpdateVersion)) <=
          0) {
        userRefuseInstallLatestCriticalUpdate = true;
      }
    }

    String updatedMutedVersion;
    if (bestItem != null &&
        availableCriticalUpdate != null &&
        !userRefuseInstallLatestCriticalUpdate) {
      await showDialog(
          context: action.context,
          barrierDismissible: false,
          builder: (innerContext) {
            String updateDescription;
            if (availableCriticalUpdate.itemDescription != null) {
              // Removes extra white space in xml.
              updateDescription =
                  _lineSplitter.convert(availableCriticalUpdate.itemDescription)
                      .map((s) => s.trim())
                      .join('\n');
            }

            updateDescription ??= '重要更新';
            return AlertDialog(
              title: Text('有一个未安装的重要更新'),
              content: SingleChildScrollView(
                child: WrappableText(
                  '更新内容为:$updateDescription\n',
                  maxLines: null,
                  outerWrapper: OuterWrapper.Row,
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('不再提醒此版本'),
                  onPressed: () {
                    Navigator.pop(innerContext);
                    // Latest version must be older or equal to best item.
                    // hence set to bestItem so user is harder to get notified.
                    updatedMutedVersion = bestItem.versionString;
                    FirebaseAnalytics().logEvent(
                        name: InstallUpdatePromptEvent.name,
                        parameters: {
                          InstallUpdatePromptEvent.refuseToInstall: 1,
                          InstallUpdatePromptEvent.agreeToInstall: 0,
                          InstallUpdatePromptEvent.criticalUpdateVersion:
                          availableCriticalUpdate.versionString
                        });
                  },
                ),
                FlatButton(
                  child: Text('下载安装包'),
                  onPressed: () {
                    launchWithExternalBrowser(innerContext, bestItem.fileURL,
                        popContext: true);
                    FirebaseAnalytics().logEvent(
                        name: InstallUpdatePromptEvent.name,
                        parameters: {
                          InstallUpdatePromptEvent.refuseToInstall: 0,
                          InstallUpdatePromptEvent.agreeToInstall: 1,
                          InstallUpdatePromptEvent.criticalUpdateVersion:
                          availableCriticalUpdate.versionString
                        });
                  },
                ),
              ],
            );
          });
    }

    if (muninVersionInStore == null) {
      muninVersionInStore = MuninVersionInfo((b) =>
      b
        ..downloadPageUrl = bestItem.fileURL
        ..latestVersion = bestItem.versionString
        ..hasCriticalUpdate = availableCriticalUpdate != null
        ..mutedUpdateVersion = updatedMutedVersion);
    } else {
      muninVersionInStore = muninVersionInStore.rebuild((b) =>
      b
        ..downloadPageUrl = bestItem.fileURL
        ..latestVersion = bestItem.versionString
        ..hasCriticalUpdate = availableCriticalUpdate != null
        ..mutedUpdateVersion =
            updatedMutedVersion ?? muninVersionInStore.mutedUpdateVersion);
    }

    yield GetLatestMuninVersionSuccessAction(
      muninVersionInfo: muninVersionInStore,
    );

    if (updatedMutedVersion != null) {
      // TODO: figure out a way to dispatch another action after the first is
      // completed.
      await Future.delayed(Duration(seconds: 1));
      yield PersistAppStateAction(basicAppStateOnly: true);
    }
    action.completer.complete();
  } catch (error, stack) {
    action.completer.completeError(error);
    reportError(error, stack: stack);
  }
}

Epic<AppState> _createGetLatestVersionEpic() {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<GetLatestMuninVersionRequestAction>())
        .switchMap((action) => _getLatestVersionEpic(Appcast(), store, action));
  };
}
