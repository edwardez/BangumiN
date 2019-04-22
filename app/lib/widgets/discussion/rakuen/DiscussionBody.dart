import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/discussion/FetchDiscussionRequest.dart';
import 'package:munin/models/bangumi/discussion/FetchDiscussionResponse.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/discussion/DiscussionActions.dart';
import 'package:munin/shared/utils/collections/common.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/widgets/discussion/common/DiscussionItemWidget.dart';
import 'package:munin/widgets/shared/appbar/OneMuninBar.dart';
import 'package:munin/widgets/shared/refresh/MuninRefresh.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

class DiscussionBody extends StatefulWidget {
  final FetchDiscussionRequest fetchDiscussionRequest;

  final OneMuninBar oneMuninBar;

  const DiscussionBody({Key key,
    @required this.fetchDiscussionRequest,
    @required this.oneMuninBar})
      : super(key: key);

  @override
  _DiscussionBodyState createState() => _DiscussionBodyState();
}

class _DiscussionBodyState extends State<DiscussionBody> {
  GlobalKey<MuninRefreshState> _muninRefreshKey =
  GlobalKey<MuninRefreshState>();

  /// A widget that will show up if the timeline is empty
  Widget _buildEmptyRakuenWidget() {
    return Column(
      children: <Widget>[
        Text('Bangumi上暂无内容或内容无法解析，可能因为应用或bangumi出错，下拉可重试'),
        FlatButton(
          child: Text('查看网页版'),
          onPressed: () {
            return launch(rakuenMobileUrl, forceSafariVC: true);
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store store) =>
          _ViewModel.fromStore(store, widget.fetchDiscussionRequest),
      distinct: true,
      onInitialBuild: (_ViewModel vm) {
        /// Auto-refresh if data doesn't exist or is null
        if (vm.rakuenTopics == null || vm.rakuenTopics.isStale) {
          /// Use null-aware operators to avoid
          /// `NoSuchMethodError: The method 'show' was called on null.`
          /// (Guessing it's a bug in redux?)
          _muninRefreshKey?.currentState?.callOnRefresh();
        }
      },
      builder: (BuildContext context, _ViewModel vm) {
        return MuninRefresh(
          key: _muninRefreshKey,
          onRefresh: () {
            return vm.getRakuenTopics(context);
          },
          onLoadMore: null,
          itemBuilder: (BuildContext context, int index) {
            if (isIterableNullOrEmpty(vm.rakuenTopics?.discussionItemsAsList)) {
              return null;
            }
            return DiscussionItemWidget(
              discussionItem: vm.rakuenTopics.discussionItemsAsList[index],
            );
          },
          itemCount: vm.rakuenTopics?.discussionItemsAsList?.length ?? 0,
          emptyAfterRefreshWidget: _buildEmptyRakuenWidget(),
          appBar: widget.oneMuninBar,
          separatorBuilder: null,

        );
      },
    );
  }
}

class _ViewModel {
  final FetchDiscussionRequest fetchDiscussionRequest;
  final FetchDiscussionResponse rakuenTopics;
  final Function(BuildContext context) getRakuenTopics;

  factory _ViewModel.fromStore(
      Store<AppState> store, FetchDiscussionRequest fetchDiscussionRequest) {
    Future _getRakuenTopics(BuildContext context) {
      final action = GetDiscussionRequestAction(
          context: context, fetchDiscussionRequest: fetchDiscussionRequest);
      store.dispatch(action);
      return action.completer.future;
    }

    return _ViewModel(
      fetchDiscussionRequest: fetchDiscussionRequest,
      rakuenTopics: store.state.discussionState.results[fetchDiscussionRequest],
      getRakuenTopics: (BuildContext context) => _getRakuenTopics(context),
    );
  }

  _ViewModel(
      {this.fetchDiscussionRequest, this.rakuenTopics, this.getRakuenTopics});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          fetchDiscussionRequest == other.fetchDiscussionRequest &&
          rakuenTopics == other.rakuenTopics;

  @override
  int get hashCode =>
      hash2(fetchDiscussionRequest.hashCode, rakuenTopics.hashCode);
}
