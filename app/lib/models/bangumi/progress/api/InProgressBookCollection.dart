import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/progress/common/InProgressCollection.dart';
import 'package:munin/models/bangumi/progress/common/InProgressSubjectInfo.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'InProgressBookCollection.g.dart';

abstract class InProgressBookCollection
    implements
        Built<InProgressBookCollection, InProgressBookCollectionBuilder>,
        InProgressCollection {
  InProgressBookCollection._();

  factory InProgressBookCollection(
          [updates(InProgressBookCollectionBuilder b)]) =
      _$InProgressBookCollection;

  /// Total number of episodes user has read/watched so far
  @BuiltValueField(wireName: 'ep_status')
  int get completedEpisodesCount;

  /// Total number of volumes user has read so far
  /// This value is only valid for books, for other types of subjects, api always
  /// returns 0
  @BuiltValueField(wireName: 'vol_status')
  int get completedVolumesCount;

  String toJson() {
    return json.encode(
        serializers.serializeWith(InProgressBookCollection.serializer, this));
  }

  static InProgressBookCollection fromJson(String jsonString) {
    return serializers.deserializeWith(
        InProgressBookCollection.serializer, json.decode(jsonString));
  }

  static Serializer<InProgressBookCollection> get serializer =>
      _$inProgressBookCollectionSerializer;
}
