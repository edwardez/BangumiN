import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/BangumiUserSmall.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'MutedUser.g.dart';

abstract class MutedUser implements Built<MutedUser, MutedUserBuilder> {
  MutedUser._();

  String get username;

  @nullable
  int get userId;

  String get nickname;

  /// Currently not in use and not properly populated
  @nullable
  BangumiImage get userAvatar;

  bool get isImportedFromBangumi;

  factory MutedUser([updates(MutedUserBuilder b)]) =>
      _$MutedUser((b) => b..update(updates));

  factory MutedUser.fromBangumiUserSmall(BangumiUserSmall bangumiUserSmall) {
    return MutedUser((b) => b
      ..username = bangumiUserSmall.username
      ..userId = bangumiUserSmall.id
      ..nickname = bangumiUserSmall.nickname
      ..isImportedFromBangumi = false
      ..userAvatar.replace(
          BangumiImage.fromBangumiUserAvatar(bangumiUserSmall.avatar)));
  }

  String toJson() {
    return json.encode(serializers.serializeWith(MutedUser.serializer, this));
  }

  static MutedUser fromJson(String jsonString) {
    return serializers.deserializeWith(
        MutedUser.serializer, json.decode(jsonString));
  }

  static Serializer<MutedUser> get serializer => _$mutedUserSerializer;
}
