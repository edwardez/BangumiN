import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/config/development.dart';
import 'package:munin/config/environment.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/styles/theme/BangumiPinkBlue.dart';
import 'package:munin/widgets/home/MuninHomePage.dart';
import 'package:munin/widgets/initial/BangumiOauthWebview.dart';
import 'package:munin/widgets/initial/MuninLoginPage.dart';
import 'package:redux/redux.dart';

void main() {
  Development();
}

class MuninApp extends StatefulWidget {
  final Environment env;
  final Store<AppState> store;

  MuninApp(this.env, this.store);

  @override
  State<StatefulWidget> createState() {
    return _MuninAppState();
  }
}

class _MuninAppState extends State<MuninApp> {
  @override
  void initState() {
    // TODO: theme awareness
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
          theme: BangumiPinkBlue().data,
          home: widget.store.state.isAuthenticated
              ? MuninHomePage()
              : MuninLoginPage(),
          routes: {
            '/login': (context) => MuninLoginPage(),
            '/home': (context) => MuninHomePage(),
            '/bangumiOauth': (context) => BangumiOauthWebview(),
          }),
    );
  }
}
