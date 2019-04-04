import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/collection/SubjectCollectionInfo.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'SubjectState.g.dart';

abstract class SubjectState
    implements Built<SubjectState, SubjectStateBuilder> {
  @nullable
  BuiltMap<int, BangumiSubject> get subjects;

  /// A map which contains loading status of each subject and its corresponding
  /// loading state. Key is subject id
  BuiltMap<int, LoadingStatus> get subjectsLoadingStatus;

  BuiltMap<int, SubjectCollectionInfo> get collections;

  /// A map which contains loading status of each collection and its corresponding
  /// loading state. Key is subject id
  BuiltMap<int, LoadingStatus> get collectionsLoadingStatus;

  /// A map which contains submission status of each collection and its corresponding
  /// loading state. Key is subject id
  BuiltMap<int, LoadingStatus> get collectionsSubmissionStatus;

  SubjectState._();

  /// TODO: check whether it'll be a performance issue to initialize map every time
  factory SubjectState([updates(SubjectStateBuilder b)]) =>
      _$SubjectState((b) => b
        ..subjects.replace(BuiltMap<int, BangumiSubject>())
        ..subjectsLoadingStatus.replace(BuiltMap<int, LoadingStatus>())
        ..collections.replace(BuiltMap<int, SubjectCollectionInfo>())
        ..collectionsLoadingStatus.replace(BuiltMap<int, LoadingStatus>())
        ..collectionsSubmissionStatus.replace(BuiltMap<int, LoadingStatus>())
        ..update(updates));

  String toJson() {
    return json
        .encode(serializers.serializeWith(SubjectState.serializer, this));
  }

  static SubjectState fromJson(String jsonString) {
    return serializers.deserializeWith(
        SubjectState.serializer, json.decode(jsonString));
  }

  static Serializer<SubjectState> get serializer => _$subjectStateSerializer;
}
