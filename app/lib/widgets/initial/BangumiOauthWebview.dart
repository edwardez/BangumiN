import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:munin/config/application.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/oauth/OauthActions.dart';
import 'package:redux/redux.dart';

class BangumiOauthWebview extends StatelessWidget {
  Future<bool> _onGoBackPressed(
      Store<AppState> store, BuildContext context) async {
    store.dispatch(OAuthLoginCancel(context));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final String host = Application.environmentValue.bangumiNonCdnHost;
    final String clientId =
        Application.environmentValue.bangumiOauthClientIdentifier;
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) {
        return _ViewModel(
          onGoBackPressed: () => _onGoBackPressed(store, context),
        );
      },
      builder: (BuildContext context, _ViewModel vm) {
        return WillPopScope(
            onWillPop: vm.onGoBackPressed,
            child: WebviewScaffold(
              hidden: true,
              clearCookies: true,
              url:
                  'https://$host/oauth/authorize?response_type=code&client_id=$clientId',
              appBar: new AppBar(
                title: new Text("完成授权"),
                elevation: 4.0,
              ),
            ));
      },
    );
  }
}

class _ViewModel {
  final Future<bool> Function() onGoBackPressed;

  _ViewModel({this.onGoBackPressed});
}
