import 'package:flutter/cupertino.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/app/BasicAppState.dart';

class PersistAppStateAction {
  /// Whether only [BasicAppState] should be persisted
  final bool basicAppStateOnly;

  /// An optional pass-ed in [AppState]. If not set, current [AppState] in
  /// [Store] will be used.
  final AppState appState;

  PersistAppStateAction({
    this.basicAppStateOnly = false,
    this.appState,
  });
}

class HandleErrorAction {
  final BuildContext context;
  final Object error;
  final StackTrace stack;

  final bool showErrorMessageSnackBar;

  HandleErrorAction({
    @required this.context,
    @required this.error,
    this.stack,
    this.showErrorMessageSnackBar = true,
  });
}
