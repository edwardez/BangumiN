import 'package:flutter/material.dart';

Future<bool> showMuninYesNoDialog(
  BuildContext context, {
  String title = '放弃编辑？',
  String dialogBody = '放弃后输入的信息将不会被保存',
  String cancelActionText = '继续编辑',
  String confirmActionText = '放弃编辑',
}) async {
  bool confirmation = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(
          dialogBody,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(cancelActionText),
            onPressed: () {
              Navigator.of(context)
                  .pop(false); // Returning true to _onWillPop will pop again.
            },
          ),
          FlatButton(
            child: Text(confirmActionText),
            onPressed: () {
              Navigator.of(context)
                  .pop(true); // Pops the confirmation dialog but not the page.
            },
          ),
        ],
      );
    },
  );

  return confirmation ?? false;
}

Future<bool> showMuninSingleActionDialog(BuildContext context, {
  String title,
  String dialogBody,
  String actionText = 'OK',
}) async {
  assert(title != null || dialogBody != null,
  'Either title or dialog body must be presented.');
  bool confirmation = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title == null ? null : Text(title),
        content: dialogBody == null
            ? null
            : Text(
          dialogBody,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(actionText),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );

  return confirmation ?? false;
}
