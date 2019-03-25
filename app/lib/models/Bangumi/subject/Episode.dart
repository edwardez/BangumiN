import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'Episode.g.dart';

abstract class Episode implements Built<Episode, EpisodeBuilder> {
  Episode._();

  factory Episode([updates(EpisodeBuilder b)]) = _$Episode;

  @BuiltValueField(wireName: 'id')
  int get id;

  @BuiltValueField(wireName: 'url')
  String get url;

  @BuiltValueField(wireName: 'type')
  int get type;

  @BuiltValueField(wireName: 'sort')
  int get sort;

  @BuiltValueField(wireName: 'name')
  String get name;

  @BuiltValueField(wireName: 'name_cn')
  String get nameCn;

  @BuiltValueField(wireName: 'duration')
  String get duration;

  @BuiltValueField(wireName: 'airdate')
  String get airDate;

  @BuiltValueField(wireName: 'comment')
  int get comment;

  @BuiltValueField(wireName: 'desc')
  String get summary;

  @BuiltValueField(wireName: 'status')
  String get status;

  String toJson() {
    return json.encode(serializers.serializeWith(Episode.serializer, this));
  }

  static Episode fromJson(String jsonString) {
    return serializers.deserializeWith(
        Episode.serializer, json.decode(jsonString));
  }

  static Serializer<Episode> get serializer => _$episodeSerializer;
}
