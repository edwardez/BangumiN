import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/setting/mute/MuteSetting.dart';
import 'package:munin/models/bangumi/setting/mute/MutedGroup.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:munin/redux/app/AppActions.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/setting/SettingActions.dart';
import 'package:munin/router/routes.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/setting/mute/HowToAdd.dart';
import 'package:munin/widgets/setting/mute/MutedGroupListTile.dart';
import 'package:munin/widgets/setting/mute/MutedUserListTile.dart';
import 'package:munin/widgets/shared/common/ScaffoldWithSliverAppBar.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:redux/redux.dart';

class MuteSettingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      distinct: true,
      builder: (BuildContext context, _ViewModel vm) {
        return ScaffoldWithSliverAppBar(
            enableTopSafeArea: false,
            enableBottomSafeArea: false,
            safeAreaChildPadding: const EdgeInsets.only(
                left: 0, right: 0, top: largeVerticalPadding),
            appBarMainTitle: Text(
              '屏蔽',
            ),
            nestedScrollViewBody: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  title: Text(
                    '屏蔽用户',
                    style: Theme.of(context)
                        .textTheme
                        .body2
                        .copyWith(color: lightPrimaryDarkAccentColor(context)),
                  ),
                  subtitle: Text('作用于时间线，小组讨论与作品评价'),
                  trailing: IconButton(
                    icon: Icon(OMIcons.helpOutline),
                    onPressed: () {
                      showHowToAddUserDialog(context);
                    },
                  ),
                ),
                for (MutedUser user in vm.muteSetting.mutedUsers.values)
                  MutedUserListTile(
                    mutedUser: user,
                    onUnmute: (MutedUser mutedUser) {
                      vm.updateMuteSetting(vm.muteSetting.rebuild(
                          (b) => b.mutedUsers.remove(mutedUser.username)));
                    },
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultDensePortraitHorizontalPadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          onPressed: () {
                            Application.router.navigateTo(context,
                                Routes.muteSettingBatchImportUsersRoute,
                                transition: TransitionType.nativeModal);
                          },
                          child: Text('导入已绝交用户'),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    '屏蔽超展开小组',
                    style: Theme.of(context)
                        .textTheme
                        .body2
                        .copyWith(color: lightPrimaryDarkAccentColor(context)),
                  ),
                  trailing: IconButton(
                    icon: Icon(OMIcons.helpOutline),
                    onPressed: () {
                      showHowToAddGroupDialog(context);
                    },
                  ),
                ),
                for (MutedGroup group in vm.muteSetting.mutedGroups.values)
                  MutedGroupListTile(
                    mutedGroup: group,
                    onUnmute: (MutedGroup group) {
                      vm.updateMuteSetting(vm.muteSetting
                          .rebuild((b) => b.mutedGroups.remove(group.groupId)));
                    },
                  ),
                Divider(),
                ListTile(
                  title: Text(
                    '杂项',
                    style: Theme.of(context)
                        .textTheme
                        .body2
                        .copyWith(color: lightPrimaryDarkAccentColor(context)),
                  ),
                ),
                SwitchListTile.adaptive(
                  value: vm.muteSetting.muteOriginalPosterWithDefaultIcon,
                  onChanged: (bool newValue) {
                    vm.updateMuteSetting(vm.muteSetting.rebuild((b) => b
                      ..muteOriginalPosterWithDefaultIcon =
                          !vm.muteSetting.muteOriginalPosterWithDefaultIcon));
                  },
                  activeColor: lightPrimaryDarkAccentColor(context),
                  title: Text('屏蔽默认头像用户的发帖'),
                  subtitle: Text('不屏蔽回复，可有效屏蔽广告机，但也会误伤正常用户。'),
                ),
                Divider(),
                ListTile(
                  subtitle: Text('所有的屏蔽设置均从下一次刷新后开始生效，当前数据不受影响'),
                )
              ],
            ));
      },
    );
  }
}

class _ViewModel {
  final MuteSetting muteSetting;
  final void Function(MuteSetting muteSetting, {bool persisToDisk})
      updateMuteSetting;

  factory _ViewModel.fromStore(Store<AppState> store) {
    _updateMuteSetting(
      MuteSetting muteSetting, {
      persisToDisk = true,
    }) {
      store.dispatch(UpdateMuteSettingAction(muteSetting: muteSetting));
      if (persisToDisk) {
        store.dispatch(PersistAppStateAction(basicAppStateOnly: true));
      }
    }

    return _ViewModel(
      muteSetting: store.state.settingState.muteSetting,
      updateMuteSetting: _updateMuteSetting,
    );
  }

  _ViewModel({
    @required this.updateMuteSetting,
    @required this.muteSetting,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          muteSetting == other.muteSetting;

  @override
  int get hashCode => muteSetting.hashCode;
}
