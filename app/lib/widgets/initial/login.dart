import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:munin/blocs/authentication/authentication.dart';
import 'package:munin/blocs/login/login.dart';
import 'package:munin/widgets/shared/link/LinkTextSpan.dart';

class MuninLoginPage extends StatefulWidget {
  MuninLoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MuninLoginPageState createState() => _MuninLoginPageState();
}

class _MuninLoginPageState extends State<MuninLoginPage> {
  LoginBloc _loginBloc;
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = LoginBloc(authenticationBloc: _authenticationBloc);
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  logBrowser() async {
    final flutterWebviewPlugin = new FlutterWebviewPlugin();
    await flutterWebviewPlugin.show();
    flutterWebviewPlugin.onUrlChanged.listen((String url) async {
      if (url == null) return;

      if (url.contains('bgm.tv/anime')) {
        print(await flutterWebviewPlugin.getCookies());
        print(await flutterWebviewPlugin.evalJavascript('navigator.userAgent'));
        flutterWebviewPlugin.close();
        flutterWebviewPlugin.dispose();
        _loginBloc.dispatch(LoginButtonPressed());
      }
    });
  }

  _onLoginPressed() {
    logBrowser();

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => new WebviewScaffold(
                url: "https://bgm.tv",
                appBar: new AppBar(
                  title: new Text("完成授权"),
                ),
                initialChild: Container(
                  child: const Center(
                    child: Text('Waiting.....'),
                  ),
                ),
              )),
    );
    _loginBloc.dispatch(LoginButtonPressed());
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

  @override
  Widget build(BuildContext context) {
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
                      onPressed: _onLoginPressed,
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
}
