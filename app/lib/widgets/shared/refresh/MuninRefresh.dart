import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/redux/shared/RequestStatus.dart';
import 'package:munin/shared/exceptions/utils.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:munin/shared/utils/misc/async.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/common/Divider.dart';
import 'package:munin/widgets/shared/common/SnackBar.dart';
import 'package:munin/widgets/shared/refresh/AdaptiveProgressIndicator.dart';
import 'package:munin/widgets/shared/refresh/workaround/refresh_indicator.dart';

/// The signature for a function that's called when a refresh should be performed
/// The returned [Future] must complete when the refresh operation is
/// finished.
typedef RefreshCallback = Future<void> Function();

/// If it's [RefreshWidgetStyle.Material], [MuninRefreshIndicator] will always be used
/// If it's [RefreshWidgetStyle.Cupertino], [CupertinoSliverRefreshControl] will always be used
/// If it's [RefreshWidgetStyle.Adaptive], [MuninRefresh] will try to match platform standard
/// By default, [MuninRefreshIndicator] will be used
enum RefreshWidgetStyle {
  Material,
  Cupertino,
  Adaptive,

  /// currently not in use
  Fuchsia,
}

/// A refresh widget that supports infinite scroll and pull to refresh
/// For pull to refresh: on iOS [CupertinoSliverRefreshControl] is used
/// on Android [MuninRefreshIndicator] is used
/// Note: [CupertinoSliverRefreshControl] works differently from [MuninRefreshIndicator]
/// instead of being an overlay on top of the scrollable, the
/// [CupertinoSliverRefreshControl] is part of the scrollable and actively occupies
///  scrollable space.
/// For more details, please see api doc for these widgets
class MuninRefresh extends StatefulWidget {
  static Widget _defaultDividerBuilder(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPortraitHorizontalOffset),
      child: onePixelHeightDivider(),
    );
  }

  /// Called to build a individual child in a list.
  /// Will be called only for indices greater than or equal to zero and less
  /// than [childCount] (if [childCount] is non-null).
  /// Should return null if asked to build a widget with a greater index than
  /// exists.
  final IndexedWidgetBuilder itemBuilder;

  /// A separator that will be built between each items, default to a [Divider]
  /// with 1 pixel height and `defaultPortraitHorizontalPadding` padding on each
  /// horizontal side.
  /// If [separatorBuilder] is set to null, no separator will be built between child items.
  final IndexedWidgetBuilder separatorBuilder;

  /// A function that's called when the user has dragged the refresh indicator
  /// far enough to demonstrate that they want the app to refresh. The returned
  /// [Future] must complete when the refresh operation is finished.
  final RefreshCallback onRefresh;

  /// A function that's called when more content should be loaded. i.e. load older
  /// tweet on twitter, load more search results on search page
  final RefreshCallback onLoadMore;

  /// Style of the refresh widget.
  final RefreshWidgetStyle refreshWidgetStyle;

  /// Total number of items that will be rendered by [itemBuilder]
  /// This doesn't include the loading status indicator widget which will be provided
  /// by [MuninRefresh]
  /// Considering the use case of this widget, [itemCount] cannot be null
  final int itemCount;

  /// If [noMoreItemsToLoad] is set to true and [noMoreItemsWidget] is not null,
  /// [noMoreItemsWidget] will be placed at the end of the scrollable body
  final Widget noMoreItemsWidget;

  /// Whether there are no more items to load
  final bool noMoreItemsToLoad;

  /// If initially list is empty, and it's still empty after refresh, this widget
  /// will be shown
  /// Set it to null will hide this widget.
  final Widget emptyAfterRefreshWidget;

  /// An optional AppBar that will be placed at the top of widget list
  final Widget appBar;

  /// An optional list of widgets that will be put at the top of item lists,
  /// but below [appBar].
  final List<Widget> topWidgets;

  /// Displacement value for [RefreshWidgetStyle.Material]
  /// see [displacement] in [MuninRefreshIndicator]
  final double materialRefreshIndicatorDisplacement;

  /// refreshTriggerPullDistance for [RefreshWidgetStyle.Cupertino]
  /// see [refreshTriggerPullDistance] in [CupertinoSliverRefreshControl]
  final double cupertinoRefreshTriggerPullDistance;

  /// MuninRefreshIndicatorExtent for [RefreshWidgetStyle.Cupertino]
  /// see [MuninRefreshIndicatorExtent] in [CupertinoSliverRefreshControl]
  final double cupertinoRefreshIndicatorExtent;

  /// Padding between appBar and underneath items
  /// Won't take effect if appBar is not set
  final EdgeInsetsGeometry appBarUnderneathPadding;

  /// If current scroll position is [loadMoreTriggerDistance] or less away from
  /// bottom, [onLoadMore] will be triggered
  final double loadMoreTriggerDistance;

  /// Whether a snackbar should be shown on error.
  final bool showSnackbarOnError;

  const MuninRefresh({
    Key key,
    @required this.onRefresh,
    @required this.onLoadMore,
    @required this.itemBuilder,
    @required this.itemCount,
    this.appBar,
    this.topWidgets = const [],
    this.emptyAfterRefreshWidget,
    this.noMoreItemsWidget,
    this.noMoreItemsToLoad = false,
    this.refreshWidgetStyle = RefreshWidgetStyle.Adaptive,
    this.separatorBuilder = _defaultDividerBuilder,
    this.appBarUnderneathPadding = const EdgeInsets.only(bottom: largeOffset),
    this.materialRefreshIndicatorDisplacement = 80,
    this.cupertinoRefreshTriggerPullDistance = 70,
    this.cupertinoRefreshIndicatorExtent = 50,
    this.loadMoreTriggerDistance = 200,
    this.showSnackbarOnError = false,
  })  : assert(itemCount != null),
        assert(itemBuilder != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MuninRefreshState();
  }
}

class MuninRefreshState extends State<MuninRefresh> {
  static const loadMoreStatusIndicatorPadding = 15.0;
  static const sliverGeneralExtent = 72.0;

  static const retryableLoadErrorText = '加载出错，点击重试';
  static const loadMoreText = '继续加载';

  /// [RequestStatus] of the top `pull to refresh`
  RequestStatus refreshLoadingStatus;

  /// [RequestStatus] of the bottom `load more`
  RequestStatus loadMoreStatus;
  double currentMaxScrollExtent;

  RefreshWidgetStyle computedRefreshWidgetStyle;

  GlobalKey<MuninRefreshIndicatorState> _materialRefreshKey =
      GlobalKey<MuninRefreshIndicatorState>();

  /// A subscription to load more status change. It can be used to unsubscribe
  /// previous load more status change.
  StreamSubscription<void> loadMoreStatusChangeSubscription;

  @override
  void initState() {
    super.initState();
    computedRefreshWidgetStyle =
        _getPlatformRefreshWidgetStyle(widget.refreshWidgetStyle);
    refreshLoadingStatus = RequestStatus.Success;
    loadMoreStatus = RequestStatus.Success;
  }

  @override
  void dispose() {
    loadMoreStatusChangeSubscription?.cancel();
    super.dispose();
  }

  static int _computeChildCount(bool hasSeparator, int itemCount) {
    if (hasSeparator) {
      return math.max(0, itemCount * 2 - 1);
    }

    return itemCount;
  }

  /// Programmatically trigger a call to the refresh widget
  /// Currently no refresh widget will be shown if the refresh widget is a
  /// [CupertinoSliverRefreshControl], however `widget.onRefresh()` will still
  /// be called
  Future<void> callOnRefresh() {
    if (refreshLoadingStatus == RequestStatus.Loading ||
        widget.onRefresh == null) {
      return immediateFinishCompleter().future;
    }

    setState(() {
      refreshLoadingStatus = RequestStatus.Loading;
    });

    Future<void> completer;

    if (computedRefreshWidgetStyle == RefreshWidgetStyle.Cupertino) {
      /// TODO: Waiting for https://github.com/flutter/flutter/issues/31376 to be fixed
      /// then refresh method inside [CupertinoSliverRefreshControl] should be called
      /// instead(like how [_materialRefreshKey] is used below)
      /// code in [NotificationsWidget] also needs to be cleaned up.
      completer = widget.onRefresh();
    } else {
      completer = _materialRefreshKey?.currentState?.show();
    }

    completer.then((v) {
      if (mounted) {
        setState(() {
          refreshLoadingStatus = RequestStatus.Success;
        });
      }
    }, onError: (error, stack) {
      if (mounted) {
        setState(() {
          refreshLoadingStatus = RequestStatus.UnknownException;
        });
        if (widget.showSnackbarOnError) {
          showTextOnSnackBar(context, formatErrorMessage(error));
        }
      }
    });

    return completer;
  }

  /// Different from [callOnRefresh] which might be called externally,
  /// this method is called internally and passed to refresh widget
  RefreshCallback _generateOnRefreshCallBack() {
    return () {
      refreshLoadingStatus = RequestStatus.Loading;
      Future<void> completer;
      completer = widget.onRefresh();

      completer.then((v) {
        if (mounted) {
          setState(() {
            refreshLoadingStatus = RequestStatus.Success;
          });
        }
      }, onError: (error, stack) {
        if (mounted) {
          setState(() {
            refreshLoadingStatus = RequestStatus.UnknownException;
          });
          if (widget.showSnackbarOnError) {
            showTextOnSnackBar(context, formatErrorMessage(error));
          }
        }
      });

      return completer;
    };
  }

  Future<void> callOnLoadMore() {
    loadMoreStatusChangeSubscription?.cancel();

    setState(() {
      loadMoreStatus = RequestStatus.Loading;
    });

    Future<void> future = widget.onLoadMore();

    loadMoreStatusChangeSubscription = future.asStream().listen(
      (_) {
        if (mounted) {
          setState(() {
            loadMoreStatus = RequestStatus.Success;
          });
        }
      },
      onError: (error) {
        if (mounted) {
          setState(() {
            loadMoreStatus = RequestStatus.UnknownException;
          });
          if (widget.showSnackbarOnError) {
            showTextOnSnackBar(context, formatErrorMessage(error));
          }
        }
      },
    );

    return future;
  }

  /// Translates passed in [refreshWidgetStyle] to either [RefreshWidgetStyle.Cupertino]
  /// or [RefreshWidgetStyle.Material]
  /// If passed-in [refreshWidgetStyle] is already one of them, value will be returned as-is
  static RefreshWidgetStyle _getPlatformRefreshWidgetStyle(
      RefreshWidgetStyle refreshWidgetStyle) {
    if (refreshWidgetStyle == RefreshWidgetStyle.Material ||
        refreshWidgetStyle == RefreshWidgetStyle.Cupertino) {
      return refreshWidgetStyle;
    }

    if (isCupertinoPlatform()) {
      return RefreshWidgetStyle.Cupertino;
    }

    return RefreshWidgetStyle.Material;
  }

  _buildLoadMoreStatusIndicatorWidget() {
    Widget coreWidget;
    if (loadMoreStatus == RequestStatus.Initial) {
      coreWidget = Container();
    } else if (loadMoreStatus == RequestStatus.Loading) {
      coreWidget = AdaptiveProgressIndicator();
    } else if (loadMoreStatus == RequestStatus.Success) {
      if (widget.noMoreItemsToLoad) {
        assert(widget.noMoreItemsWidget != null,
            'noMoreItemWidget must not be null if noMoreItems is set to true');
        if (widget.noMoreItemsWidget != null) {
          coreWidget = widget.noMoreItemsWidget;
        } else {
          ExcludeSemantics(child: coreWidget = Container());
        }
      } else {
        /// Show a load more button to let user load more contents
        coreWidget = TextButton(
          child: Text(loadMoreText),
          onPressed: () {
            callOnLoadMore();
          },
        );
      }
    } else if (loadMoreStatus.isException) {
      coreWidget = TextButton(
        child: Text(retryableLoadErrorText),
        onPressed: () {
          callOnLoadMore();
        },
      );
    } else {
      coreWidget = Container();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: loadMoreStatusIndicatorPadding,
      ),
      child: Center(
        child: coreWidget,
      ),
    );
  }

  IndexedWidgetBuilder _sliverListChildBuilder(
      IndexedWidgetBuilder itemBuilder, IndexedWidgetBuilder separatorBuilder) {
    if (separatorBuilder == null) {
      return itemBuilder;
    }

    return (BuildContext context, int index) {
      final int itemIndex = index ~/ 2;

      if (index.isEven) {
        return itemBuilder(context, itemIndex);
      } else {
        return separatorBuilder(context, index);
      }
    };
  }

  SliverList _buildItemsSliverList() {
    final bool hasSeparator = widget.separatorBuilder != null;
    SliverList itemsSliverList = SliverList(
        delegate: SliverChildBuilderDelegate(
            _sliverListChildBuilder(
                widget.itemBuilder, widget.separatorBuilder),
            childCount: _computeChildCount(hasSeparator, widget.itemCount),
            semanticIndexCallback: (Widget _, int index) {
      if (hasSeparator) {
        return index.isEven ? index ~/ 2 : null;
      }
      return index;
    }));

    return itemsSliverList;
  }

  /// If 1. item count is 0
  /// 2. [noMoreItemsToLoad] is true or there is a currently an exception
  /// 3. [widget.emptyAfterRefreshWidget] is not null
  /// then emptyAfterRefreshWidget should be attached
  bool shouldAttachEmptyAfterRefreshWidget() {
    return widget.itemCount == 0 &&
        (widget.noMoreItemsToLoad || refreshLoadingStatus.isException) &&
        widget.emptyAfterRefreshWidget != null;
  }

  /// HACKHACK: block Cupertino Refresh since we are manually trigger refresh
  /// under this condition
  bool showPlaceholderCupertinoRefreshIndicator() {
    return refreshLoadingStatus == RequestStatus.Loading &&
        widget.itemCount == 0 &&
        computedRefreshWidgetStyle == RefreshWidgetStyle.Cupertino;
  }

  /// Builds a plain [CustomScrollView] that just contains an AppBar(if present)
  /// and items.
  ///
  /// [includeCupertinoRefreshWidget] and [includeCupertinoRefreshWidget] are
  /// set to `false` by default.
  CustomScrollView _buildItemsScrollBody({
    bool includeCupertinoRefreshWidget = false,
    bool includeLoadMoreStatusWidget = false,
  }) {
    List<Widget> slivers = [];

    if (widget.appBar != null) {
      slivers.add(widget.appBar);
    }

    if (includeCupertinoRefreshWidget) {
      // TODO: Waiting for https://github.com/flutter/flutter/issues/31376 to be fixed
      // then this code bock can be removed
      // Workaround to show a refresh indicator if [computedRefreshWidgetStyle] is
      // [RefreshWidgetStyle.Cupertino]
      if (showPlaceholderCupertinoRefreshIndicator()) {
        SliverFixedExtentList progressIndicator = SliverFixedExtentList(
          itemExtent: sliverGeneralExtent,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return AdaptiveProgressIndicator();
            },
            childCount: 1,
          ),
        );

        slivers.add(progressIndicator);
      } else {
        slivers.add(CupertinoSliverRefreshControl(
          onRefresh: _generateOnRefreshCallBack(),
          refreshIndicatorExtent: widget.cupertinoRefreshIndicatorExtent,
          refreshTriggerPullDistance:
          widget.cupertinoRefreshTriggerPullDistance,
        ));
      }
    }

    if (widget.appBarUnderneathPadding != null) {
      slivers.add(SliverPadding(
        padding: widget.appBarUnderneathPadding,
      ));
    }

    if (widget.topWidgets.isNotEmpty) {
      slivers.add(SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return widget.topWidgets[index];
          },
          childCount: widget.topWidgets.length,
        ),
      ));
    }

    if (shouldAttachEmptyAfterRefreshWidget()) {
      SliverList emptyAfterRefreshWidget = SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Center(child: widget.emptyAfterRefreshWidget);
          },
          childCount: 1,
        ),
      );
      slivers.add(emptyAfterRefreshWidget);
    }

    slivers.add(_buildItemsSliverList());

    // Attaches load more widget if
    // 1. List is non empty, and there is an [widget.onRefresh] callback
    // 2. There is no [widget.onRefresh] callback.
    if (includeLoadMoreStatusWidget && widget.itemCount >= 0) {
      bool hasOnRefreshCallbackAndNonEmptyItems =
          widget.onRefresh != null && widget.itemCount > 0;

      bool noOnRefreshCallback = widget.onRefresh == null;

      if (hasOnRefreshCallbackAndNonEmptyItems || noOnRefreshCallback) {
        SliverFixedExtentList loadMoreStatusWidget = SliverFixedExtentList(
          itemExtent: sliverGeneralExtent,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return _buildLoadMoreStatusIndicatorWidget();
            },
            childCount: 1,
          ),
        );

        slivers.add(loadMoreStatusWidget);
      }
    }

    return CustomScrollView(
      semanticChildCount: widget.itemCount,
      slivers: slivers,
    );
  }

  /// See comments for [RefreshWidgetStyle] for how the refresh widget is chosen
  /// [computedRefreshWidgetStyle] won't work if [includeRefreshWidget] is set to `false`
  /// [includeRefreshWidget] is set to `true` by default
  Widget _buildScrollBodyWithAdaptiveRefreshWidget({
    includeLoadMoreStatusWidget = true,
  }) {
    if (computedRefreshWidgetStyle == RefreshWidgetStyle.Cupertino) {
      return _buildItemsScrollBody(
          includeCupertinoRefreshWidget: true,
          includeLoadMoreStatusWidget: includeLoadMoreStatusWidget);
    } else {
      return MuninRefreshIndicator(
        key: _materialRefreshKey,
        displacement: widget.materialRefreshIndicatorDisplacement,
        child: _buildItemsScrollBody(
            includeLoadMoreStatusWidget: includeLoadMoreStatusWidget),
        onRefresh: _generateOnRefreshCallBack(),
      );
    }
  }

  bool _onScrollNotification(ScrollNotification notification) {
    /// TODO: improve load more detection logic
    if (notification.metrics.maxScrollExtent - notification.metrics.pixels <
            widget.loadMoreTriggerDistance &&
        notification.metrics.maxScrollExtent - notification.metrics.pixels >
            0 &&
        loadMoreStatus.canInitializeNextRequest &&
        notification.metrics.maxScrollExtent != 0.0 &&
        currentMaxScrollExtent != notification.metrics.maxScrollExtent) {
      currentMaxScrollExtent = notification.metrics.maxScrollExtent;

      callOnLoadMore();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onRefresh == null && widget.onLoadMore == null) {
      return _buildItemsScrollBody();
    }

    if (widget.onRefresh != null && widget.onLoadMore == null) {
      return _buildScrollBodyWithAdaptiveRefreshWidget(
        includeLoadMoreStatusWidget: false,
      );
    }

    if (widget.onRefresh == null && widget.onLoadMore != null) {
      return NotificationListener<ScrollNotification>(
        onNotification: _onScrollNotification,
        child: _buildItemsScrollBody(
          includeLoadMoreStatusWidget: true,
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: _onScrollNotification,
      child: _buildScrollBodyWithAdaptiveRefreshWidget(
        includeLoadMoreStatusWidget: true,
      ),
    );
  }
}
