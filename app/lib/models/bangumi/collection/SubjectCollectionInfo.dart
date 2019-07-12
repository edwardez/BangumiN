import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/collection/CollectionStatusFromBangumi.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/shared/utils/serializers.dart';
import 'package:quiver/strings.dart';

part 'SubjectCollectionInfo.g.dart';

/// Collection info of a subject. It's roughly the model of collection info
/// on Bangumi, except progress-related info.
abstract class SubjectCollectionInfo
    implements Built<SubjectCollectionInfo, SubjectCollectionInfoBuilder> {
  @BuiltValueField(wireName: 'status')
  CollectionStatusFromBangumi get status;

  String get comment;

  @BuiltValueField(wireName: 'tag')
  BuiltList<String> get tags;

  int get rating;

  int get private;

  /// Not available in api: number of episode user has completed for this subject.
  /// If this info is unknown, it's set to null.
  @nullable
  int get completedEpisodesCount;

  /// Not available in api: number of episode user has completed for this subject.
  /// If this info is unknown or subject is not a [SubjectType.Book], it's set to null.
  @nullable
  int get completedVolumesCount;

  SubjectCollectionInfo._();

  bool isDirtySubjectCollectionInfo() {
    return status.type != CollectionStatus.Pristine ||
        !isEmpty(comment) ||
        tags.length != 0;
  }

  factory SubjectCollectionInfo([updates(SubjectCollectionInfoBuilder b)]) =>
      _$SubjectCollectionInfo((b) => b
        ..status.replace(CollectionStatusFromBangumi())
        ..comment = ""
        ..tags.replace([])
        ..rating = 0
        ..private = 0
        ..update(updates));

  String toJson() {
    return json.encode(
        serializers.serializeWith(SubjectCollectionInfo.serializer, this));
  }

  static SubjectCollectionInfo fromJson(String jsonString) {
    return serializers.deserializeWith(
        SubjectCollectionInfo.serializer, json.decode(jsonString));
  }

  static Serializer<SubjectCollectionInfo> get serializer =>
      _$subjectCollectionInfoSerializer;
}
