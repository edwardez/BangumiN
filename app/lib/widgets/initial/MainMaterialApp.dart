import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/setting/general/GeneralSetting.dart';
import 'package:munin/models/bangumi/setting/privacy/PrivacySetting.dart';
import 'package:munin/models/bangumi/setting/theme/ThemeSetting.dart';
import 'package:munin/models/bangumi/setting/theme/ThemeSwitchMode.dart';
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
        themeSetting: store.state.settingState.themeSetting,
        isAuthenticated: store.state.isAuthenticated,
        generalSetting: store.state.settingState.generalSetting,
        privacySetting: store.state.settingState.privacySetting,
      ),
      distinct: true,
      builder: (BuildContext context, _ViewModel vm) {
        final shouldFollowSystemBrightness = vm.themeSetting.themeSwitchMode ==
            ThemeSwitchMode.FollowSystemThemeSetting;

        return MaterialApp(
          theme: shouldFollowSystemBrightness
              ? vm.themeSetting.preferredFollowSystemLightTheme.themeData
              : vm.themeSetting.currentTheme.themeData,
          darkTheme: shouldFollowSystemBrightness
              ? vm.themeSetting.preferredFollowSystemDarkTheme.themeData
              : null,
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
  final ThemeSetting themeSetting;
  final bool isAuthenticated;
  final GeneralSetting generalSetting;
  final PrivacySetting privacySetting;

  const _ViewModel({
    @required this.themeSetting,
    @required this.isAuthenticated,
    @required this.generalSetting,
    @required this.privacySetting,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is _ViewModel &&
              runtimeType == other.runtimeType &&
              themeSetting == other.themeSetting &&
              isAuthenticated == other.isAuthenticated &&
          generalSetting == other.generalSetting &&
          privacySetting == other.privacySetting;

  @override
  int get hashCode =>
      hash4(themeSetting, isAuthenticated, generalSetting, privacySetting);
}
