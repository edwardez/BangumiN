import 'package:built_value/built_value.dart';
import 'package:munin/models/Bangumi/BangumiUserBaic.dart';

part 'AppState.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  @nullable
  BangumiUserBasic get currentAuthenticatedUserBasicInfo;

  bool get isAuthenticated;

  factory AppState([updates(AppStateBuilder b)]) = _$AppState;

  AppState._();
}
