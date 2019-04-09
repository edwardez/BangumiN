import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/Images.dart';
import 'package:munin/models/bangumi/search/SearchType.dart';
import 'package:munin/models/bangumi/search/result/SearchResult.dart';
import 'package:munin/models/bangumi/subject/Rating.dart';
import 'package:munin/shared/utils/serializers.dart';
import 'package:quiver/strings.dart';

part 'SubjectSearchResult.g.dart';

abstract class SubjectSearchResult
    implements
        SearchResult,
        Built<SubjectSearchResult, SubjectSearchResultBuilder> {
  @BuiltValueField(wireName: 'air_date')
  String get startDate;

  @memoized

  /// a [startDate] is considered invalid if it's empty, null or starts with 0
  /// since bangumi sometimes uses `0000-00-00` to indicates invalid date
  bool get isStartDateValid {
    return !isEmpty(startDate) && startDate[0] != '0';
  }

  @nullable
  Rating get rating;

  factory SubjectSearchResult([updates(SubjectSearchResultBuilder b)]) =
      _$SubjectSearchResult;

  SubjectSearchResult._();

  String toJson() {
    return json.encode(
        serializers.serializeWith(SubjectSearchResult.serializer, this));
  }

  static SubjectSearchResult fromJson(String jsonString) {
    return serializers.deserializeWith(
        SubjectSearchResult.serializer, json.decode(jsonString));
  }

  static Serializer<SubjectSearchResult> get serializer =>
      _$subjectSearchResultSerializer;
}
