import 'package:flutter/cupertino.dart';
import 'package:munin/redux/app/BasicAppState.dart';

class PersistAppStateAction {
  /// Whether only [BasicAppState] should be persisted
  final bool basicAppStateOnly;

  PersistAppStateAction({this.basicAppStateOnly = false});
}

class HandleErrorAction {
  final BuildContext context;
  final Object error;

  final bool showErrorMessageSnackBar;

  HandleErrorAction({
    @required this.context,
    @required this.error,
    this.showErrorMessageSnackBar = true,
  });
}
