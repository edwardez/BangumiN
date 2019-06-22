import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/models/bangumi/subject/common/SujectBase.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'SubjectOnUserCollectionList.g.dart';

abstract class SubjectOnUserCollectionList
    implements
        SubjectBase,
        Built<SubjectOnUserCollectionList, SubjectOnUserCollectionListBuilder> {
  /// An additional subject info on collection list.
  /// For example, '2010-08-25 / 藤子・F・不二雄 / 小学館 / 715'
  String get additionalInfo;

  BangumiImage get cover;

  SubjectType get type;

  SubjectOnUserCollectionList._();

  factory SubjectOnUserCollectionList(
          [void Function(SubjectOnUserCollectionListBuilder) updates]) =
      _$SubjectOnUserCollectionList;

  String toJson() {
    return json.encode(serializers.serializeWith(
        SubjectOnUserCollectionList.serializer, this));
  }

  static SubjectOnUserCollectionList fromJson(String jsonString) {
    return serializers.deserializeWith(
        SubjectOnUserCollectionList.serializer, json.decode(jsonString));
  }

  static Serializer<SubjectOnUserCollectionList> get serializer =>
      _$subjectOnUserCollectionListSerializer;
}
