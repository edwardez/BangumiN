import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/oauth/OauthActions.dart';

class Logout extends StatelessWidget {
  _showLogoutWarningDialog(BuildContext context, _ViewModel vm) {
    showDialog(
        context: context,
        builder: (innerContext) {
          return AlertDialog(
            title: Text('确定要退出登录吗？'),
            content: Text('退出登录后所有设置和登陆信息都将被清空'),
            actions: <Widget>[
              FlatButton(
                child: Text('不退出'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('退出登录'),
                onPressed: () {
                  Navigator.pop(context);
                  vm.onLoginOutPressed();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) {
        return _ViewModel(
          onLoginOutPressed: () => store.dispatch(LogoutRequest(context)),
        );
      },
      distinct: true,
      builder: (BuildContext context, _ViewModel vm) {
        return ListTile(
          title: Text('退出登录'),
          onTap: () {
            _showLogoutWarningDialog(context, vm);
          },
        );
      },
    );
  }
}

class _ViewModel {
  final void Function() onLoginOutPressed;

  _ViewModel({this.onLoginOutPressed});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
