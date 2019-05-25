import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/app/BasicAppState.dart';
import 'package:munin/redux/subject/SubjectState.dart';
import 'package:quiver/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static const appStateKey = 'MuninAppState';

  static const basicAppStateKey = 'MuninBasicAppState';

  final SharedPreferences sharedPreferences;

  SharedPreferenceService({@required this.sharedPreferences});

  /// Reads app state from shared preferences,
  /// 1. Read [BasicAppState], it's the core of Munin AppState
  /// If [BasicAppState] is empty or there is an error, returns [Optional.absent()]
  /// 2. Read [AppState], combines its value with [BasicAppState] by updating
  /// all fields other than fields in [BasicAppState], that being said,
  /// data in [BasicAppState] always has highest priority and overrides field in  [AppState]
  /// If [BasicAppState] is empty or there is an error, returns an [AppState]
  /// that has all fields other than fields in [BasicAppState] as empty
  Future<Optional<AppState>> readAppState() async {
    var serializedBasicAppState = this.sharedPreferences.get(basicAppStateKey);

    AppState appState;
    if (serializedBasicAppState != null) {
      try {
        BasicAppState basicAppState =
        BasicAppState.fromJson(serializedBasicAppState);
        appState = AppState().rebuild((b) =>
        b
          ..isAuthenticated = basicAppState.isAuthenticated
          ..settingState.replace(basicAppState.settingState)
          ..currentAuthenticatedUserBasicInfo
              .replace(basicAppState.currentAuthenticatedUserBasicInfo));
      } catch (error, stack) {
        debugPrint(
            'Error occurred during serializing BasicAppState: $error. Stack: $stack');
        return Optional.absent();
      }
    }

    var serializedAppState = this.sharedPreferences.get(appStateKey);

    if (serializedAppState != null) {
      try {
        AppState fullAppState = AppState.fromJson(serializedAppState);
        fullAppState = fullAppState.rebuild(
                (b) =>
            b
              ..currentAuthenticatedUserBasicInfo.replace(
                  appState.currentAuthenticatedUserBasicInfo)
              ..isAuthenticated = appState.isAuthenticated
              ..settingState.replace(appState.settingState)
        );
        return Optional.of(fullAppState);
      } catch (error, stack) {
        /// If data other than core data is corrupted, saves a serialized basic app
        /// state
        if (appState != null) {
          await persistAppState(appState);
        }
        debugPrint(
            'Error occurred during serializing AppState: $error. Stack: $stack');
      }
    }

    if (appState == null) {
      return Optional.absent();
    } else {
      return Optional.of(appState);
    }

  }

  /// Saves [AppState] with key [appStateKey] and a basicAppState with key
  /// [basicAppStateKey], returns true if both operations return true.
  Future<bool> persistAppState(AppState state) async {
    assert(state != null);

    /// SubjectState currently cannot be serialized
    state = state.rebuild((b) => b..subjectState.replace(SubjectState()));

    BasicAppState basicAppState = BasicAppState((b) =>
    b
      ..currentAuthenticatedUserBasicInfo
          .replace(state.currentAuthenticatedUserBasicInfo)
      ..isAuthenticated = state.isAuthenticated
      ..settingState.replace(state.settingState));

    List<bool> futures = await Future.wait([
      this.sharedPreferences.setString(appStateKey, state.toJson()),
      this.sharedPreferences.setString(basicAppStateKey, basicAppState.toJson())
    ]);

    return futures[0] && futures[1];
  }

  /// Saves [BasicAppState] with key [basicAppStateKey]
  Future<bool> persistBasicAppState(AppState state) async {
    assert(state != null);

    BasicAppState basicAppState = BasicAppState((b) =>
    b
      ..currentAuthenticatedUserBasicInfo
          .replace(state.currentAuthenticatedUserBasicInfo)
      ..isAuthenticated = state.isAuthenticated
      ..settingState.replace(state.settingState));

    return await this.sharedPreferences.setString(
        basicAppStateKey, basicAppState.toJson());
  }

  Future<bool> deleteAppState() async {
    List<bool> futures = await Future.wait([
      this.sharedPreferences.remove(appStateKey),
      this.sharedPreferences.remove(basicAppStateKey),
    ]);

    return futures[0] && futures[1];
  }
}
