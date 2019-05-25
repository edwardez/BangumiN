import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/mono/Actor.dart';
import 'package:munin/models/bangumi/mono/MonoBase.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'Character.g.dart';

abstract class Character
    implements MonoBase, Built<Character, CharacterBuilder> {
  Character._();

  factory Character([updates(CharacterBuilder b)]) = _$Character;

  @BuiltValueField(wireName: 'name_cn')
  @nullable
  String get nameCn;

  @BuiltValueField(wireName: 'role_name')
  String get roleName;

  BangumiImage get avatar;

  @nullable
  @BuiltValueField(wireName: 'comment')
  int get commentCount;

  @nullable
  @BuiltValueField(wireName: 'collects')
  int get collectionCounts;

//  @BuiltValueField(wireName: 'info')
//  Info get info;

  @BuiltValueField(wireName: 'actors')
  BuiltList<Actor> get actors;

  String toJson() {
    return json.encode(serializers.serializeWith(Character.serializer, this));
  }

  static Character fromJson(String jsonString) {
    return serializers.deserializeWith(
        Character.serializer, json.decode(jsonString));
  }

  static Serializer<Character> get serializer => _$characterSerializer;
}
