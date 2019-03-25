import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/Bangumi/mono/MonoBase.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'Actor.g.dart';

abstract class Actor implements Built<Actor, ActorBuilder>, MonoBase {
  Actor._();

  factory Actor([updates(ActorBuilder b)]) = _$Actor;

  static Actor fromJson(String jsonString) {
    return serializers.deserializeWith(
        Actor.serializer, json.decode(jsonString));
  }

  static Serializer<Actor> get serializer => _$actorSerializer;
}
