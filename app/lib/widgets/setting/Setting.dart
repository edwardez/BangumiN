import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/oauth/OauthActions.dart';
import 'package:munin/redux/setting/SettingState.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/setting/theme/ThemeSettingWidget.dart';
import 'package:munin/widgets/shared/common/ScaffoldWithSliverAppBar.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';

class SettingHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) {
        return _ViewModel(
          settingState: store.state.settingState,
          onLoginOutPressed: () => store.dispatch(LogoutRequest(context)),
        );
      },
      distinct: true,
      builder: (BuildContext context, _ViewModel vm) {
        return _buildMoreOptionsPage(context, vm);
      },
    );
  }

  Widget _buildMoreOptionsPage(BuildContext context, _ViewModel vm) {
    return ScaffoldWithSliverAppBar(
      appBarMainTitle: Text("设置"),
      enableBottomSafeArea: false,
      safeAreaChildPadding:
          const EdgeInsets.only(left: 0, right: 0, top: largeVerticalPadding),
      nestedScrollViewBody: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('主题'),
              trailing: Icon(
                AdaptiveIcons.forwardIconData,
                size: smallerIconSize,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThemeSettingWidget()),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text('帮助'),
            ),
            ListTile(
              title: Text('反馈'),
            ),
            Divider(),
            ListTile(
              title: Text('退出登录'),
              onTap: vm.onLoginOutPressed,
            ),
          ],
        ),
      ),
    );
  }
}

class _ViewModel {
  final SettingState settingState;
  final void Function() onLoginOutPressed;

  _ViewModel({this.settingState, this.onLoginOutPressed});
}
