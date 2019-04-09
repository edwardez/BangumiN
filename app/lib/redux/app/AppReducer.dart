import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/oauth/OauthActions.dart';
import 'package:munin/redux/oauth/OauthReducer.dart';
import 'package:munin/redux/search/SearchReducer.dart';
import 'package:munin/redux/subject/SubjectReducer.dart';
import 'package:munin/redux/timeline/TimelineReducer.dart';

// We create the State reducer by combining many smaller reducers into one!
AppState appReducer(AppState appState, dynamic action) {
  if (action is OAuthLoginSuccess) {
    return appState.rebuild((b) =>
    b
      ..currentAuthenticatedUserBasicInfo.replace(action.userInfo)
      ..isAuthenticated = true);
  } else if (action is LogoutSuccess) {
    return AppState((b) => b..isAuthenticated = false);
  }

  return appState.rebuild(
          (b) =>
      b
        ..oauthState.replace(oauthReducers(appState.oauthState, action))
        ..timelineState.replace(
            timelineReducers(appState.timelineState, action))
        ..subjectState.replace(
            subjectReducers(appState.subjectState, action))
        ..searchState.replace(
            searchReducers(appState.searchState, action))
  )
  ;
}
