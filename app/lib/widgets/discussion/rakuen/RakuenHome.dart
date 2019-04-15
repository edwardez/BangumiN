import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/discussion/FetchDiscussionRequest.dart';
import 'package:munin/models/bangumi/discussion/FetchDiscussionResponse.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/discussion/DiscussionActions.dart';
import 'package:munin/widgets/discussion/common/DiscussionItemWidget.dart';
import 'package:munin/widgets/shared/link/LinkTextSpan.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

class RakuenHome extends StatefulWidget {
  static String rakuenMobileUrl =
      'https://${Application.environmentValue.bangumiMainHost}/m';

  final FetchDiscussionRequest fetchDiscussionRequest;

  const RakuenHome({Key key, @required this.fetchDiscussionRequest})
      : super(key: key);

  @override
  _RakuenHomeState createState() => _RakuenHomeState();
}

class _RakuenHomeState extends State<RakuenHome> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Widget _buildTopicList(
      BuildContext context, FetchDiscussionResponse rakuenTopics) {
    if (rakuenTopics == null) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
      );
    }

    if (rakuenTopics.discussionItemsAsList.length == 0) {
      /// TODO: make this a reusable widget
      final linkStyle = TextStyle(color: Theme.of(context).primaryColor);
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          Column(
            children: <Widget>[
              Text('Bangumi上暂无内容或内容无法解析'),
              RichText(
                text: LinkTextSpan(
                    text: '查看对应网页版',
                    url: RakuenHome.rakuenMobileUrl,
                    style: linkStyle),
              )
            ],
          )
        ],
      );
    }

    return ListView.builder(
        itemCount: rakuenTopics.discussionItemsAsList.length,
        itemBuilder: (BuildContext context, int index) {
          return DiscussionItemWidget(
            discussionItem: rakuenTopics.discussionItemsAsList[index],
          );
        });
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
          _refreshIndicatorKey?.currentState?.show();
        }
      },
      builder: (BuildContext context, _ViewModel vm) {
        return RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () {
            return vm.getRakuenTopics(context);
          },
          child: _buildTopicList(context, vm.rakuenTopics),
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
