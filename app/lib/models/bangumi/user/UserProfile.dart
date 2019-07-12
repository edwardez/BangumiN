import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/BangumiUserSmall.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/models/bangumi/user/Relationship.dart';
import 'package:munin/models/bangumi/user/collection/preview/CollectionsOnProfilePage.dart';
import 'package:munin/models/bangumi/user/social/NetworkServiceTag.dart';
import 'package:munin/models/bangumi/user/timeline/TimelinePreview.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'UserProfile.g.dart';

abstract class UserProfile implements Built<UserProfile, UserProfileBuilder> {
  UserProfile._();

  /// A paragraph of introduction as a html string
  String get introductionInHtml;

  /// A paragraph of introduction in plain text string
  String get introductionInPlainText;

  @nullable
  BangumiUserSmall get basicInfo;

  BuiltList<NetworkServiceTag> get networkServiceTags;

  /// Note: Collection preview panel order can be customized by bangumi user.
  /// This value observes that order
  BuiltMap<SubjectType, CollectionsOnProfilePage> get collectionPreviews;

  /// For now all preview timeline activities will be parsed as plain text
  BuiltList<TimelinePreview> get timelinePreviews;

  /// Note: currently there is no easy way to check whether a target user is
  /// following current user, so we cannot determine whether two users are
  /// mutually following each other
  BuiltSet<Relationship> get relationships;

  factory UserProfile([updates(UserProfileBuilder b)]) = _$UserProfile;

  String toJson() {
    return json.encode(serializers.serializeWith(UserProfile.serializer, this));
  }

  static UserProfile fromJson(String jsonString) {
    return serializers.deserializeWith(
        UserProfile.serializer, json.decode(jsonString));
  }

  static Serializer<UserProfile> get serializer => _$userProfileSerializer;
}
