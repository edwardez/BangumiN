import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/BangumiUserSmall.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/models/bangumi/user/Relationship.dart';
import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/models/bangumi/user/collection/preview/CollectionsOnProfilePage.dart';
import 'package:munin/redux/app/AppActions.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/setting/SettingActions.dart';
import 'package:munin/redux/user/UserActions.dart';
import 'package:munin/shared/utils/misc/Launch.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/avatar/CachedCircleAvatar.dart';
import 'package:munin/widgets/shared/common/RequestInProgressIndicatorWidget.dart';
import 'package:munin/widgets/shared/common/SnackBar.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';
import 'package:munin/widgets/shared/services/Clipboard.dart';
import 'package:munin/widgets/user/CollectionPreviewWidget.dart';
import 'package:munin/widgets/user/TimelinePreviewWidget.dart';
import 'package:munin/widgets/user/UserIntroductionPreview.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

class UserProfileWidget extends StatelessWidget {
  ///  An [SliverAppBar] or its container that's on top of the profile
  final Widget providedAppBar;

  final String username;

  /// Outer padding for all profile widgets, appBar is not included
  final EdgeInsetsGeometry profileWidgetsPadding;

  String get userProfileMainUrl =>
      'https://$bangumiMainHost/user/$username';

  const UserProfileWidget(
      {Key key,
      @required this.username,
      Widget appBar,
      this.profileWidgetsPadding = const EdgeInsets.symmetric(
          vertical: largeOffset, horizontal: defaultPortraitHorizontalOffset)})
      : this.providedAppBar = appBar,
        assert(username != null && username != ''),
        super(key: key);

  _buildMuteAction(BuildContext context, _ViewModel vm) {
    if (vm.isCurrentAppUser) {
      return Container();
    }

    if (vm.isMuted) {
      return ListTile(
        leading: Icon(AdaptiveIcons.unmuteIconData),
        title: Text('解除屏蔽'),
        onTap: () {
          vm.unMuteUser();
          showTextOnSnackBar(
              context,
              '${vm.userProfile.basicInfo.nickname} 将会被解除屏蔽，'
              '下次刷新数据后生效');
          Navigator.of(context).pop();
        },
      );
    } else {
      return ListTile(
        leading: Icon(AdaptiveIcons.muteIconData),
        title: Text('屏蔽此用户'),
        onTap: () {
          vm.muteUser();
          showTextOnSnackBar(
              context, '${vm.userProfile.basicInfo.nickname} 将会被屏蔽， 下次刷新数据后生效');
          Navigator.of(context).pop();
        },
      );
    }
  }

  _buildMoreActionsMenu(BuildContext outerContext, _ViewModel vm) {
    showModalBottomSheet(
        context: outerContext,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: Icon(AdaptiveIcons.clipBoardIconData),
                    title: Text('复制主页地址'),
                    onTap: () {
                      ClipboardService.copyAsPlainText(
                          outerContext, userProfileMainUrl,
                          popContext: true);
                    },
                  ),
                  ListTile(
                    leading: Icon(AdaptiveIcons.openInBrowserIconData),
                    title: Text(checkWebVersionLabel),
                    onTap: () {
                      launchByPreference(
                          context, userProfileMainUrl, popContext: true);
                    },
                  ),
                  ListTile(
                    leading: Icon(AdaptiveIcons.statisticsIconData),
                    title: Text('$goToForsetiLabel查看统计数据'),
                    onTap: () {
                      launchByPreference(context,
                          'https://${Application.environmentValue
                              .forsetiMainHost}/user/$username/statistics',
                          popContext: true);
                    },
                  ),
                  _buildMuteAction(outerContext, vm),
                ],
              ),
            ),
          );
        });
  }

  _buildCollectionPreviews(BuildContext context, String username,
      BuiltMap<SubjectType, CollectionsOnProfilePage> previews) {
    List<Widget> widgets = [];
    previews
        .forEach((SubjectType subjectType, CollectionsOnProfilePage preview) {
      widgets.add(CollectionPreviewWidget(
        preview: preview,
        username: username,
      ));
    });
    return widgets;
  }

  SliverList _buildProfile(BuildContext context, _ViewModel vm) {
    UserProfile profile = vm.userProfile;

    List<Widget> widgets = [];
    widgets.addAll([
      Row(
        children: <Widget>[
          CachedCircleAvatar(
            imageUrl: profile.basicInfo.avatar.large,
            radius: 30,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                if (!vm.isCurrentAppUser)
                  OutlineButton(
                    child: Row(
                      children: <Widget>[
                        Text(Relationship.relationshipText(
                            profile.relationships)),
                      ],
                    ),
                    onPressed: null,
                  ),
                IconButton(
                  icon: Icon(AdaptiveIcons.moreActionsIconData),
                  onPressed: () {
                    _buildMoreActionsMenu(context, vm);
                  },
                )
              ],
            ),
          )
        ],
      ),
      Padding(
        padding: EdgeInsets.only(top: 10),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(profile.basicInfo.nickname),
          Text(
            '@${profile.basicInfo.username}',
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
      Padding(
        padding: EdgeInsets.only(top: 10),
      ),
      UserIntroductionPreview(
        profile: profile,
      ),
      Padding(
        padding: EdgeInsets.only(top: 10),
      ),
    ]);

    widgets.addAll(_buildCollectionPreviews(
        context, profile.basicInfo.username, profile.collectionPreviews));

    widgets.addAll([
      TimelinePreviewWidget(
          profile: profile, isCurrentAppUser: vm.isCurrentAppUser),
//      Divider(),
//      InkWell(
//        child: Row(
//          children: <Widget>[
//            WrappableText(
//              '收藏的人物',
//              fit: FlexFit.tight,
//              textStyle: Theme.of(context).textTheme.subtitle1,
//            ),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Icon(
//                AdaptiveIcons.forwardIconData,
//              ),
//            )
//          ],
//        ),
//        onTap: () {
//          launch('$userProfileMainUrl/mono');
//        },
//      ),
//      Divider(),
//      InkWell(
//        child: Row(
//          children: <Widget>[
//            WrappableText(
//              '好友',
//              fit: FlexFit.tight,
//              textStyle: Theme.of(context).textTheme.subtitle1,
//            ),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Icon(
//                AdaptiveIcons.forwardIconData,
//              ),
//            )
//          ],
//        ),
//        onTap: () {
//          launch('$userProfileMainUrl/friends');
//        },
//      ),
//      Divider(),
//      InkWell(
//        child: Row(
//          children: <Widget>[
//            WrappableText(
//              '目录',
//              fit: FlexFit.tight,
//              textStyle: Theme.of(context).textTheme.subtitle1,
//            ),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Icon(
//                AdaptiveIcons.forwardIconData,
//              ),
//            )
//          ],
//        ),
//        onTap: () {
//          launch('$userProfileMainUrl/index');
//        },
//      ),
//      Divider(),
//      InkWell(
//        child: Row(
//          children: <Widget>[
//            WrappableText(
//              '参加的小组',
//              fit: FlexFit.tight,
//              textStyle: Theme.of(context).textTheme.subtitle1,
//            ),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Icon(
//                AdaptiveIcons.forwardIconData,
//              ),
//            )
//          ],
//        ),
//        onTap: () {
//          launch('$userProfileMainUrl/groups');
//        },
//      ),
    ]);

    return SliverList(
      delegate: SliverChildListDelegate(
        widgets,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<void> requestStatusFuture;

    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) =>
          _ViewModel.fromStore(store, username),
      distinct: true,
      onInit: (store) {
        final action = GetUserPreviewRequestAction(username: username);
        store.dispatch(action);
        requestStatusFuture = action.completer.future;
      },
      builder: (BuildContext context, _ViewModel vm) {
        if (vm.userProfile == null) {
          if (providedAppBar == null) {
            return RequestInProgressIndicatorWidget(
              retryCallback: (_) => vm.getUserProfile(),
              requestStatusFuture: requestStatusFuture,
            );
          } else {
            return NestedScrollView(
              body: RequestInProgressIndicatorWidget(
                showOnlyRequestIndicatorBody: true,
                retryCallback: (_) => vm.getUserProfile(),
                requestStatusFuture: requestStatusFuture,
              ),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  providedAppBar,
                ];
              },
            );
          }
        }

        Widget appBar;

        if (providedAppBar == null) {
          appBar = SliverAppBar(
            pinned: true,
            title: Text('${vm.userProfile.basicInfo.nickname}的主页'),
            elevation: defaultSliverAppBarElevation,
          );
        } else {
          appBar = providedAppBar;
        }

        Widget scrollSliver;

        scrollSliver = SliverPadding(
          padding: profileWidgetsPadding,
          sliver: _buildProfile(context, vm),
        );

        return CustomScrollView(
          slivers: <Widget>[appBar, scrollSliver],
        );
      },
    );
  }
}

class _ViewModel {
  /// Whether the user page belongs to current user who is using the app
  /// If set to true, user page will be rendered as 'I'm viewing my profile'
  /// Otherwise it's going to be rendered as 'I'm viewing other people's profile'
  final bool isCurrentAppUser;
  final bool isMuted;

  final String username;
  final UserProfile userProfile;
  final Future<void> Function() getUserProfile;
  final Function() muteUser;
  final Function() unMuteUser;

  factory _ViewModel.fromStore(Store<AppState> store, String username) {
    Future<void> _getUserProfile() {
      final action = GetUserPreviewRequestAction(username: username);
      store.dispatch(action);
      return action.completer.future;
    }

    _muteUser() {
      UserProfile userProfile = store.state.userState.profiles[username];
      if (userProfile == null) {
        return;
      }

      final action = MuteUserAction(
          mutedUser: MutedUser.fromBangumiUserSmall(userProfile.basicInfo));
      store.dispatch(action);
      store.dispatch(PersistAppStateAction(basicAppStateOnly: true));
    }

    _unMuteUser() {
      UserProfile userProfile = store.state.userState.profiles[username];
      if (userProfile == null) {
        return;
      }

      final action = UnmuteUserAction(
          mutedUser: MutedUser.fromBangumiUserSmall(userProfile.basicInfo));
      store.dispatch(action);
      store.dispatch(PersistAppStateAction(basicAppStateOnly: true));
    }

    bool _isMuted() {
      assert(username != null);

      return store.state.settingState.muteSetting.mutedUsers
          .containsKey(username);
    }

    bool _isCurrentAppUser() {
      bool isCurrentAppUser;
      BangumiUserSmall currentUser =
          store.state.currentAuthenticatedUserBasicInfo;

      /// If [username] is the same as current app user username
      /// Or passed-in username is the same as id of the current app user username
      /// set isCurrentAppUser to true
      /// The second username-id check is needed because id(pure digit) and username(~alphanumeric)
      /// can both be used to identify a user
      if (currentUser.username == username ||
          currentUser.id.toString() == username) {
        isCurrentAppUser = true;
      } else {
        isCurrentAppUser = false;
      }

      return isCurrentAppUser;
    }

    return _ViewModel(
      username: username,
      userProfile: store.state.userState.profiles[username],
      getUserProfile: _getUserProfile,
      isCurrentAppUser: _isCurrentAppUser(),
      muteUser: _muteUser,
      unMuteUser: _unMuteUser,
      isMuted: _isMuted(),
    );
  }

  _ViewModel({
    @required this.username,
    @required this.userProfile,
    @required this.getUserProfile,
    @required this.isCurrentAppUser,
    @required this.isMuted,
    @required this.muteUser,
    @required this.unMuteUser,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          isCurrentAppUser == other.isCurrentAppUser &&
          isMuted == other.isMuted &&
          username == other.username &&
          userProfile == other.userProfile;

  @override
  int get hashCode =>
      hashObjects([isCurrentAppUser, isMuted, username, userProfile]);
}
