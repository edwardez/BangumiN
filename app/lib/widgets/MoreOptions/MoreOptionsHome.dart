import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/redux/app/AppActions.dart';
import 'package:munin/redux/app/AppState.dart';

class MoreOptionsHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: (store) {
        return _ViewModel(
          appState: store.state,
          onLoginOutPressed: () => store.dispatch(LogoutRequest(context)),
        );
      },
      builder: (BuildContext context, _ViewModel vm) {
        return _buildMoreOptionsPage(context, vm);
      },
    );
  }

  Widget _buildMoreOptionsPage(BuildContext context, _ViewModel vm) {
    return Scaffold(
      appBar: AppBar(
        title: Text("账户"),
        elevation: 0.5,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('设置'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('帮助'),
          ),
          ListTile(
            leading: Icon(Icons.feedback),
            title: Text('反馈'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text('退出登录'),
            onTap: vm.onLoginOutPressed,
          ),
        ],
      ),
    );
  }
}

class _ViewModel {
  final AppState appState;
  final void Function() onLoginOutPressed;

  _ViewModel({this.appState, this.onLoginOutPressed});
}
