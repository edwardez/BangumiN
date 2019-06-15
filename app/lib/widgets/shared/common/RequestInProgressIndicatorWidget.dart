import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';
import 'package:munin/widgets/shared/common/ScaffoldWithRegularAppBar.dart';
import 'package:munin/widgets/shared/refresh/AdaptiveProgressIndicator.dart';
import 'package:redux/redux.dart';

/// A general-purpose widget to show a [CircularProgressIndicator] if the request
/// is in Progress, and a button/text to let user retries their requests
class RequestInProgressIndicatorWidget extends StatelessWidget {
  /// An action that can be dispatched by the store
  /// Note: it's the caller's responsibility to ensure [refreshAction] is an action
  /// that can be dispatched by the store.
  /// If [refreshAction] is set to null, retry button will be hidden
  final dynamic refreshAction;

  /// A message to show if the request is in progress
  final String requestInProgressMessage;

  /// A message to show if request ends up with an error
  final String requestGeneralErrorMessage;

  /// Message on the retry button, the button will let user retry previous request
  /// If [refreshAction] is set to null, retry button won't be built hence messages
  /// of [retryButtonMessage] won't be shown
  final String retryButtonMessage;

  /// a [loadingStatus] that can be used to build widget accordingly
  final LoadingStatus loadingStatus;

  /// If set to false, appbar inside this widget will be hide
  final bool showAppBar;

  const RequestInProgressIndicatorWidget(
      {Key key,
      @required this.loadingStatus,
      this.refreshAction,
        this.showAppBar = true,
      this.requestInProgressMessage = '加载中',
      this.requestGeneralErrorMessage = '加载出错',
      this.retryButtonMessage = '重试'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store>(
      distinct: true,
      converter: (Store store) => store,
      builder: (BuildContext context, Store store) {
        if (loadingStatus?.isException ?? false) {
          List<Widget> errorWidgets = [];
          errorWidgets.add(Text(requestGeneralErrorMessage));

          if (refreshAction != null) {
            errorWidgets.add(RaisedButton(
              child: Text(retryButtonMessage),
              onPressed: () {
                store.dispatch(refreshAction);
              },
            ));
          }

          return ScaffoldWithRegularAppBar(
            appBar: showAppBar ? AppBar() : null,
            safeAreaChild: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: errorWidgets,
              ),
            ),
          );
        }

        return ScaffoldWithRegularAppBar(
          appBar: showAppBar
              ? AppBar(
            title: Text(requestInProgressMessage),
          )
              : null,
          safeAreaChild: Center(
            child: AdaptiveProgressIndicator(),
          ),
        );
      },
    );
  }
}
