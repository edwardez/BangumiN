import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/redux/shared/ExceptionHandler.dart';
import 'package:munin/redux/shared/RequestStatus.dart';
import 'package:munin/redux/shared/utils.dart';
import 'package:munin/router/routes.dart';
import 'package:munin/shared/exceptions/utils.dart';
import 'package:munin/widgets/shared/common/ScaffoldWithRegularAppBar.dart';
import 'package:munin/widgets/shared/common/SnackBar.dart';
import 'package:munin/widgets/shared/refresh/AdaptiveProgressIndicator.dart';

/// A general-purpose widget to show a [CircularProgressIndicator] if the request
/// is in Progress, and a button/text to let user retries their requests
class RequestInProgressIndicatorWidget extends StatefulWidget {
  /// An action that can be used to retry current request.
  /// If [retryCallback] is set to null, retry button will be hidden.
  /// If [retryCallback] is called, [requestStatusFuture] will be updated to
  /// the return value of this.
  final Future<void> Function(BuildContext context) retryCallback;

  final dynamic refreshAction;

  /// A message to show if the request is in progress
  final String requestInProgressMessageOnAppBar;

  /// A message to show if request ends up with an error
  final String requestGeneralErrorMessageOnSnackBar;

  /// Message on the retry button, the button will let user retry previous request
  /// If [refreshAction] is set to null, retry button won't be built hence messages
  /// of [retryButtonMessage] won't be shown
  final String retryButtonMessage;

  /// a [loadingStatus] that can be used to build widget accordingly
  final RequestStatus loadingStatus;

  /// When set to true, only body request indicator and retry widgets will be
  /// shown, [RequestInProgressIndicatorWidget] won't be wrapped in a [Scaffold].
  /// Might be useful if [RequestInProgressIndicatorWidget] needs to be placed
  /// inside a [Scaffold].
  ///
  /// Default to false.
  final bool showOnlyRequestIndicatorBody;

  final Future<void> requestStatusFuture;

  const RequestInProgressIndicatorWidget({
    Key key,
    this.loadingStatus,
    @required this.requestStatusFuture,
    this.refreshAction,
    this.showOnlyRequestIndicatorBody = false,
    this.requestInProgressMessageOnAppBar = '加载中',
    this.requestGeneralErrorMessageOnSnackBar = '加载出错',
    this.retryButtonMessage = '重试',
    this.retryCallback,
  }) : super(key: key);

  @override
  _RequestInProgressIndicatorWidgetState createState() =>
      _RequestInProgressIndicatorWidgetState();
}

class _RequestInProgressIndicatorWidgetState
    extends State<RequestInProgressIndicatorWidget> {
  RequestStatus requestStatus = RequestStatus.Initial;

  StreamSubscription<void> requestStatusChangeSubscription;

  @override
  void initState() {
    super.initState();
    requestStatus = RequestStatus.Loading;

    listenOnRequestFuture(widget.requestStatusFuture);
  }

  @override
  void dispose() {
    super.dispose();
    requestStatusChangeSubscription?.cancel();
  }

  listenOnRequestFuture(Future requestStatusFuture) {
    assert(requestStatusFuture != null);
    if (requestStatusFuture == null) {
      return;
    }

    if (mounted && requestStatus != RequestStatus.Loading) {
      rebuildWithRequestStatus(RequestStatus.Loading);
    }

    // Cancels any previous subscription to avoid racing condition.
    requestStatusChangeSubscription?.cancel();

    requestStatusChangeSubscription = requestStatusFuture.asStream().listen(
      (_) {
        rebuildWithRequestStatus(RequestStatus.Success);
      },
      onError: (error) async {
        rebuildWithRequestStatus(RequestStatus.UnknownException);

        final result = await generalExceptionHandler(
          error,
          context: context,
        );
        if (result == GeneralExceptionHandlerResult.RequiresReAuthentication) {
          Application.router.navigateTo(
            context,
            Routes.loginRoute,
            transition: TransitionType.native,
          );
        } else if (result == GeneralExceptionHandlerResult.Skipped) {
          return;
        }
        showTextOnSnackBar(context, formatErrorMessage(error));
      },
    );
  }

  /// Rebuilds [requestStatus] with a checker for current [requestStatus] and
  /// whether the widget is mounted. Since typically this widget needs to rebuild
  /// with new [requestStatus] inside a async closure, it's necessary to check
  /// whether widget has been mounted.
  rebuildWithRequestStatus(RequestStatus newStatus) {
    if (mounted && requestStatus != newStatus) {
      setState(() {
        requestStatus = newStatus;
      });
    }
  }

  _dispatchAction(dynamic action) {
    findStore(context).dispatch(action);
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    AppBar appBar;

    if (requestStatus.isException) {
      List<Widget> errorWidgets = [];
      errorWidgets.add(Text(widget.requestGeneralErrorMessageOnSnackBar));

      if (widget.retryCallback != null) {
        errorWidgets.add(RaisedButton(
          child: Text(widget.retryButtonMessage),
          onPressed: () {
            listenOnRequestFuture(widget.retryCallback(context));
          },
        ));
      }

      body = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: errorWidgets,
        ),
      );

      appBar = AppBar();
    } else {
      body = Center(
        child: AdaptiveProgressIndicator(),
      );

      appBar = AppBar(
        title: Text(widget.requestInProgressMessageOnAppBar),
      );
    }

    if (widget.showOnlyRequestIndicatorBody) {
      return body;
    }

    return ScaffoldWithRegularAppBar(
      appBar: appBar,
      safeAreaChild: body,
    );
  }
}
