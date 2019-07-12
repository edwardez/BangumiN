import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/subject/common/SubjectBaseWithCover.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'CollectionsOnProfilePage.g.dart';

abstract class CollectionsOnProfilePage
    implements
        Built<CollectionsOnProfilePage, CollectionsOnProfilePageBuilder> {
  CollectionsOnProfilePage._();

  SubjectType get subjectType;

  /// Whether this type of collections are displayed as plain text on user home page
  /// or displayed as a list of subject with covers
  /// Bangumi user can choose which style to display for each subject type
  /// i.e. Anime can be displayed as subject with cover while game can be displayed
  /// as a bullet point list
  bool get onPlainTextPanel;

  /// A count number of subject user has collected under the [CollectionStatus]
  BuiltMap<CollectionStatus, int> get collectionDistribution;

  @memoized
  int get totalCollectionCount {
    return collectionDistribution.values.reduce((v1, v2) => v1 + v2);
  }

  BuiltMap<CollectionStatus, BuiltList<SubjectBaseWithCover>> get subjects;

  factory CollectionsOnProfilePage(
          [updates(CollectionsOnProfilePageBuilder b)]) =
      _$CollectionsOnProfilePage;

  String toJson() {
    return json.encode(
        serializers.serializeWith(CollectionsOnProfilePage.serializer, this));
  }

  static CollectionsOnProfilePage fromJson(String jsonString) {
    return serializers.deserializeWith(
        CollectionsOnProfilePage.serializer, json.decode(jsonString));
  }

  static Serializer<CollectionsOnProfilePage> get serializer =>
      _$collectionsOnProfilePageSerializer;
}
