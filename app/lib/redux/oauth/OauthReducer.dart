import 'package:munin/redux/oauth/OauthActions.dart';
import 'package:munin/redux/oauth/OauthState.dart';
import 'package:redux/redux.dart';

final oauthReducers = combineReducers<OauthState>([
  TypedReducer<OauthState, OAuthLoginFailure>(oAuthLoginFailureReducer),
]);

// TODO: figure out whether it's needed to reset error message
OauthState oAuthLoginFailureReducer(
    OauthState oauthState, OAuthLoginFailure oAuthLoginFailure) {
  return oauthState.rebuild((b) => b
    ..showLoginErrorSnackBar = true
    ..oauthFailureMessage = oAuthLoginFailure.message);
}
