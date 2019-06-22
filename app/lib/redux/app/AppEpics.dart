import 'package:flutter/material.dart';
import 'package:munin/providers/storage/SharedPreferenceService.dart';
import 'package:munin/redux/app/AppActions.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/oauth/OauthActions.dart';
import 'package:munin/redux/shared/ExceptionHandler.dart';
import 'package:munin/shared/exceptions/utils.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

List<Epic<AppState>> createAppEpics(
    SharedPreferenceService sharedPreferenceService) {
  final persistStateEpic = _createPersistStateEpic(sharedPreferenceService);
  final handleErrorEpic = _createHandleErrorEpic();

  return [
    persistStateEpic,
    handleErrorEpic,
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

Stream<dynamic> _handleErrorEpic(EpicStore<AppState> store,
    HandleErrorAction action) async* {
  try {
    final error = action.error;
    final context = action.context;

    final result = await generalExceptionHandler(
      error,
      context: context,
    );
    if (result == GeneralExceptionHandlerResult.RequiresReAuthentication) {
      yield OAuthLoginRequest(context);
    } else if (result == GeneralExceptionHandlerResult.Skipped) {
      return;
    }


    if (action.showErrorMessageSnackBar) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(formatErrorMessage(error)),
      ));
    }
  } catch (error, stack) {
    debugPrint(
        'Error occured during persisting AppState: $error. Stack: $stack');
  }
}

Epic<AppState> _createHandleErrorEpic() {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<HandleErrorAction>())
        .concatMap(
            (action) => _handleErrorEpic(store, action));
  };
}
