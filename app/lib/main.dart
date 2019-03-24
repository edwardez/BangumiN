import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/config/application.dart';
import 'package:munin/config/development.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/router/routes.dart';
import 'package:munin/styles/theme/BangumiPinkBlue.dart';
import 'package:munin/widgets/home/MuninHomePage.dart';
import 'package:munin/widgets/initial/MuninLoginPage.dart';
import 'package:redux/redux.dart';

void main() {
  Development();
}

class MuninApp extends StatefulWidget {
  final Application application;
  final Store<AppState> store;

  MuninApp(this.application, this.store);

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
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
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
        onGenerateRoute: Application.router.generator,
      ),
    );
  }
}
