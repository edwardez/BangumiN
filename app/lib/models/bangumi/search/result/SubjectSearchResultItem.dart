import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/common/ChineseNameOwner.dart';
import 'package:munin/models/bangumi/search/SearchType.dart';
import 'package:munin/models/bangumi/search/result/SearchResultItem.dart';
import 'package:munin/models/bangumi/subject/Rating.dart';
import 'package:munin/shared/utils/serializers.dart';
import 'package:quiver/strings.dart';

part 'SubjectSearchResultItem.g.dart';

abstract class SubjectSearchResultItem
    with ChineseNameOwner
    implements
        SearchResultItem,
        Built<SubjectSearchResultItem, SubjectSearchResultItemBuilder> {
  @BuiltValueField(wireName: 'air_date')
  String get startDate;

  @BuiltValueField(wireName: 'name_cn')
  String get chineseName;

  @memoized

  /// a [startDate] is considered invalid if it's empty, null or starts with 0
  /// since bangumi sometimes uses `0000-00-00` to indicates invalid date
  bool get isStartDateValid {
    return !isEmpty(startDate) && startDate[0] != '0';
  }

  @nullable
  Rating get rating;

  factory SubjectSearchResultItem([updates(SubjectSearchResultItemBuilder b)]) =
  _$SubjectSearchResultItem;

  SubjectSearchResultItem._();

  String toJson() {
    return json.encode(
        serializers.serializeWith(SubjectSearchResultItem.serializer, this));
  }

  static SubjectSearchResultItem fromJson(String jsonString) {
    return serializers.deserializeWith(
        SubjectSearchResultItem.serializer, json.decode(jsonString));
  }

  static Serializer<SubjectSearchResultItem> get serializer =>
      _$subjectSearchResultItemSerializer;
}
