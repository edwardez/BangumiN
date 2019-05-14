import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/oauth/OauthActions.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/link/LinkTextSpan.dart';

class MuninLoginPage extends StatefulWidget {
  MuninLoginPage({Key key}) : super(key: key);

  @override
  _MuninLoginPageState createState() => _MuninLoginPageState();
}

class _MuninLoginPageState extends State<MuninLoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _buildTosAndPrivacy(BuildContext context) {
    final linkStyle = TextStyle(color: lightPrimaryDarkAccentColor(context));
    return RichText(
      text: TextSpan(
        style: Theme
            .of(context)
            .textTheme
            .body1,
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

  Widget _buildLoginPage(BuildContext context, _ViewModel vm) {
    if (vm.appState?.oauthState?.showLoginErrorSnackBar == true) {
      vm.showErrorSnackBar(
          _scaffoldKey, vm.appState?.oauthState?.oauthFailureMessage ?? '未知错误');
    }

    return Scaffold(
      key: _scaffoldKey,
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
                      color: lightPrimaryDarkAccentColor(context),
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
      builder: (BuildContext context, _ViewModel vm) =>
          _buildLoginPage(context, vm),
    );
  }
}

class _ViewModel {
  final AppState appState;
  final void Function() onLoginPressed;

  _ViewModel({this.appState, this.onLoginPressed});

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  /// TODO: figure out a better way to show snack bar error message when use is navigated back to login page
  showErrorSnackBar(GlobalKey<ScaffoldState> _scaffoldKey, String message) {
    _onWidgetDidBuild(() {
      _scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(message),
      ));
    });
  }
}
