import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/progress/html/SimpleHtmlEpisode.dart';
import 'package:munin/models/bangumi/subject/common/ParentSubject.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'SubjectEpisodes.g.dart';

/// All episodes of a subject, as seen on bangumi web page, like https://bgm.tv/subject/1836/ep.
abstract class SubjectEpisodes
    implements Built<SubjectEpisodes, SubjectEpisodesBuilder> {
  @nullable
  ParentSubject get subject;

  BuiltMap<int, SimpleHtmlEpisode> get episodes;

  SubjectEpisodes._();

  factory SubjectEpisodes([void Function(SubjectEpisodesBuilder) updates]) =
      _$SubjectEpisodes;

  String toJson() {
    return json
        .encode(serializers.serializeWith(SubjectEpisodes.serializer, this));
  }

  static SubjectEpisodes fromJson(String jsonString) {
    return serializers.deserializeWith(
        SubjectEpisodes.serializer, json.decode(jsonString));
  }

  static Serializer<SubjectEpisodes> get serializer =>
      _$subjectEpisodesSerializer;
}
