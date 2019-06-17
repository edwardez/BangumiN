import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'SubjectProgressPreview.g.dart';

/// Subject progress info as seen on subject html.
abstract class SubjectProgressPreview
    implements Built<SubjectProgressPreview, SubjectProgressPreviewBuilder> {
  /// Total number of episodes user has read/watched so far.
  /// If this is unknown, it's set to null.
  @nullable
  int get completedEpisodesCount;

  /// Total number of volumes user has read so far. It's only valid for book.
  /// For non-book, it's set to 0.
  /// If this is unknown, it's set to null.
  @nullable
  int get completedVolumesCount;

  /// Total number of episodes. Might be null since on Bangumi [totalEpisodesCount]
  /// might be set to unknown, or this info is not available.
  @nullable
  int get totalEpisodesCount;

  /// Total number of volumes that are published(or will be published) so far
  /// Might be null since on Bangumi [totalVolumesCount] might be set to unknown
  /// or this info is not available.
  /// It's only valid for book. For non-book, it's set to null.
  @nullable
  int get totalVolumesCount;

  /// Whether subject os a tankobon if it's a [SubjectType.Book].
  ///
  /// null for other type of subjects.
  @nullable
  bool get isTankobon;

  SubjectProgressPreview._();

  factory SubjectProgressPreview(
          [void Function(SubjectProgressPreviewBuilder) updates]) =>
      _$SubjectProgressPreview((b) => b
        ..completedEpisodesCount = null
        ..completedVolumesCount = null
        ..totalEpisodesCount = null
        ..totalVolumesCount = null
        ..isTankobon = null
        ..update(updates));

  String toJson() {
    return json.encode(
        serializers.serializeWith(SubjectProgressPreview.serializer, this));
  }

  static SubjectProgressPreview fromJson(String jsonString) {
    return serializers.deserializeWith(
        SubjectProgressPreview.serializer, json.decode(jsonString));
  }

  static Serializer<SubjectProgressPreview> get serializer =>
      _$subjectProgressPreviewSerializer;
}
