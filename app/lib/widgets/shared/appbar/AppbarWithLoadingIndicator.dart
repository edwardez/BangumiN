import 'dart:async';

import 'package:flutter/material.dart';
import 'package:munin/redux/shared/RequestStatus.dart';

/// An widget that wraps a child and updates itself with a status indicator
/// text on bottom.
class WidgetWithLoadingIndicator extends StatefulWidget {
  /// The future that indicates loading status. Might be null.
  /// Null indicates that [bottomStatusIndicator] is not needed.
  final Future<void> requestStatusFuture;

  /// The actual widget that needs to be displayed
  final Widget child;

  /// The status indicator widget that's on the bottom of [child].
  final Widget bottomStatusIndicator;

  const WidgetWithLoadingIndicator({
    Key key,
    @required this.child,
    @required this.requestStatusFuture,
    this.bottomStatusIndicator = const Text(
      '加载中',
    ),
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WidgetWithLoadingIndicatorState();
  }
}

class _WidgetWithLoadingIndicatorState
    extends State<WidgetWithLoadingIndicator> {
  RequestStatus requestStatus = RequestStatus.Initial;

  Future<void> requestStatusFuture;

  StreamSubscription<void> requestStatusChangeSubscription;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        widget.child,
        if (requestStatus == RequestStatus.Loading)
          widget.bottomStatusIndicator,
      ],
    );
  }

  @override
  void didUpdateWidget(WidgetWithLoadingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.requestStatusFuture != widget.requestStatusFuture) {
      requestStatusFuture = widget.requestStatusFuture;
      updateRequestStatus();
    }
  }

  updateRequestStatus() {
    if (requestStatusFuture == null) {
      return;
    }

    setState(() {
      requestStatus = RequestStatus.Loading;
    });

    // Cancels any previous subscription to avoid racing condition.
    requestStatusChangeSubscription?.cancel();

    requestStatusChangeSubscription =
        requestStatusFuture.asStream().listen((_) {
      // In case future completes before widget is still being initialized.
      if (mounted) {
        setState(() {
          // Always sets to [RequestStatus.Success],
          // [WidgetWithLoadingIndicator] doesn't care the actual loading
          // state
          requestStatus = RequestStatus.Success;
        });
      }
    }, onError: (error) {
      if (mounted) {
        setState(() {
          // Always sets to [RequestStatus.Success],
          // [WidgetWithLoadingIndicator] doesn't care the actual loading
          // state
          requestStatus = RequestStatus.UnknownException;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    requestStatusFuture = widget.requestStatusFuture;
    updateRequestStatus();
  }
}
