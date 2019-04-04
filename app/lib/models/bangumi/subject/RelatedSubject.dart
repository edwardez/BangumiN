import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/Images.dart';
import 'package:munin/models/bangumi/subject/common/SujectBase.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'RelatedSubject.g.dart';

/// a subject that's listed as related subject('关联条目') on subject main page
abstract class RelatedSubject
    implements SubjectBase, Built<RelatedSubject, RelatedSubjectBuilder> {
  /// i.e. 画集, 原声集, 片头曲...
  /// ideally this should be a enum, however due to the nature of parsing and
  /// the number of subtype, it's currently a string
  String get subjectSubTypeName;

  @nullable
  Images get images;

  RelatedSubject._();

  factory RelatedSubject([updates(RelatedSubjectBuilder b)]) = _$RelatedSubject;

  String toJson() {
    return json
        .encode(serializers.serializeWith(RelatedSubject.serializer, this));
  }

  static RelatedSubject fromJson(String jsonString) {
    return serializers.deserializeWith(
        RelatedSubject.serializer, json.decode(jsonString));
  }

  static Serializer<RelatedSubject> get serializer =>
      _$relatedSubjectSerializer;
}
