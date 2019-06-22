import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/collection/SubjectCollectionInfo.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/models/bangumi/subject/review/GetSubjectReviewRequest.dart';
import 'package:munin/models/bangumi/subject/review/SubjectReviewResponse.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'SubjectState.g.dart';

abstract class SubjectState
    implements Built<SubjectState, SubjectStateBuilder> {
  @nullable
  BuiltMap<int, BangumiSubject> get subjects;

  BuiltMap<int, SubjectCollectionInfo> get collections;

  BuiltMap<GetSubjectReviewRequest, SubjectReviewResponse> get subjectsReviews;

  SubjectState._();

  factory SubjectState([updates(SubjectStateBuilder b)]) =>
      _$SubjectState((b) => b
        ..subjects.replace(BuiltMap<int, BangumiSubject>())
        ..collections.replace(BuiltMap<int, SubjectCollectionInfo>())
        ..subjectsReviews.replace(
            BuiltMap<GetSubjectReviewRequest, SubjectReviewResponse>())
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
