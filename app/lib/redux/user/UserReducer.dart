import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';
import 'package:munin/redux/user/UserActions.dart';
import 'package:munin/redux/user/UserState.dart';
import 'package:redux/redux.dart';

final userReducers = combineReducers<UserState>([
  TypedReducer<UserState, FetchUserPreviewLoadingAction>(
      fetchUserPreviewLoadingReducer),
  TypedReducer<UserState, FetchUserPreviewSuccessAction>(
      fetchUserPreviewSuccessReducer),
  TypedReducer<UserState, FetchUserPreviewFailureAction>(
      fetchUserPreviewFailureReducer),
]);

UserState fetchUserPreviewLoadingReducer(
    UserState userState, FetchUserPreviewLoadingAction action) {
  return userState.rebuild((b) => b
    ..profilesLoadingStatus.addAll({action.username: LoadingStatus.Loading}));
}

UserState fetchUserPreviewSuccessReducer(UserState userState,
    FetchUserPreviewSuccessAction fetchUserPreviewSuccessAction) {
  UserProfile profile = fetchUserPreviewSuccessAction.profile;
  String username = profile.basicInfo.username;
  return userState.rebuild((b) => b
    ..profiles.addAll({username: profile})
    ..profilesLoadingStatus.addAll({username: LoadingStatus.Success}));
}

UserState fetchUserPreviewFailureReducer(
    UserState userState, FetchUserPreviewFailureAction action) {
  return userState.rebuild((b) =>
      b..profilesLoadingStatus.addAll({action.username: action.loadingStatus}));
}
