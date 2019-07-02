import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/common/GetTimelineRequest.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/timeline/TimelineActions.dart';
import 'package:munin/shared/exceptions/utils.dart';
import 'package:munin/widgets/shared/common/SnackBar.dart';
import 'package:redux/redux.dart';

/// A commonly used helper that deletes a feed.
void deleteFeedHelper(
  Store<AppState> store,
  BuildContext context,
  GetTimelineRequest getTimelineRequest,
  TimelineFeed feed, {
  popContextOnSuccess = false,
}) async {
  final action =
      DeleteTimelineAction(feed: feed, getTimelineRequest: getTimelineRequest);
  store.dispatch(action);

  try {
    await action.completer.future;
    showTextOnSnackBar(context, '时间线删除成功');
    if (popContextOnSuccess) {
      Navigator.pop(context);
    }
  } catch (error) {
    showTextOnSnackBar(context, '时间线删除失败: ${formatErrorMessage(error)}');
  }
}
