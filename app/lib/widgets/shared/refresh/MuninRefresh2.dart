import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/common/Divider.dart';
import 'package:munin/widgets/shared/refresh/MuninCupertinoHeader.dart';
import 'package:munin/widgets/shared/refresh/MuninRefresh.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// The signature for a function that's called when a refresh should be performed
/// The returned [Future] must complete when the refresh operation is
/// finished.
typedef RefreshCallback = Future<void> Function();

class MuninRefresh2 extends StatefulWidget {
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

  const MuninRefresh2({
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
    return _MuninRefresh2State();
  }
}

class _MuninRefresh2State extends State<MuninRefresh2> {
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await widget.onRefresh();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await widget.onLoadMore();
    // // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  static int _computeChildCount(bool hasSeparator, int itemCount) {
    if (hasSeparator) {
      return math.max(0, itemCount * 2 - 1);
    }

    return itemCount;
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

  @override
  Widget build(BuildContext context) {
    final bool hasSeparator = widget.separatorBuilder != null;

    return NestedScrollView(
      headerSliverBuilder: (c, s) => [widget.appBar],
      body: RefreshConfiguration(
        headerTriggerDistance: 80.0,
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,

          header: MuninCupertinoHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("pull up load");
              } else if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("Load Failed!Click retry!");
              } else if (mode == LoadStatus.canLoading) {
                body = Text("release to load more");
              } else {
                body = Text("No more Data");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          // child: ListView.builder(
          //   itemBuilder: (c, i) => Card(child: Center(child: Text(items[i]))),
          //   itemExtent: 100.0,
          //   itemCount: items.length,
          // ),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      _sliverListChildBuilder(
                          widget.itemBuilder, widget.separatorBuilder),
                      childCount:
                          _computeChildCount(hasSeparator, widget.itemCount),
                      semanticIndexCallback: (Widget _, int index) {
                if (hasSeparator) {
                  return index.isEven ? index ~/ 2 : null;
                }
                return index;
              }))
            ],
          ),
        ),
      ),
    );
  }
}
