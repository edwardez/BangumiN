import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/progress/api/EpisodeProgress.dart';
import 'package:munin/models/bangumi/progress/common/InProgressCollection.dart';
import 'package:munin/models/bangumi/progress/common/InProgressSubjectInfo.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'InProgressAnimeOrRealCollection.g.dart';

abstract class InProgressAnimeOrRealCollection
    implements
        Built<InProgressAnimeOrRealCollection,
            InProgressAnimeOrRealCollectionBuilder>,
        InProgressCollection {
  InProgressAnimeOrRealCollection._();

  factory InProgressAnimeOrRealCollection(
          [updates(InProgressAnimeOrRealCollectionBuilder b)]) =
      _$InProgressAnimeOrRealCollection;

  /// Total number of episodes user has read/watched so far
  @BuiltValueField(wireName: 'ep_status')
  int get completedEpisodesCount;

  /// This value is initialized in a different api call, hence null during initial
  /// construction
  @nullable
  BuiltMap<int, EpisodeProgress> get episodes;

  String toJson() {
    return json.encode(serializers.serializeWith(
        InProgressAnimeOrRealCollection.serializer, this));
  }

  static InProgressAnimeOrRealCollection fromJson(String jsonString) {
    return serializers.deserializeWith(
        InProgressAnimeOrRealCollection.serializer, json.decode(jsonString));
  }

  static Serializer<InProgressAnimeOrRealCollection> get serializer =>
      _$inProgressAnimeOrRealCollectionSerializer;
}
