import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/setting/MuninTheme.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/widgets/home/MuninHomePage.dart';
import 'package:munin/widgets/initial/MuninLoginPage.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

class MainMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel(
          muninTheme: store.state.settingState.themeSetting.currentTheme,
          isAuthenticated: store.state.isAuthenticated),
      distinct: true,
      builder: (BuildContext context, _ViewModel vm) {
        return MaterialApp(
          theme: vm.muninTheme.themeData,
          home: vm.isAuthenticated ? MuninHomePage() : MuninLoginPage(),
          onGenerateRoute: Application.router.generator,
        );
      },
    );
  }
}

class _ViewModel {
  final MuninTheme muninTheme;
  final bool isAuthenticated;

  _ViewModel({
    @required this.muninTheme,
    @required this.isAuthenticated,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          muninTheme == other.muninTheme &&
          isAuthenticated == other.isAuthenticated;

  @override
  int get hashCode => hash2(muninTheme.hashCode, isAuthenticated.hashCode);
}
