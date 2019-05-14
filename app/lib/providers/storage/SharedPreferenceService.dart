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
  /// If AppState is empty or there is an error, reads BasicAppState.
  /// If BasicAppState is empty or there is an error, returns [Optional.absent()]
  Future<Optional<AppState>> readAppState() async {
    var serializedAppState = this.sharedPreferences.get(appStateKey);

    if (serializedAppState != null) {
      try {
        return Optional.of(AppState.fromJson(serializedAppState));
      } catch (error, stack) {
        debugPrint(
            'Error occurred during serializing AppState: $error. Stack: $stack');
      }
    }

    var serializedBasicAppState = this.sharedPreferences.get(basicAppStateKey);

    if (serializedBasicAppState != null) {
      try {
        BasicAppState basicAppState =
            BasicAppState.fromJson(serializedBasicAppState);
        AppState appState = AppState().rebuild((b) => b
          ..settingState.replace(basicAppState.settingState)
          ..currentAuthenticatedUserBasicInfo
              .replace(basicAppState.currentAuthenticatedUserBasicInfo));

        return Optional.of(appState);
      } catch (error, stack) {
        debugPrint(
            'Error occurred during serializing BasicAppState: $error. Stack: $stack');
      }
    }

    return Optional.absent();
  }

  /// Saves [AppState] with key [appStateKey] and a basicAppState with key
  /// [basicAppStateKey], returns true if both operations return true.
  Future<bool> persistAppState(AppState state) async {
    assert(state != null);

    /// SubjectState currently cannot be serialized
    state = state.rebuild((b) => b..subjectState.replace(SubjectState()));

    BasicAppState basicAppState = BasicAppState((b) => b
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

  Future<bool> deleteAppState() {
    return this.sharedPreferences.remove(appStateKey);
  }
}
