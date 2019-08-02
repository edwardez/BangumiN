import 'package:flutter/widgets.dart';

void scrollPrimaryScrollControllerToTop(BuildContext context) {
  if (PrimaryScrollController.of(context) != null &&
      PrimaryScrollController.of(context).hasClients) {
    /// eyeballed values from `_handleStatusBarTap` in `scaffold.dart`
    PrimaryScrollController.of(context).animateTo(0.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linearToEaseOut);
  }
}
