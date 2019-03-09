import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/redux/app/AppActions.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/widgets/shared/link/LinkTextSpan.dart';

class MuninLoginPage extends StatefulWidget {
  MuninLoginPage({Key key}) : super(key: key);

  @override
  _MuninLoginPageState createState() => _MuninLoginPageState();
}

class _MuninLoginPageState extends State<MuninLoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _buildTosAndPrivacy(BuildContext context) {
    final linkStyle = TextStyle(color: Theme.of(context).primaryColor);
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black),
        children: <TextSpan>[
          TextSpan(text: '点击授权即代表您同意我们的'),
          LinkTextSpan(
              text: '服务条款', style: linkStyle, url: "https://bangumin.app/tos"),
          TextSpan(text: '和'),
          LinkTextSpan(
              text: '隐私政策',
              style: linkStyle,
              url: "https://bangumin.app/privacy"),
        ],
      ),
    );
  }

  Widget _buildLoginPage(_ViewModel vm) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text("(Welcome Animation here)"),
              ),
              flex: 4,
            ),
            Expanded(
              child: Column(children: <Widget>[
                Row(children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      onPressed: vm.onLoginPressed,
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        '开始授权',
                        // TODO: set a theme-awareness text color(bypass ButtonTextTheme)
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ]),
                _buildTosAndPrivacy(context),
              ]),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: (store) {
        return _ViewModel(
          appState: store.state,
          onLoginPressed: () => store.dispatch(OAuthLoginRequest(context)),
        );
      },
      builder: (BuildContext context, _ViewModel vm) => _buildLoginPage(vm),
    );
  }
}

class _ViewModel {
  final AppState appState;
  final void Function() onLoginPressed;

  _ViewModel({this.appState, this.onLoginPressed});
}
