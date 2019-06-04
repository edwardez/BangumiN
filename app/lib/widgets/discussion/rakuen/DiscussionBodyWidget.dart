import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/discussion/DiscussionItem.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionRequest.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionResponse.dart';
import 'package:munin/models/bangumi/discussion/GroupDiscussionPost.dart';
import 'package:munin/models/bangumi/setting/mute/MuteSetting.dart';
import 'package:munin/models/bangumi/setting/mute/MutedGroup.dart';
import 'package:munin/redux/app/AppActions.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/discussion/DiscussionActions.dart';
import 'package:munin/redux/setting/SettingActions.dart';
import 'package:munin/shared/utils/collections/common.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/widgets/discussion/common/DiscussionItemWidget.dart';
import 'package:munin/widgets/shared/appbar/OneMuninBar.dart';
import 'package:munin/widgets/shared/common/MuninPadding.dart';
import 'package:munin/widgets/shared/refresh/MuninRefresh.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

class DiscussionBodyWidget extends StatefulWidget {
  final GetDiscussionRequest getDiscussionRequest;

  final OneMuninBar oneMuninBar;

  const DiscussionBodyWidget({Key key,
    @required this.getDiscussionRequest,
    @required this.oneMuninBar})
      : super(key: key);

  @override
  _DiscussionBodyWidgetState createState() => _DiscussionBodyWidgetState();
}

class _DiscussionBodyWidgetState extends State<DiscussionBodyWidget> {
  GlobalKey<MuninRefreshState> _muninRefreshKey =
  GlobalKey<MuninRefreshState>();

  /// A widget that will show up if the timeline is empty
  Widget _buildEmptyRakuenWidget() {
    return MuninPadding(
      child: Column(
        children: <Widget>[
          Text('讨论列表为空，可能因为$appOrBangumiHasAnError，下拉可重试'),
          FlatButton(
            child: Text(checkWebVersionPrompt),
            onPressed: () {
              return launch(rakuenMobileUrl, forceSafariVC: false);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store store) =>
          _ViewModel.fromStore(store, widget.getDiscussionRequest),
      distinct: true,
      onInitialBuild: (_ViewModel vm) {
        /// Auto-refresh if data is null or stale
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
              onMute: (DiscussionItem item) {
                vm.muteGroup(MutedGroup.fromGroupDiscussionPost(
                    item as GroupDiscussionPost));
              },
              onUnmute: (DiscussionItem item) {
                vm.unMuteGroup((item as GroupDiscussionPost).postedGroupId);
              },
              isMuted: vm.isMuted,
            );
          },
          itemCount: vm.rakuenTopics?.discussionItemsAsList?.length ?? 0,
          emptyAfterRefreshWidget: _buildEmptyRakuenWidget(),
          appBar: widget.oneMuninBar,
        );
      },
    );
  }
}

class _ViewModel {
  final GetDiscussionRequest getDiscussionRequest;
  final GetDiscussionResponse rakuenTopics;
  final MuteSetting muteSetting;

  final bool Function(DiscussionItem item) isMuted;

  final Function(MutedGroup mutedGroup) muteGroup;
  final Function(String groupId) unMuteGroup;

  final Function(BuildContext context) getRakuenTopics;

  factory _ViewModel.fromStore(Store<AppState> store,
      GetDiscussionRequest getDiscussionRequest) {
    Future _getRakuenTopics(BuildContext context) {
      final action = GetDiscussionRequestAction(
          context: context, getDiscussionRequest: getDiscussionRequest);
      store.dispatch(action);
      return action.completer.future;
    }

    _muteGroup(MutedGroup mutedGroup) {
      final action = MuteGroupAction(mutedGroup: mutedGroup);
      store.dispatch(action);
      store.dispatch(PersistAppStateAction(basicAppStateOnly: true));
    }

    _unMuteGroup(String groupId) {
      final action = UnmuteGroupAction(groupId: groupId);
      store.dispatch(action);
      store.dispatch(PersistAppStateAction(basicAppStateOnly: true));
    }

    bool _isMuted(DiscussionItem item) {
      assert(item is GroupDiscussionPost, 'Only GroupDiscussionPost has a valid mute status');
      if (item is! GroupDiscussionPost) {
        return false;
      }


      String postedGroupId = (item as GroupDiscussionPost).postedGroupId;

      return postedGroupId != null &&
          store.state.settingState.muteSetting.mutedGroups.containsKey(
              postedGroupId);
    }

    return _ViewModel(
      getDiscussionRequest: getDiscussionRequest,
      rakuenTopics: store.state.discussionState
          .discussions[getDiscussionRequest],
      getRakuenTopics: _getRakuenTopics,
      muteSetting: store.state.settingState.muteSetting,
      muteGroup: _muteGroup,
      unMuteGroup: _unMuteGroup,
      isMuted: _isMuted,
    );
  }

  _ViewModel({
    this.getDiscussionRequest,
    this.rakuenTopics,
    this.getRakuenTopics,
    this.isMuted,
    this.muteGroup,
    this.unMuteGroup,
    this.muteSetting,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is _ViewModel &&
              runtimeType == other.runtimeType &&
              getDiscussionRequest == other.getDiscussionRequest &&
              rakuenTopics == other.rakuenTopics &&
              muteSetting == other.muteSetting;

  @override
  int get hashCode =>
      hash3(
          getDiscussionRequest,
          rakuenTopics,
          muteSetting);

}
