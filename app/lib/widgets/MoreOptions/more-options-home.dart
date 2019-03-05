import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:munin/blocs/authentication/authentication.dart';

class MoreOptionsHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("账户"),
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
            onTap: () {
              authenticationBloc.dispatch(LoggedOut());
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
