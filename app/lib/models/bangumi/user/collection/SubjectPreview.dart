import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/subject/common/SujectBase.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'SubjectPreview.g.dart';

/// a subject that's listed as related subject('关联条目') on subject main page
abstract class SubjectPreview
    implements SubjectBase, Built<SubjectPreview, SubjectPreviewBuilder> {
  /// Images might be intentionally set to null because
  /// of [displayedAsPlainText] in [CollectionPreview]
  @nullable
  BangumiImage get cover;

  SubjectPreview._();

  factory SubjectPreview([updates(SubjectPreviewBuilder b)]) = _$SubjectPreview;

  String toJson() {
    return json
        .encode(serializers.serializeWith(SubjectPreview.serializer, this));
  }

  static SubjectPreview fromJson(String jsonString) {
    return serializers.deserializeWith(
        SubjectPreview.serializer, json.decode(jsonString));
  }

  static Serializer<SubjectPreview> get serializer =>
      _$subjectPreviewSerializer;
}
