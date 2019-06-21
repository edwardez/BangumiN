import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/user/collection/full/SubjectOnUserCollectionList.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'CollectionOnUserList.g.dart';

/// A collection as seen on user collection list. For example,
/// https://bgm.tv/anime/list/1/do
///
/// While [CollectionOnUserList] kind of violates effective dart naming principle,
/// naming it 'UserListCollection' sounds weird.
abstract class CollectionOnUserList
    implements Built<CollectionOnUserList, CollectionOnUserListBuilder> {
  /// Collection status of the target user.
  CollectionStatus get collectionStatus;

  /// Whether current app user(who is viewing this collection list) has collected
  /// this subject.
  bool get collectedByCurrentAppUser;

  @nullable
  String get comment;

  /// Rating of the subject, user can choose to not give a subject score, hence
  /// it's nullable.
  @nullable
  int get rating;

  BuiltList<String> get tags;

  SubjectOnUserCollectionList get subject;

  /// Epoch time in milli seconds that user add this subject to collection.
  ///
  /// While it's an epoch time, bangumi actually only provides time that's
  /// accentuate to date, like 2019-01-01
  int get collectedTimeMilliSeconds;

  CollectionOnUserList._();

  factory CollectionOnUserList(
          [void Function(CollectionOnUserListBuilder) updates]) =
      _$CollectionOnUserList;

  String toJson() {
    return json.encode(
        serializers.serializeWith(CollectionOnUserList.serializer, this));
  }

  static CollectionOnUserList fromJson(String jsonString) {
    return serializers.deserializeWith(
        CollectionOnUserList.serializer, json.decode(jsonString));
  }

  static Serializer<CollectionOnUserList> get serializer =>
      _$collectionOnUserListSerializer;
}
