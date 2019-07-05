import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/timeline/PublicMessageNormal.dart';
import 'package:munin/models/bangumi/timeline/common/GetTimelineRequest.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineCategoryFilter.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineSource.dart';
import 'package:munin/models/bangumi/timeline/message/FullPublicMessage.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/timeline/TimelineActions.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/appbar/AppbarWithLoadingIndicator.dart';
import 'package:munin/widgets/shared/background/RoundedConcreteBackgroundWithChild.dart';
import 'package:munin/widgets/shared/common/RequestInProgressIndicatorWidget.dart';
import 'package:munin/widgets/shared/common/ScrollViewWithSliverAppBar.dart';
import 'package:munin/widgets/shared/common/SingleChildExpandedRow.dart';
import 'package:munin/widgets/shared/common/SnackBar.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';
import 'package:munin/widgets/timeline/item/common/Actions.dart';
import 'package:munin/widgets/timeline/item/common/FeedTile.dart';
import 'package:munin/widgets/timeline/message/Common.dart';
import 'package:munin/widgets/timeline/message/PublicMessageReplyComposer.dart';
import 'package:munin/widgets/timeline/message/PublicMessageReplyWidget.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:share/share.dart';

typedef _GetFullPublicMessage = Future<void> Function();

class FullPublicMessageWidget extends StatelessWidget {
  /// The main message, without reply.
  final PublicMessageNormal mainMessage;

  const FullPublicMessageWidget({
    Key key,
    @required this.mainMessage,
  }) : super(key: key);

  Widget _buildReplies(Future<void> requestStatusFuture,
      FullPublicMessage message, _GetFullPublicMessage getFullPublicMessage) {
    /// Message is still being load.
    if (message == null) {
      return RequestInProgressIndicatorWidget(
        requestStatusFuture: requestStatusFuture,
        showOnlyRequestIndicatorBody: true,
        requestGeneralErrorMessageOnSnackBar: '加载回复出错',
        retryCallback: (_) => getFullPublicMessage(),
      );
    }

    return Row(
      children: <Widget>[
        if (message.replies.isNotEmpty)
          Expanded(
            child: RoundedConcreteBackgroundWithChild(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (var reply in message.replies)
                  SingleChildExpandedRow(
                    child: PublicMessageReplyWidget(
                      publicMessageReply: reply,
                      mainMessage: message.mainMessage,
                    ),
                  )
              ],
            )),
          )
      ],
    );
  }

  _buildAppBarTitle(BuildContext context, FullPublicMessage message,
      Future<void> requestStatusFuture) {
    final indicatorText = message == null ? '加载评论中' : '刷新评论中';

    return WidgetWithLoadingIndicator(
      requestStatusFuture: requestStatusFuture,
      bottomStatusIndicator: Text(
        indicatorText,
        style: defaultCaptionText(context),
      ),
      child: Text('正文'),
    );
  }

  Widget _buildShareButton() {
    return IconButton(
      icon: Icon(AdaptiveIcons.shareIconData),
      onPressed: () {
        String url = 'https://${Application.environmentValue.bangumiMainHost}'
            '/user/${mainMessage.user.username}/timeline/status/${mainMessage.user.feedId}';

        Share.share(url);
      },
    );
  }

  Widget _buildReplyButton(
    BuildContext context,
    String appUsername,
  ) {
    return Builder(
      builder: (buttonContext) {
        return IconButton(
          icon: Icon(
            OMIcons.reply,
          ),
          onPressed: () {
            showSnackBarOnSuccess(
              buttonContext,
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PublicMessageReplyComposer(
                        mainMessage: mainMessage,
                        widgetOnTop: PublicMessageReplyWidget.buildQuotedTextWidget(
                            '${mainMessage.user.nickName}: ${mainMessage.contentHtml}'),
                      ),
                ),
              ),
              onReplySuccessText,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<void> requestStatusFuture;

    return StoreConnector<AppState, _ViewModel>(
      converter: (Store store) => _ViewModel.fromStore(
            store,
            mainMessage,
          ),
      distinct: true,
      onInit: (store) {
        final action =
            GetFullPublicMessageRequestAction(mainMessage: mainMessage);

        store.dispatch(action);
        requestStatusFuture = action.completer.future;
      },
      builder: (BuildContext context, _ViewModel vm) {
        return Scaffold(
          body: ScrollViewWithSliverAppBar(
              enableBottomSafeArea: false,
              safeAreaChildPadding: EdgeInsets.zero,
              appBarMainTitle: _buildAppBarTitle(
                context,
                vm.fullPublicMessage,
                requestStatusFuture,
              ),
              appBarActions: <Widget>[
                _buildReplyButton(context, vm.appUsername),
                _buildShareButton(),
              ],
              nestedScrollViewBody: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FeedTile(
                      appUsername: vm.appUsername,
                      feed: vm.fullPublicMessage == null
                          ? mainMessage
                          : vm.fullPublicMessage.mainMessage,
                      deleteFeedCallback: vm.deleteFeed,
                      childUnderFeedBody: _buildReplies(
                        requestStatusFuture,
                        vm.fullPublicMessage,
                        vm.getFullPublicMessage,
                      ),
                      allowRedirectToFullPage: false,
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}

class _ViewModel {
  final String appUsername;
  final FullPublicMessage fullPublicMessage;

  final DeleteFeedCallback deleteFeed;
  final _GetFullPublicMessage getFullPublicMessage;

  factory _ViewModel.fromStore(
    Store<AppState> store,
    PublicMessageNormal message,
  ) {
    void _deleteFeed(BuildContext context, TimelineFeed feed) {
      // Use a trick here: create a fake [GetTimelineRequest]. The actual
      // [GetTimelineRequest] might be different but
      // [deleteTimelineFeedSuccessReducer] will take care of deleting message
      // in store. (maybe just remove this parameter?)
      final request = GetTimelineRequest((b) => b
        ..timelineCategoryFilter = TimelineCategoryFilter.PublicMessage
        ..timelineSource = TimelineSource.AllUsers);

      deleteFeedHelper(
        store,
        context,
        request,
        feed,
        popContextOnSuccess: true,
      );
    }

    Future<void> _getFullPublicMessage() {
      final action = GetFullPublicMessageRequestAction(mainMessage: message);

      store.dispatch(action);

      return action.completer.future;
    }

    return _ViewModel(
      appUsername: store.state.currentAuthenticatedUserBasicInfo.username,
      fullPublicMessage:
          store.state.timelineState.fullPublicMessages[message.user.feedId],
      deleteFeed: _deleteFeed,
      getFullPublicMessage: _getFullPublicMessage,
    );
  }

  const _ViewModel({
    @required this.appUsername,
    @required this.deleteFeed,
    @required this.getFullPublicMessage,
    @required this.fullPublicMessage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is _ViewModel &&
              runtimeType == other.runtimeType &&
              appUsername == other.appUsername &&
              fullPublicMessage == other.fullPublicMessage;

  @override
  int get hashCode => hash2(appUsername, fullPublicMessage);
}
