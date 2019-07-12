import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'OauthState.g.dart';

abstract class OauthState implements Built<OauthState, OauthStateBuilder> {
  @nullable
  bool get showLoginErrorSnackBar;

  @nullable
  String get oauthFailureMessage;

  @nullable
  String get error;

  OauthState._();

  factory OauthState([updates(OauthStateBuilder b)]) =>
      _$OauthState((b) => b..update(updates));

  String toJson() {
    return json.encode(serializers.serializeWith(OauthState.serializer, this));
  }

  static OauthState fromJson(String jsonString) {
    return serializers.deserializeWith(
        OauthState.serializer, json.decode(jsonString));
  }

  static Serializer<OauthState> get serializer => _$oauthStateSerializer;
}
