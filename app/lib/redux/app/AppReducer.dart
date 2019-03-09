import 'package:munin/redux/app/AppActions.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:redux/redux.dart';

final appReducers = combineReducers<AppState>([
  TypedReducer<AppState, OAuthLoginSuccess>(oauthLoginSuccessReducer),
  TypedReducer<AppState, LogoutSuccess>(logoutSuccessReducer),
]);

AppState oauthLoginSuccessReducer(
    AppState appState, OAuthLoginSuccess oAuthLoginSuccess) {
  return appState.rebuild((b) => b
    ..currentAuthenticatedUserBasicInfo.replace(oAuthLoginSuccess.userInfo)
    ..isAuthenticated = true);
}

AppState logoutSuccessReducer(
    AppState appState, LogoutSuccess logoutSuccessReducer) {
  return AppState((b) => b..isAuthenticated = false);
}
