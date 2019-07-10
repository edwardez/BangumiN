import 'package:flutter/material.dart';
import 'package:munin/shared/utils/misc/constants.dart';

/// Shows a snackbar on success of [future].
void showSnackBarOnSuccess(
  BuildContext context,
  Future<dynamic> future,
  String successText,
) async {
  final hasSucceeded = await future;
  if (hasSucceeded == true) {
    showTextOnSnackBar(
        context, successText);
  }
}

void showTextOnSnackBar(BuildContext context,
    String text,
    {
      Duration duration = snackBarDisplayDuration
    }) async {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(text),
    duration: duration,
    behavior: SnackBarBehavior.floating,
  ));
}
