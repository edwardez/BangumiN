import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/subject/common/SujectBase.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'SubjectBaseWithCover.g.dart';

/// a subject that has a cover.
abstract class SubjectBaseWithCover
    implements
        SubjectBase,
        Built<SubjectBaseWithCover, SubjectBaseWithCoverBuilder> {
  /// Images might be intentionally set to null because
  /// of [displayedAsPlainText] in [CollectionPreview]
  @nullable
  BangumiImage get cover;

  SubjectBaseWithCover._();

  factory SubjectBaseWithCover([updates(SubjectBaseWithCoverBuilder b)]) =
      _$SubjectBaseWithCover;

  String toJson() {
    return json.encode(
        serializers.serializeWith(SubjectBaseWithCover.serializer, this));
  }

  static SubjectBaseWithCover fromJson(String jsonString) {
    return serializers.deserializeWith(
        SubjectBaseWithCover.serializer, json.decode(jsonString));
  }

  static Serializer<SubjectBaseWithCover> get serializer =>
      _$subjectBaseWithCoverSerializer;
}
