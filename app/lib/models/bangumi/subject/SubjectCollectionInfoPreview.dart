import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'SubjectCollectionInfoPreview.g.dart';

/// A subject that's listed as related subject('关联条目') on subject main page.
abstract class SubjectCollectionInfoPreview
    implements
        Built<SubjectCollectionInfoPreview,
            SubjectCollectionInfoPreviewBuilder> {
  @BuiltValueField(wireName: 'status')
  CollectionStatus get status;

  int get score;

  SubjectCollectionInfoPreview._();

  factory SubjectCollectionInfoPreview(
          [updates(SubjectCollectionInfoPreviewBuilder b)]) =>
      _$SubjectCollectionInfoPreview((b) => b
        ..status = CollectionStatus.Unknown
        ..score = 0
        ..update(updates));

  String toJson() {
    return json.encode(serializers.serializeWith(
        SubjectCollectionInfoPreview.serializer, this));
  }

  static SubjectCollectionInfoPreview fromJson(String jsonString) {
    return serializers.deserializeWith(
        SubjectCollectionInfoPreview.serializer, json.decode(jsonString));
  }

  static Serializer<SubjectCollectionInfoPreview> get serializer =>
      _$subjectCollectionInfoPreviewSerializer;
}
