import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/BangumiUserBaic.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/setting/SettingState.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'BasicAppState.g.dart';

/// A minimum AppState derived from [AppState].
/// It's used in case breaking changes are introduced to AppState, some basic(but
/// most important) app state info can still be restored
abstract class BasicAppState
    implements Built<BasicAppState, BasicAppStateBuilder> {
  /// If [currentAuthenticatedUserBasicInfo] can be restores we assume user
  /// exists, thus `currentAuthenticatedUserBasicInfo` is not nullable here
  BangumiUserBasic get currentAuthenticatedUserBasicInfo;

  bool get isAuthenticated;

  SettingState get settingState;

  factory BasicAppState([updates(BasicAppStateBuilder b)]) =>
      _$BasicAppState((b) => b
        ..isAuthenticated = false
        ..settingState.replace(SettingState())
        ..update(updates));

  BasicAppState._();

  String toJson() {
    return json
        .encode(serializers.serializeWith(BasicAppState.serializer, this));
  }

  static BasicAppState fromJson(String jsonString) {
    return serializers.deserializeWith(
        BasicAppState.serializer, json.decode(jsonString));
  }

  static Serializer<BasicAppState> get serializer => _$basicAppStateSerializer;
}