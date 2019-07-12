import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/setting/privacy/PrivacySetting.dart';
import 'package:munin/redux/app/AppActions.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/setting/SettingActions.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/common/MuninPadding.dart';
import 'package:munin/widgets/shared/common/ScrollViewWithSliverAppBar.dart';
import 'package:munin/widgets/shared/link/LinkTextSpan.dart';
import 'package:redux/redux.dart';

class PrivacySettingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      distinct: true,
      onDispose: (store) {
        store.dispatch(ImportBlockedBangumiUsersCleanupAction());
        store.dispatch(PersistAppStateAction(basicAppStateOnly: true));
      },
      builder: (BuildContext context, _ViewModel vm) {
        return ScrollViewWithSliverAppBar(
            enableTopSafeArea: false,
            enableBottomSafeArea: false,
            safeAreaChildPadding:
                const EdgeInsets.only(left: 0, right: 0, top: largeOffset),
            appBarMainTitle: Text(
              '隐私',
            ),
            nestedScrollViewBody: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                SwitchListTile.adaptive(
                  value: vm.privacySetting.optInAnalytics,
                  onChanged: (bool newValue) {
                    vm.updatePrivacySetting(vm.privacySetting.rebuild((b) =>
                        b..optInAnalytics = !vm.privacySetting.optInAnalytics));
                  },
                  activeColor: lightPrimaryDarkAccentColor(context),
                  title: Text('发送匿名统计数据'),
                ),
                Divider(),
                SwitchListTile.adaptive(
                  value: vm.privacySetting.optInAutoSendCrashReport,
                  onChanged: (bool newValue) {
                    vm.updatePrivacySetting(vm.privacySetting.rebuild((b) => b
                      ..optInAutoSendCrashReport =
                          !vm.privacySetting.optInAutoSendCrashReport));
                  },
                  activeColor: lightPrimaryDarkAccentColor(context),
                  title: Text('崩溃后自动发送匿名崩溃报告'),
                ),
                MuninPadding.vertical1xOffset(
                  child: RichText(
                    text: TextSpan(
                      style: defaultCaptionText(context),
                      children: <TextSpan>[
                        TextSpan(text: '隐私设置变更在重启应用后生效。\n'),
                        TextSpan(text: '欲了解更多详情，请参阅BangumiN的'),
                        ...tosAndPrivacyLinks(context),
                        TextSpan(text: '。'),
                      ],
                    ),
                  ),
                  denseHorizontal: true,
                )
              ],
            ));
      },
    );
  }
}

class _ViewModel {
  final PrivacySetting privacySetting;
  final void Function(PrivacySetting privacySetting, {bool persisToDisk})
      updatePrivacySetting;

  factory _ViewModel.fromStore(Store<AppState> store) {
    _updatePrivacySetting(
      PrivacySetting privacySetting, {
      persisToDisk = true,
    }) {
      store
          .dispatch(UpdatePrivacySettingAction(privacySetting: privacySetting));
      if (persisToDisk) {
        store.dispatch(PersistAppStateAction(basicAppStateOnly: true));
      }
    }

    return _ViewModel(
      privacySetting:
          store.state.settingState.privacySetting ?? PrivacySetting(),
      updatePrivacySetting: _updatePrivacySetting,
    );
  }

  _ViewModel({
    @required this.privacySetting,
    @required this.updatePrivacySetting,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          privacySetting == other.privacySetting;

  @override
  int get hashCode => privacySetting.hashCode;
}

List<TextSpan> tosAndPrivacyLinks(BuildContext context) {
  final linkStyle = TextStyle(color: lightPrimaryDarkAccentColor(context));
  return [
    LinkTextSpan(
        text: '服务条款', style: linkStyle, url: "https://bangumin.app/tos"),
    TextSpan(text: '和'),
    LinkTextSpan(
        text: '隐私政策', style: linkStyle, url: "https://bangumin.app/privacy"),
  ];
}
