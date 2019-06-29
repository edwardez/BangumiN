import 'package:flutter/material.dart';

/// Shows a snackbar on success of [future].
void showSnackBarOnSuccess(
  BuildContext context,
  Future<dynamic> future,
  String successText,
) async {
  final hasSucceeded = await future;
  if (hasSucceeded == true) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(successText),
    ));
  }
}
