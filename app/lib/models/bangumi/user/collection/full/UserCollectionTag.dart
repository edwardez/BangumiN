import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'UserCollectionTag.g.dart';

/// A collection tag as seen on the right side of collection list panel.
///
/// [UserCollectionTag] are per [SubjectType] and per [CollectionStatus].
abstract class UserCollectionTag
    implements Built<UserCollectionTag, UserCollectionTagBuilder> {
  /// Name of the tag.
  String get name;

  /// Number of subjects that user have added this tag.
  int get taggedSubjectsCount;

  UserCollectionTag._();

  factory UserCollectionTag([void Function(UserCollectionTagBuilder) updates]) =
      _$UserCollectionTag;

  String toJson() {
    return json
        .encode(serializers.serializeWith(UserCollectionTag.serializer, this));
  }

  static UserCollectionTag fromJson(String jsonString) {
    return serializers.deserializeWith(
        UserCollectionTag.serializer, json.decode(jsonString));
  }

  static Serializer<UserCollectionTag> get serializer =>
      _$userCollectionTagSerializer;
}
