import 'dart:async';

import 'package:flutter/material.dart';

/// a completer helper util to show snack bar with a error dialog if this completer fails
/// Note: even shouldPop is set to true, pop may not happen since `maybePop` is used
Completer<Null> snackBarCompleter(BuildContext context, String message,
    {bool shouldPop = false}) {
  final Completer<Null> completer = Completer<Null>();

  completer.future.then((_) {
    if (shouldPop) {
      Navigator.of(context).maybePop();
    }
    Scaffold.of(context).showSnackBar(SnackBar(
        content: SnackBar(
      content: Text(message),
    )));
  }).catchError((Object error) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return error;
        });
  });

  return completer;
}
