import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/setting/general/GeneralSetting.dart';
import 'package:munin/models/bangumi/setting/privacy/PrivacySetting.dart';
import 'package:munin/models/bangumi/setting/theme/MuninTheme.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/widgets/home/MuninHomePage.dart';
import 'package:munin/widgets/initial/MuninLoginPage.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

class MainMaterialApp extends StatelessWidget {
  final FirebaseAnalytics analytics;

  const MainMaterialApp({Key key, @required this.analytics});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel(
        muninTheme: store.state.settingState.themeSetting.currentTheme,
        isAuthenticated: store.state.isAuthenticated,
        generalSetting: store.state.settingState.generalSetting,
        privacySetting: store.state.settingState.privacySetting,
      ),
      distinct: true,
      builder: (BuildContext context, _ViewModel vm) {
        return MaterialApp(
          theme: vm.muninTheme.themeData,
          home: vm.isAuthenticated
              ? MuninHomePage(
                  generalSetting: vm.generalSetting,
                )
              : MuninLoginPage(),
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: analytics),
          ],
          onGenerateRoute: Application.router.generator,
        );
      },
    );
  }
}

class _ViewModel {
  final MuninTheme muninTheme;
  final bool isAuthenticated;
  final GeneralSetting generalSetting;
  final PrivacySetting privacySetting;

  const _ViewModel({
    @required this.muninTheme,
    @required this.isAuthenticated,
    @required this.generalSetting,
    @required this.privacySetting,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          muninTheme == other.muninTheme &&
          isAuthenticated == other.isAuthenticated &&
          generalSetting == other.generalSetting &&
          privacySetting == other.privacySetting;

  @override
  int get hashCode =>
      hash4(muninTheme, isAuthenticated, generalSetting, privacySetting);
}
