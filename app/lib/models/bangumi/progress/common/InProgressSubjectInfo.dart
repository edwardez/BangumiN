import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/models/bangumi/subject/common/SujectBase.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'InProgressSubjectInfo.g.dart';

abstract class InProgressSubjectInfo
    implements
        SubjectBase,
        Built<InProgressSubjectInfo, InProgressSubjectInfoBuilder> {
  SubjectType get type;

  @nullable
  @BuiltValueField(wireName: 'images')
  BangumiImage get cover;

  @nullable
  @BuiltValueField(wireName: 'air_date')
  String get airDate;

  @nullable
  @BuiltValueField(wireName: 'air_weekday')
  int get airWeekday;

  /// Total number of episodes
  /// Api doesn't return this field if it is not available
  /// This field is valid for anime/read/book
  @nullable
  @BuiltValueField(wireName: 'eps_count')
  int get totalEpisodesCount;

  /// Total number of volumes that are published(or will be published) so far
  /// Api doesn't return this field if it is not available
  /// This field is only valid for books
  @nullable
  @BuiltValueField(wireName: 'vol_count')
  int get totalVolumesCount;

  InProgressSubjectInfo._();

  factory InProgressSubjectInfo([updates(InProgressSubjectInfoBuilder b)]) =
      _$InProgressSubjectInfo;

  String toJson() {
    return json.encode(
        serializers.serializeWith(InProgressSubjectInfo.serializer, this));
  }

  static InProgressSubjectInfo fromJson(String jsonString) {
    return serializers.deserializeWith(
        InProgressSubjectInfo.serializer, json.decode(jsonString));
  }

  static Serializer<InProgressSubjectInfo> get serializer =>
      _$inProgressSubjectInfoSerializer;
}
