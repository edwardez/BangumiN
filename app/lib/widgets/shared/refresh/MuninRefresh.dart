import 'dart:async';
import 'dart:io' show Platform;
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';
import 'package:munin/shared/utils/misc/async.dart';
import 'package:munin/shared/workarounds/refresh_indicator/refresh_indicator.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/refresh/AdaptiveProgressIndicator.dart';
import 'package:munin/widgets/shared/refresh/workaround/refresh.dart';

/// The signature for a function that's called when a refresh should be performed
/// The returned [Future] must complete when the refresh operation is
/// finished.
typedef RefreshCallback = Future<void> Function();

/// If it's [RefreshWidgetStyle.Material], [RefreshIndicator] will always be used
/// If it's [RefreshWidgetStyle.Cupertino], [CupertinoSliverRefreshControl] will always be used
/// If it's [RefreshWidgetStyle.Adaptive], [MuninRefresh] will try to match platform standard
/// By default, [RefreshIndicator] will be used
enum RefreshWidgetStyle {
  Material,
  Cupertino,
  Adaptive,

  /// currently not in use
  Fuchsia,
}

/// A refresh widget that supports infinite scroll and pull to refresh
/// For pull to refresh: on iOS [CupertinoSliverRefreshControl] is used
/// on Android [RefreshIndicator] is used
/// Note: [CupertinoSliverRefreshControl] works differently from [RefreshIndicator]
/// instead of being an overlay on top of the scrollable, the
/// [CupertinoSliverRefreshControl] is part of the scrollable and actively occupies
///  scrollable space.
/// For more details, please see api doc for these widgets
class MuninRefresh extends StatefulWidget {
  static Widget _defaultDividerBuilder(BuildContext context, int index) {
    return Divider();
  }

  /// Called to build a individual child in a list.
  /// Will be called only for indices greater than or equal to zero and less
  /// than [childCount] (if [childCount] is non-null).
  /// Should return null if asked to build a widget with a greater index than
  /// exists.
  final IndexedWidgetBuilder itemBuilder;

  /// A separator that will be built between each items, default to `Divider()`.
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

  /// Displacement value for [RefreshWidgetStyle.Material]
  /// see [displacement] in [RefreshIndicator]
  final double materialRefreshIndicatorDisplacement;

  /// refreshTriggerPullDistance for [RefreshWidgetStyle.Cupertino]
  /// see [refreshTriggerPullDistance] in [CupertinoSliverRefreshControl]
  final double cupertinoRefreshTriggerPullDistance;

  /// refreshIndicatorExtent for [RefreshWidgetStyle.Cupertino]
  /// see [refreshIndicatorExtent] in [CupertinoSliverRefreshControl]
  final double cupertinoRefreshIndicatorExtent;

  /// Outer padding for all items, appBar is not included
  final EdgeInsetsGeometry itemPadding;

  /// Padding between appBar and underneath items
  /// Won't take effect if appBar is not set
  final EdgeInsetsGeometry appBarUnderneathPadding;

  /// If current scroll position is [loadMoreTriggerDistance] or less away from
  /// bottom, [onLoadMore] will be triggered
  final double loadMoreTriggerDistance;

  const MuninRefresh({
    Key key,
    @required this.onRefresh,
    @required this.onLoadMore,
    @required this.itemBuilder,
    @required this.itemCount,
    this.appBar,
    this.emptyAfterRefreshWidget,
    this.noMoreItemsWidget,
    this.noMoreItemsToLoad = false,
    this.refreshWidgetStyle = RefreshWidgetStyle.Adaptive,
    this.separatorBuilder = _defaultDividerBuilder,
    this.itemPadding = const EdgeInsets.symmetric(
        horizontal: defaultPortraitHorizontalPadding),
    this.appBarUnderneathPadding = const EdgeInsets.only(
        bottom: largeVerticalPadding),
    this.materialRefreshIndicatorDisplacement = 80,
    this.cupertinoRefreshTriggerPullDistance = 70,
    this.cupertinoRefreshIndicatorExtent = 50,
    this.loadMoreTriggerDistance = 200,
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

  /// [LoadingStatus] of the top `pull to refresh`
  LoadingStatus refreshLoadingStatus;

  /// [LoadingStatus] of the bottom `load more`
  LoadingStatus loadMoreStatus;
  double currentMaxScrollExtent;

  RefreshWidgetStyle computedRefreshWidgetStyle;

  /// Number of items before next refresh, it's useful to judge whether item list
  /// is still empty after first refresh
  int itemCountBeforeNextRefresh;

  GlobalKey<MuninRefreshIndicatorState> _materialRefreshKey =
  GlobalKey<MuninRefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    computedRefreshWidgetStyle =
        _getPlatformRefreshWidgetStyle(widget.refreshWidgetStyle);
    refreshLoadingStatus = LoadingStatus.Success;
    loadMoreStatus = LoadingStatus.Success;
  }

  @override
  void dispose() {
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
    if (refreshLoadingStatus == LoadingStatus.Loading ||
        widget.onRefresh == null) {
      return immediateFinishCompleter().future;
    }

    setState(() {
      refreshLoadingStatus = LoadingStatus.Loading;
    });

    Future<void> completer;

    if (computedRefreshWidgetStyle == RefreshWidgetStyle.Cupertino) {
      /// TODO: Waiting for https://github.com/flutter/flutter/issues/31376 to be fixed
      /// then refresh method inside [CupertinoSliverRefreshControl] should be called
      /// instead(like how [_materialRefreshKey] is used below)
      completer = widget.onRefresh();
    } else {
      completer = _materialRefreshKey?.currentState?.show();
    }

    completer.then((v) {
      if (mounted) {
        setState(() {
          refreshLoadingStatus = LoadingStatus.Success;
        });
      }
    }, onError: (error, stack) {
      if (mounted) {
        setState(() {
          refreshLoadingStatus = LoadingStatus.UnknownException;
        });
      }
    });

    return completer;
  }

  /// Different from [callOnRefresh] which might be called externally,
  /// this method is called internally and passed to refresh widget
  RefreshCallback _generateOnRefreshCallBack() {
    return () {
      refreshLoadingStatus = LoadingStatus.Loading;
      Future<void> completer;
      completer = widget.onRefresh();

      completer.then((v) {
        if (mounted) {
          setState(() {
            refreshLoadingStatus = LoadingStatus.Success;
          });
        }
      }, onError: (error, stack) {
        if (mounted) {
          setState(() {
            refreshLoadingStatus = LoadingStatus.UnknownException;
          });
        }
      });

      return completer;
    };
  }

  Future<void> callOnLoadMore() {
    if (loadMoreStatus == LoadingStatus.Loading) {
      return immediateFinishCompleter().future;
    }

    setState(() {
      loadMoreStatus = LoadingStatus.Loading;
    });

    Future<void> completer = widget.onLoadMore();

    completer.then((v) {
      if (mounted) {
        setState(() {
          loadMoreStatus = LoadingStatus.Success;
        });
      }
    }, onError: (error, stack) {
      setState(() {
        if (mounted) {
          setState(() {
            loadMoreStatus = LoadingStatus.UnknownException;
          });
        }
      });
    });

    return completer;
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

    if (Platform.isIOS) {
      return RefreshWidgetStyle.Cupertino;
    }

    return RefreshWidgetStyle.Material;
  }

  _buildLoadMoreStatusIndicatorWidget() {
    Widget coreWidget;

    if (loadMoreStatus == LoadingStatus.Initial) {
      coreWidget = Container();
    } else if (loadMoreStatus == LoadingStatus.Loading) {
      coreWidget = AdaptiveProgressIndicator();
    } else if (loadMoreStatus == LoadingStatus.Success) {
      if (widget.noMoreItemsToLoad) {
        assert(widget.noMoreItemsWidget != null,
            'noMoreItemWidget must not be null if noMoreItems is set to true');
        if (widget.noMoreItemsWidget != null) {
          coreWidget = widget.noMoreItemsWidget;
        } else {
          coreWidget = Container();
        }
      } else {
        /// Show a load more button to let user load more contents
        coreWidget = FlatButton(
          child: Text(loadMoreText),
          onPressed: () {
            callOnLoadMore();
          },
        );
      }
    } else if (loadMoreStatus.isException) {
      coreWidget = FlatButton(
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
    return refreshLoadingStatus == LoadingStatus.Loading &&
        widget.itemCount == 0 &&
        computedRefreshWidgetStyle == RefreshWidgetStyle.Cupertino;
  }

  /// Build a plain [CustomScrollView] that just contains an AppBar(if present)
  /// and items
  /// [includeCupertinoRefreshWidget] is set to `false` by default
  CustomScrollView _buildCustomScrollViewBody({
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
        // TODO: waiting for https://github.com/flutter/flutter/issues/31382 to be
        // resolved to switch back to the official widget
        slivers.add(MuninCupertinoSliverRefreshControl(
          onRefresh: _generateOnRefreshCallBack(),
          refreshIndicatorExtent: widget.cupertinoRefreshIndicatorExtent,
          refreshTriggerPullDistance: widget
              .cupertinoRefreshTriggerPullDistance,
        ));
      }
    }


    if (widget.appBarUnderneathPadding != null) {
      slivers.add(SliverPadding(
        padding: widget.appBarUnderneathPadding,
      ));
    }

    if (shouldAttachEmptyAfterRefreshWidget()) {
      SliverList emptyAfterRefreshWidget = SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return widget.emptyAfterRefreshWidget;
          },
          childCount: 1,
        ),
      );
      if (widget.itemPadding != null) {
        slivers.add(SliverPadding(
          padding: widget.itemPadding,
          sliver: emptyAfterRefreshWidget,
        ));
      } else {
        slivers.add(emptyAfterRefreshWidget);
      }
    }

    SliverList sliverItemsList = _buildItemsSliverList();
    if (widget.itemPadding != null) {
      slivers.add(SliverPadding(
        padding: widget.itemPadding,
        sliver: sliverItemsList,
      ));
    } else {
      slivers.add(sliverItemsList);
    }

    /// It doesn't make sense(and it's theoretically not possible) to show a
    /// load more status widget if there is currently no item. So we assume
    /// itemCount must >0 here
    if (includeLoadMoreStatusWidget && widget.itemCount > 0) {
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
      return _buildCustomScrollViewBody(
          includeCupertinoRefreshWidget: true,
          includeLoadMoreStatusWidget: includeLoadMoreStatusWidget);
    } else {
      return MuninRefreshIndicator(
        key: _materialRefreshKey,
        displacement: widget.materialRefreshIndicatorDisplacement,
        child: _buildCustomScrollViewBody(
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
        loadMoreStatus.canInitializeNextLoad &&
        notification.metrics.maxScrollExtent != 0.0 &&
        currentMaxScrollExtent != notification.metrics.maxScrollExtent) {
      currentMaxScrollExtent = notification.metrics.maxScrollExtent;
      debugPrint(
          'Fetch older items under maxScrollExtent:${notification.metrics.maxScrollExtent}, ' +
              'pixels: ${notification.metrics.pixels}, diff: ${notification.metrics.maxScrollExtent - notification.metrics.pixels}.');

      callOnLoadMore();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onRefresh == null && widget.onRefresh == null) {
      return _buildCustomScrollViewBody();
    }

    if (widget.onLoadMore == null) {
      return _buildScrollBodyWithAdaptiveRefreshWidget(
          includeLoadMoreStatusWidget: false);
    }

    if (widget.onRefresh == null) {
      return NotificationListener<ScrollNotification>(
        onNotification: _onScrollNotification,
        child: _buildCustomScrollViewBody(),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: _onScrollNotification,
      child: _buildScrollBodyWithAdaptiveRefreshWidget(
          includeLoadMoreStatusWidget: true),
    );
  }
}
