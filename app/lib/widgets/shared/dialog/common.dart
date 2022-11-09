import 'package:flutter/material.dart';

class EditorYesNoPrompt {
  static const title = const Text('放弃编辑？');
  static const content = const Text('放弃后输入的信息将不会被保存');
  static const cancelAction = const Text('继续编辑');
  static const confirmAction = const Text('放弃编辑');
}

Future<bool> showMuninYesNoDialog(
  BuildContext context, {
      Widget title,
      Widget content,
      @required Widget cancelAction,
      @required Widget confirmAction,
}) async {
  assert(title != null || content != null,
  'Either title or dialog body must be presented.');

  bool confirmation = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      assert(title != null || content != null);
      return AlertDialog(
        title: title,
        content: content,
        actions: <Widget>[
          TextButton(
            child: cancelAction,
            onPressed: () {
              Navigator.of(context)
                  .pop(false); // Returning true to _onWillPop will pop again.
            },
          ),
          TextButton(
            child: confirmAction,
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
  Widget title,
  Widget content,
  Widget action = const Text('OK'),
}) async {
  assert(title != null || content != null,
  'Either title or dialog body must be presented.');
  bool confirmation = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title,
        content: content,
        actions: <Widget>[
          TextButton(
            child: action,
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
