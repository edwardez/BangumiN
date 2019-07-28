import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/providers/storage/SharedPreferenceService.dart';
import 'package:munin/redux/app/AppActions.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/shared/ExceptionHandler.dart';
import 'package:munin/router/routes.dart';
import 'package:munin/shared/exceptions/exceptions.dart';
import 'package:munin/shared/exceptions/utils.dart';
import 'package:munin/widgets/shared/common/SnackBar.dart';
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

Stream<dynamic> _persistState(EpicStore<AppState> store,
    SharedPreferenceService sharedPreferenceService,
    PersistAppStateAction action) async* {
  try {
    if (action.basicAppStateOnly) {
      /// New theme must be either light or dark theme
      assert(store.state.settingState.themeSetting.currentTheme.isLightTheme ||
          store.state.settingState.themeSetting.currentTheme.isDarkTheme);
      await sharedPreferenceService
          .persistBasicAppState(action.appState ?? store.state);
    } else {
      await sharedPreferenceService
          .persistAppState(action.appState ?? store.state);
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
    bool inDev = Application.environmentValue.environmentType ==
        EnvironmentType.Development;
    var error = action.error;
    // Error might be swollen by isolate, the only exception that we really care
    // and shouldn't be swollen is AuthenticationExpiredException, which will
    // be thrown by timeline parser, hence re-convert it here.
    if (error.toString().contains('AuthenticationExpiredException') &&
        error is! AuthenticationExpiredException) {
      reportError(error, stack: action.stack, context: DiagnosticsNode.message(
          'Error that might have been swollen by isolate.'));
      error = AuthenticationExpiredException('认证已过期');
    }
    final context = action.context;

    reportError(error, stack: action.stack);

    final result = await generalExceptionHandler(
      error,
      context: context,
    );
    if (result == GeneralExceptionHandlerResult.RequiresReAuthentication) {
      Application.router.navigateTo(
        action.context,
        Routes.loginRoute,
        transition: TransitionType.native,
      );
    } else if (result == GeneralExceptionHandlerResult.Skipped) {
      return;
    }

    if (action.showErrorMessageSnackBar) {
      showTextOnSnackBar(context, formatErrorMessage(error));
    }
  } catch (error, stack) {
    reportError(error, stack: stack);
  }
}

Epic<AppState> _createHandleErrorEpic() {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<HandleErrorAction>())
        .concatMap((action) => _handleErrorEpic(store, action));
  };
}
