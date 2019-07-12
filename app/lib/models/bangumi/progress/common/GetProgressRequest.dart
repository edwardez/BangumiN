import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'GetProgressRequest.g.dart';

abstract class GetProgressRequest
    implements Built<GetProgressRequest, GetProgressRequestBuilder> {
  /// Currently there are 4 valid types, all watchable subjects/anime/real/book
  /// this value decides how many sub menus progress widget has
  static const totalGetProgressRequestTypes = 4;

  static final defaultProgressLaunchPageType = GetProgressRequest((b) => b
    ..requestedSubjectTypes
        .addAll([SubjectType.Anime, SubjectType.Real, SubjectType.Book]));

  static final allWatchable = defaultProgressLaunchPageType;

  static final List<GetProgressRequest> validGetProgressRequests = [
    defaultProgressLaunchPageType,
    GetProgressRequest(
        (b) => b..requestedSubjectTypes.addAll([SubjectType.Anime])),
    GetProgressRequest(
        (b) => b..requestedSubjectTypes.addAll([SubjectType.Real])),
    GetProgressRequest(
        (b) => b..requestedSubjectTypes.addAll([SubjectType.Book])),
  ];

  BuiltSet<SubjectType> get requestedSubjectTypes;

  @memoized
  String get chineseName {
    if (requestedSubjectTypes ==
        BuiltSet<SubjectType>.of(
            [SubjectType.Anime, SubjectType.Real, SubjectType.Book])) {
      return '所有在看';
    }

    assert(requestedSubjectTypes.length == 1);

    return requestedSubjectTypes.first.chineseName;
  }

  /// Get current page index in progress page
  /// Index must be consecutive and unique
  @memoized
  int get pageIndex {
    if (requestedSubjectTypes ==
        BuiltSet<SubjectType>.of(
            [SubjectType.Anime, SubjectType.Real, SubjectType.Book])) {
      return 0;
    }

    assert(requestedSubjectTypes.length == 1);

    if (requestedSubjectTypes ==
        BuiltSet<SubjectType>.of([SubjectType.Anime])) {
      return 1;
    }

    if (requestedSubjectTypes == BuiltSet<SubjectType>.of([SubjectType.Real])) {
      return 2;
    }

    if (requestedSubjectTypes == BuiltSet<SubjectType>.of([SubjectType.Book])) {
      return 3;
    }

    assert(false, '$this doesn\'t have a valid page index');
    return 0;
  }

  GetProgressRequest._();

  factory GetProgressRequest([updates(GetProgressRequestBuilder b)]) =
      _$GetProgressRequest;

  String toJson() {
    return json
        .encode(serializers.serializeWith(GetProgressRequest.serializer, this));
  }

  static GetProgressRequest fromJson(String jsonString) {
    return serializers.deserializeWith(
        GetProgressRequest.serializer, json.decode(jsonString));
  }

  static Serializer<GetProgressRequest> get serializer =>
      _$getProgressRequestSerializer;
}
