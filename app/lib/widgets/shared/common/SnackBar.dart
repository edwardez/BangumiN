import 'package:flutter/material.dart';
import 'package:quiver/time.dart';

const Duration shortSnackBarDisplayDuration = aSecond;
const Duration snackBarDisplayDuration = Duration(milliseconds: 4000);

/// Shows a snackbar on success of [future].
void showSnackBarOnSuccess(
  BuildContext context,
  Future<dynamic> future,
  String successText,
) async {
  final hasSucceeded = await future;
  if (hasSucceeded == true) {
    showTextOnSnackBar(context, successText);
  }
}

/// Show text on snackbar, if [shortDuration] is set to true, value in [duration]
/// will be ignored and [shortSnackBarDisplayDuration] will always be used.
void showTextOnSnackBar(BuildContext context, String text,
    {duration = snackBarDisplayDuration, shortDuration = false,}) async {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    duration: shortDuration ? shortSnackBarDisplayDuration : duration,
    behavior: SnackBarBehavior.floating,
  ));
}
