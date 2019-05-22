import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionRequest.dart';
import 'package:munin/models/bangumi/progress/common/GetProgressRequest.dart';
import 'package:munin/models/bangumi/setting/general/GeneralSetting.dart';
import 'package:munin/models/bangumi/setting/general/PreferredLaunchNavTab.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineCategoryFilter.dart';
import 'package:munin/redux/app/AppActions.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/setting/SettingActions.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/setting/theme/Common.dart';
import 'package:munin/widgets/shared/common/ScaffoldWithSliverAppBar.dart';
import 'package:munin/widgets/shared/common/TransparentDividerThemeContext.dart';
import 'package:redux/redux.dart';

class GeneralSettingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      distinct: true,
      builder: (BuildContext context, _ViewModel vm) {
        return ScaffoldWithSliverAppBar(
          enableTopSafeArea: false,
          enableBottomSafeArea: false,
          safeAreaChildPadding: const EdgeInsets.only(
              left: 0, right: 0, top: largeVerticalPadding),
          appBarMainTitle: Text('通用设置'),
          nestedScrollViewBody: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                title: Text(
                  '启动',
                  style: Theme.of(context)
                      .textTheme
                      .body2
                      .copyWith(color: lightPrimaryDarkAccentColor(context)),
                ),
              ),
              ThemeWithTransparentDivider(
                child: ExpansionTile(
                  key: PageStorageKey<String>(
                      'general-setting-launch-preferredLaunchNavTab'),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('启动后进入页面'),
                      ),
                      Text(vm.generalSetting.preferredLaunchNavTab
                          .generalSettingPageChineseName),
                    ],
                  ),
                  children: <Widget>[
                    for (PreferredLaunchNavTab launchPage
                        in PreferredLaunchNavTab.values.toList())
                      ListTile(
                        title: Text(launchPage.generalSettingPageChineseName),
                        trailing: buildTrailingIcon<PreferredLaunchNavTab>(
                            context,
                            vm.generalSetting.preferredLaunchNavTab,
                            launchPage),
                        onTap: () {
                          vm.updateGeneralSetting(vm.generalSetting.rebuild(
                              (b) => b..preferredLaunchNavTab = launchPage));
                        },
                      )
                  ],
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  '各页面默认分组',
                  style: Theme.of(context)
                      .textTheme
                      .body2
                      .copyWith(color: lightPrimaryDarkAccentColor(context)),
                ),
              ),
              ThemeWithTransparentDivider(
                child: ExpansionTile(
                  key: PageStorageKey<String>(
                      'general-setting-launch-preferredTimelineLaunchPage'),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('时间线默认显示'),
                      ),
                      Text(vm.generalSetting.preferredTimelineLaunchPage
                          .chineseName),
                    ],
                  ),
                  children: <Widget>[
                    for (TimelineCategoryFilter launchPage
                        in TimelineCategoryFilter.values.toList())
                      ListTile(
                        title: Text(launchPage.chineseName),
                        trailing: buildTrailingIcon<TimelineCategoryFilter>(
                            context,
                            vm.generalSetting.preferredTimelineLaunchPage,
                            launchPage),
                        onTap: () {
                          vm.updateGeneralSetting(vm.generalSetting.rebuild(
                              (b) =>
                                  b..preferredTimelineLaunchPage = launchPage));
                        },
                      )
                  ],
                ),
              ),
              Divider(),
              ThemeWithTransparentDivider(
                child: ExpansionTile(
                  key: PageStorageKey<String>(
                      'general-setting-launch-preferredProgressLaunchPage'),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('进度页默认显示'),
                      ),
                      Text(vm.generalSetting.preferredProgressLaunchPage
                          .chineseName),
                    ],
                  ),
                  children: <Widget>[
                    for (GetProgressRequest launchPage
                        in GetProgressRequest.validGetProgressRequests)
                      ListTile(
                        title: Text(launchPage.chineseName),
                        trailing: buildTrailingIcon<GetProgressRequest>(
                            context,
                            vm.generalSetting.preferredProgressLaunchPage,
                            launchPage),
                        onTap: () {
                          vm.updateGeneralSetting(vm.generalSetting.rebuild(
                              (b) => b
                                ..preferredProgressLaunchPage
                                    .replace(launchPage)));
                        },
                      )
                  ],
                ),
              ),
              Divider(),
              ThemeWithTransparentDivider(
                child: ExpansionTile(
                  key: PageStorageKey<String>(
                      'general-setting-launch-preferredDiscussionLaunchPage'),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('讨论页默认显示'),
                      ),
                      Text(vm.generalSetting.preferredDiscussionLaunchPage
                          .discussionFilter.chineseName),
                    ],
                  ),
                  children: <Widget>[
                    for (GetDiscussionRequest launchPage
                        in GetDiscussionRequest.validGetDiscussionRequests)
                      ListTile(
                        title: Text(launchPage.discussionFilter.chineseName),
                        trailing: buildTrailingIcon<GetDiscussionRequest>(
                            context,
                            vm.generalSetting.preferredDiscussionLaunchPage,
                            launchPage),
                        onTap: () {
                          vm.updateGeneralSetting(vm.generalSetting.rebuild(
                              (b) => b
                                ..preferredDiscussionLaunchPage
                                    .replace(launchPage)));
                        },
                      )
                  ],
                ),
              ),
              Divider(),
              ListTile(
                subtitle: Text(
                  '可以点击时间线，进度或讨论顶部导航条中间的长方形按钮来随时在各个分组间切换',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final Function(GeneralSetting setting) updateGeneralSetting;
  final GeneralSetting generalSetting;

  factory _ViewModel.fromStore(Store<AppState> store) {
    _updateGeneralSetting(GeneralSetting setting) {
      store.dispatch(UpdateGeneralSettingAction(generalSetting: setting));
      store.dispatch(PersistAppStateAction(basicAppStateOnly: true));
    }

    return _ViewModel(
        generalSetting: store.state.settingState.generalSetting,
        updateGeneralSetting: _updateGeneralSetting);
  }

  const _ViewModel({
    @required this.updateGeneralSetting,
    @required this.generalSetting,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          generalSetting == other.generalSetting;

  @override
  int get hashCode => generalSetting.hashCode;
}
