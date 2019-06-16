import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/redux/app/AppActions.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/oauth/OauthActions.dart';
import 'package:munin/redux/shared/ExceptionHandler.dart';
import 'package:munin/redux/shared/RequestStatus.dart';
import 'package:munin/shared/exceptions/utils.dart';
import 'package:munin/widgets/shared/common/ScaffoldWithRegularAppBar.dart';
import 'package:munin/widgets/shared/refresh/AdaptiveProgressIndicator.dart';
import 'package:redux/redux.dart';

/// A general-purpose widget to show a [CircularProgressIndicator] if the request
/// is in Progress, and a button/text to let user retries their requests
class RequestInProgressIndicatorWidget extends StatefulWidget {
  /// An action that can be used to retry current request.
  /// If [retryCallback] is set to null, retry button will be hidden.
  /// If [retryCallback] is called, [requestStatusFuture] will be updated to
  /// the return value of this.
  final Future<void> Function() retryCallback;

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
  final RequestStatus loadingStatus;

  /// If set to false, appbar inside this widget will be hide
  final bool showAppBar;

  final Future<void> requestStatusFuture;

  const RequestInProgressIndicatorWidget({
    Key key,
    this.loadingStatus,
    @required this.requestStatusFuture,
    this.refreshAction,
    this.showAppBar = true,
    this.requestInProgressMessage = '加载中',
    this.requestGeneralErrorMessage = '加载出错',
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

  _ViewModel viewModel;

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
          viewModel?.dispatchAction(OAuthLoginRequest(context));
        } else if (result == GeneralExceptionHandlerResult.Skipped) {
          return;
        }

        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(formatErrorMessage(error)),
        ));
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

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store store) =>
          _ViewModel.fromStore(
            store,
          ),
      distinct: true,
      builder: (BuildContext context, _ViewModel vm) {
        viewModel = vm;
        Widget body;
        AppBar appBar;

        if (requestStatus.isException) {
          List<Widget> errorWidgets = [];
          errorWidgets.add(Text(widget.requestGeneralErrorMessage));

          if (widget.retryCallback != null) {
            errorWidgets.add(RaisedButton(
              child: Text(widget.retryButtonMessage),
              onPressed: () {
                listenOnRequestFuture(widget.retryCallback());
              },
            ));
          }

          body = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: errorWidgets,
            ),
          );

          if (widget.showAppBar) {
            appBar = AppBar();
          }
        } else {
          body = Center(
            child: AdaptiveProgressIndicator(),
          );

          if (widget.showAppBar) {
            appBar = AppBar(
              title: Text(widget.requestInProgressMessage),
            );
          }
        }

        return ScaffoldWithRegularAppBar(
          appBar: appBar,
          safeAreaChild: body,
        );
      },
    );
  }
}

class _ViewModel {
  final Function(dynamic refreshAction) dispatchAction;
  final void Function(BuildContext context, Object error) handleError;

  factory _ViewModel.fromStore(Store<AppState> store) {
    _dispatchAction(dynamic action) {
      store.dispatch(action);
    }

    return _ViewModel(
      dispatchAction: _dispatchAction,
      handleError: (BuildContext context, Object error) {
        store.dispatch(HandleErrorAction(error: error, context: context));
      },
    );
  }

  _ViewModel({
    @required this.dispatchAction,
    @required this.handleError,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is _ViewModel && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
