import 'package:flutter/material.dart';
import 'package:munin/providers/storage/SharedPreferenceService.dart';
import 'package:munin/redux/app/AppActions.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

List<Epic<AppState>> createAppEpics(
    SharedPreferenceService sharedPreferenceService) {
  final persistStateEpic = _createPersistStateEpic(sharedPreferenceService);

  return [
    persistStateEpic,
  ];
}

Stream<dynamic> _persistState(
    EpicStore<AppState> store,
    SharedPreferenceService sharedPreferenceService,
    PersistAppStateAction action) async* {
  try {
    if (action.basicAppStateOnly) {
      await sharedPreferenceService.persistBasicAppState(store.state);
    } else {
      await sharedPreferenceService.persistAppState(store.state);
    }

  } catch (error, stack) {
    debugPrint(
        'Error occured during persisting AppState: $error. Stack: $stack');
  }
}

Epic<AppState> _createPersistStateEpic(
    SharedPreferenceService sharedPreferenceService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<PersistAppStateAction>())
        .concatMap(
            (action) => _persistState(store, sharedPreferenceService, action));
  };
}
