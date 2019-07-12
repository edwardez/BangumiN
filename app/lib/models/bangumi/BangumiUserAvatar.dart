import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'BangumiUserAvatar.g.dart';

abstract class BangumiUserAvatar
    implements Built<BangumiUserAvatar, BangumiUserAvatarBuilder> {
  static const _defaultLargeIconProtocolLessUrl =
      'lain.bgm.tv/pic/user/l/icon.jpg';

  BangumiUserAvatar._();

  factory BangumiUserAvatar([updates(BangumiUserAvatarBuilder b)]) =
  _$BangumiUserAvatar;

  @BuiltValueField(wireName: 'large')
  String get large;

  @BuiltValueField(wireName: 'medium')
  String get medium;

  @BuiltValueField(wireName: 'small')
  String get small;

  bool get isUsingDefaultAvatar {
    if (large.contains(_defaultLargeIconProtocolLessUrl)) {
      return true;
    }

    return false;
  }

  String toJson() {
    return json
        .encode(serializers.serializeWith(BangumiUserAvatar.serializer, this));
  }

  static BangumiUserAvatar fromJson(String jsonString) {
    return serializers.deserializeWith(
        BangumiUserAvatar.serializer, json.decode(jsonString));
  }

  static Serializer<BangumiUserAvatar> get serializer =>
      _$bangumiUserAvatarSerializer;
}
