import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionRequest.dart';
import 'package:munin/models/bangumi/progress/common/GetProgressRequest.dart';
import 'package:munin/models/bangumi/setting/general/GeneralSetting.dart';
import 'package:munin/models/bangumi/setting/general/PreferredLaunchNavTab.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineCategoryFilter.dart';
import 'package:munin/redux/app/AppActions.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/setting/SettingActions.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/setting/general/PreferredLanguageWidget.dart';
import 'package:munin/widgets/shared/common/ScrollViewWithSliverAppBar.dart';
import 'package:munin/widgets/shared/selection/MuninExpansionSelection.dart';
import 'package:redux/redux.dart';

class GeneralSettingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      distinct: true,
      builder: (BuildContext context, _ViewModel vm) {
        return ScrollViewWithSliverAppBar(
          enableTopSafeArea: false,
          enableBottomSafeArea: false,
          safeAreaChildPadding:
              const EdgeInsets.only(left: 0, right: 0, top: largeOffset),
          appBarMainTitle: Text('通用设置'),
          nestedScrollViewBody: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                title: Text(
                  '语言',
                  style: Theme.of(context)
                      .textTheme
                      .body2
                      .copyWith(color: lightPrimaryDarkAccentColor(context)),
                ),
              ),
              PreferredLanguageWidget(
                currentSubjectLanguage:
                    vm.generalSetting.preferredSubjectInfoLanguage,
                onSubjectLanguageUpdate:
                    (PreferredSubjectInfoLanguage language) {
                  vm.updateGeneralSetting(vm.generalSetting.rebuild(
                      (b) => b..preferredSubjectInfoLanguage = language));
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  '进度',
                  style: Theme.of(context)
                      .textTheme
                      .body2
                      .copyWith(color: lightPrimaryDarkAccentColor(context)),
                ),
              ),
              SwitchListTile.adaptive(
                value: vm.generalSetting.expandAllProgressTiles,
                title: Text('展开所有在看作品的话数面板'),
                onChanged: (bool value) {
                  final currentValue = vm.generalSetting.expandAllProgressTiles;
                  vm.updateGeneralSetting(vm.generalSetting.rebuild(
                      (b) => b..expandAllProgressTiles = !currentValue));
                },
                activeColor: lightPrimaryDarkAccentColor(context),
              ),
              Divider(),
              ListTile(
                title: Text(
                  '启动',
                  style: Theme.of(context)
                      .textTheme
                      .body2
                      .copyWith(color: lightPrimaryDarkAccentColor(context)),
                ),
              ),
              MuninExpansionSelection<PreferredLaunchNavTab>(
                expansionKey: PageStorageKey<String>(
                    'general-setting-launch-preferredLaunchNavTab'),
                title: Text('启动后进入页面'),
                optionTitleBuilder: (selection) =>
                    Text(selection.generalSettingPageChineseName),
                options: PreferredLaunchNavTab.values,
                currentSelection: vm.generalSetting.preferredLaunchNavTab,
                onTapOption: (launchPage) {
                  vm.updateGeneralSetting(vm.generalSetting
                      .rebuild((b) => b..preferredLaunchNavTab = launchPage));
                },
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
              MuninExpansionSelection<TimelineCategoryFilter>(
                expansionKey: PageStorageKey<String>(
                    'general-setting-launch-preferredTimelineLaunchPage'),
                title: Text('时间线默认显示'),
                optionTitleBuilder: (selection) => Text(selection.chineseName),
                options: TimelineCategoryFilter.values,
                currentSelection: vm.generalSetting.preferredTimelineLaunchPage,
                onTapOption: (launchPage) {
                  vm.updateGeneralSetting(vm.generalSetting.rebuild(
                          (b) => b..preferredTimelineLaunchPage = launchPage));
                },
              ),
              Divider(),
              MuninExpansionSelection<GetProgressRequest>(
                expansionKey: PageStorageKey<String>(
                    'general-setting-launch-preferredProgressLaunchPage'),
                title: Text('进度页默认显示'),
                optionTitleBuilder: (selection) => Text(selection.chineseName),
                optionSubTitleBuilder: (launchPage) {
                  return launchPage == GetProgressRequest.allWatchable
                      ? Text('动画，三次元与书籍')
                      : null;
                },
                options: GetProgressRequest.validGetProgressRequests,
                currentSelection: vm.generalSetting.preferredProgressLaunchPage,
                onTapOption: (launchPage) {
                  vm.updateGeneralSetting(vm.generalSetting.rebuild((b) =>
                  b..preferredProgressLaunchPage.replace(launchPage)));
                },
              ),
              Divider(),
              MuninExpansionSelection<GetDiscussionRequest>(
                expansionKey: PageStorageKey<String>(
                    'general-setting-launch-preferredDiscussionLaunchPage'),
                title: Text('讨论页默认显示'),
                optionTitleBuilder: (selection) =>
                    Text(selection.discussionFilter.chineseName),
                options: GetDiscussionRequest.validGetDiscussionRequests,
                currentSelection:
                vm.generalSetting.preferredDiscussionLaunchPage,
                onTapOption: (launchPage) {
                  vm.updateGeneralSetting(vm.generalSetting.rebuild((b) =>
                  b..preferredDiscussionLaunchPage.replace(launchPage)));
                },
              ),
              Divider(),
              ListTile(
                subtitle: Text(
                  '可以点击时间线，进度或讨论顶部导航条中间的长方形按钮来随时在各个分组间切换',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 60),
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
