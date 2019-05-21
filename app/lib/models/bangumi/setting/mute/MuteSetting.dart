import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/setting/mute/MutedGroup.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'MuteSetting.g.dart';

abstract class MuteSetting implements Built<MuteSetting, MuteSettingBuilder> {
  MuteSetting._();

  BuiltMap<String, MutedUser> get mutedUsers;

  BuiltMap<String, MutedGroup> get mutedGroups;

  /// Whether user chooses to mute original poster with default icon
  /// `op` is short for eOriginalPoster
  bool get muteOriginalPosterWithDefaultIcon;

  @nullable
  BuiltMap<String, MutedUser> get importedBangumiBlockedUsers;

  factory MuteSetting([updates(MuteSettingBuilder b)]) => _$MuteSetting((b) => b
    ..mutedUsers.replace(BuiltMap<String, MutedUser>())
    ..mutedGroups.replace(BuiltMap<String, MutedGroup>())
    ..muteOriginalPosterWithDefaultIcon = false
    ..update(updates));

  String toJson() {
    return json.encode(serializers.serializeWith(MuteSetting.serializer, this));
  }

  static MuteSetting fromJson(String jsonString) {
    return serializers.deserializeWith(
        MuteSetting.serializer, json.decode(jsonString));
  }

  static Serializer<MuteSetting> get serializer => _$muteSettingSerializer;
}
