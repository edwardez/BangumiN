import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'UserState.g.dart';

abstract class UserState implements Built<UserState, UserStateBuilder> {
  /// A [BuiltMap] of user profiles with username as key
  BuiltMap<String, UserProfile> get profiles;

  factory UserState([updates(UserStateBuilder b)]) => _$UserState((b) => b
    ..profiles.replace(BuiltMap<String, UserProfile>())
    ..update(updates));

  UserState._();

  String toJson() {
    return json.encode(serializers.serializeWith(UserState.serializer, this));
  }

  static UserState fromJson(String jsonString) {
    return serializers.deserializeWith(
        UserState.serializer, json.decode(jsonString));
  }

  static Serializer<UserState> get serializer => _$userStateSerializer;
}
