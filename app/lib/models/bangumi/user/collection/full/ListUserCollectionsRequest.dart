import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/models/bangumi/user/collection/full/OrderCollectionBy.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'ListUserCollectionsRequest.g.dart';

abstract class ListUserCollectionsRequest
    implements
        Built<ListUserCollectionsRequest, ListUserCollectionsRequestBuilder> {
  String get username;

  SubjectType get subjectType;

  CollectionStatus get collectionStatus;

  OrderCollectionBy get orderCollectionBy;

  /// An optional parameter which allows user to filter collection by tag.
  @nullable
  String get filterTag;

  ListUserCollectionsRequest._();

  factory ListUserCollectionsRequest(
          [void Function(ListUserCollectionsRequestBuilder) updates]) =
      _$ListUserCollectionsRequest;

  String toJson() {
    return json.encode(
        serializers.serializeWith(ListUserCollectionsRequest.serializer, this));
  }

  static ListUserCollectionsRequest fromJson(String jsonString) {
    return serializers.deserializeWith(
        ListUserCollectionsRequest.serializer, json.decode(jsonString));
  }

  static Serializer<ListUserCollectionsRequest> get serializer =>
      _$listUserCollectionsRequestSerializer;
}
