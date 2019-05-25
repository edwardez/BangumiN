import 'package:flutter/material.dart';

Future<bool> showMuninConfirmDiscardEditDialog(
  BuildContext context, {
  String title = '放弃编辑？',
  String dialogBody = '放弃后输入的信息将不会被保存',
  String continueEditText = '继续编辑',
  String discardEditText = '放弃编辑',
}) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(
          dialogBody,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(continueEditText),
            onPressed: () {
              Navigator.of(context)
                  .pop(false); // Returning true to _onWillPop will pop again.
            },
          ),
          FlatButton(
            child: Text(discardEditText),
            onPressed: () {
              Navigator.of(context)
                  .pop(true); // Pops the confirmation dialog but not the page.
            },
          ),
        ],
      );
    },
  );
}
