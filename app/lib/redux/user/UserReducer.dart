import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/redux/user/UserActions.dart';
import 'package:munin/redux/user/UserState.dart';
import 'package:redux/redux.dart';

final userReducers = combineReducers<UserState>([
  TypedReducer<UserState, GetUserPreviewSuccessAction>(
      fetchUserPreviewSuccessReducer),
]);

UserState fetchUserPreviewSuccessReducer(UserState userState,
    GetUserPreviewSuccessAction fetchUserPreviewSuccessAction) {
  UserProfile profile = fetchUserPreviewSuccessAction.profile;
  String username = profile.basicInfo.username;
  return userState.rebuild(
        (b) => b..profiles.addAll({username: profile}),
  );
}
