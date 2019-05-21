import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/discussion/DiscussionItem.dart';
import 'package:munin/models/bangumi/discussion/FetchDiscussionRequest.dart';
import 'package:munin/models/bangumi/discussion/FetchDiscussionResponse.dart';
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
          separatorBuilder: null,
        );
      },
    );
  }
}

class _ViewModel {
  final FetchDiscussionRequest fetchDiscussionRequest;
  final FetchDiscussionResponse rakuenTopics;
  final MuteSetting muteSetting;

  final bool Function(DiscussionItem item) isMuted;

  final Function(MutedGroup mutedGroup) muteGroup;
  final Function(String groupId) unMuteGroup;

  final Function(BuildContext context) getRakuenTopics;

  factory _ViewModel.fromStore(
      Store<AppState> store, FetchDiscussionRequest fetchDiscussionRequest) {
    Future _getRakuenTopics(BuildContext context) {
      final action = GetDiscussionRequestAction(
          context: context, fetchDiscussionRequest: fetchDiscussionRequest);
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
      fetchDiscussionRequest: fetchDiscussionRequest,
      rakuenTopics: store.state.discussionState.results[fetchDiscussionRequest],
      getRakuenTopics: _getRakuenTopics,
      muteSetting: store.state.settingState.muteSetting,
      muteGroup: _muteGroup,
      unMuteGroup: _unMuteGroup,
      isMuted: _isMuted,
    );
  }

  _ViewModel({
    this.fetchDiscussionRequest,
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
              fetchDiscussionRequest == other.fetchDiscussionRequest &&
              rakuenTopics == other.rakuenTopics &&
              muteSetting == other.muteSetting;

  @override
  int get hashCode =>
      hash3(
          fetchDiscussionRequest.hashCode,
          rakuenTopics.hashCode,
          muteSetting.hashCode);

}
