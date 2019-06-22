import 'dart:async';

import 'package:flutter/material.dart';
import 'package:munin/widgets/shared/common/MuninPadding.dart';

class SubjectCollectionDeletionWaitingDialog extends StatefulWidget {
  const SubjectCollectionDeletionWaitingDialog({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SubjectCollectionDeletionWaitingDialogState();
  }
}

class _SubjectCollectionDeletionWaitingDialogState
    extends State<SubjectCollectionDeletionWaitingDialog> {
  /// During deletion, a modal, non-dismissible dialog will show up. This is needed
  /// because deletion is considered an important, un-reversible operation.
  /// Setting a timeout here allows user to switch the task to background if it
  /// does take too long for this operation.
  Duration maxDeletionWaitingTime = const Duration(seconds: 6);
  bool showSwitchDeletionTaskToBackgroundButton = false;
  Timer deletionWaitingTimer;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        MuninPadding(child: Text('正在删除此收藏...')),
        if (showSwitchDeletionTaskToBackgroundButton)
          MuninPadding.noVerticalOffset(
            denseHorizontal: true,
            child: OutlineButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('在后台继续执行删除'),
            ),
          )
      ],
    );
  }

  @override
  void dispose() {
    deletionWaitingTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    deletionWaitingTimer = Timer(maxDeletionWaitingTime, () {
      if (mounted) {
        setState(() {
          showSwitchDeletionTaskToBackgroundButton = true;
        });
      }
    });
  }
}
