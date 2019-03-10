import 'package:built_value/built_value.dart';
import 'package:munin/models/Bangumi/BangumiUserBaic.dart';
import 'package:munin/redux/oauth/OauthState.dart';

part 'AppState.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  @nullable
  BangumiUserBasic get currentAuthenticatedUserBasicInfo;

  bool get isAuthenticated;

  OauthState get oauthState;

  factory AppState([updates(AppStateBuilder b)]) =>
      _$AppState((b) =>
      b
        ..oauthState.replace(OauthState())
        ..update(updates));

  AppState._();
}
