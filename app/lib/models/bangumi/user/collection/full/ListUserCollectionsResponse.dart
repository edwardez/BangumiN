import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/user/collection/full/CollectionOnUserList.dart';
import 'package:munin/models/bangumi/user/collection/full/ListUserCollectionsRequest.dart';
import 'package:munin/models/bangumi/user/collection/full/UserCollectionTag.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'ListUserCollectionsResponse.g.dart';

abstract class ListUserCollectionsResponse
    implements
        Built<ListUserCollectionsResponse, ListUserCollectionsResponseBuilder> {
  /// The original [listUserCollectionsRequest]
  ListUserCollectionsRequest get listUserCollectionsRequest;

  /// A ordered map of subject this user has collected in ascending order.
  /// key is subject id.
  BuiltMap<int, CollectionOnUserList> get collections;

  @memoized
  List<CollectionOnUserList> get toCollectionsList {
    return collections.values.toList(growable: false);
  }

  /// User tags under current collection list, it's in descending order of
  /// [UserCollectionTag.taggedSubjectsCount].
  BuiltMap<String, UserCollectionTag> get userCollectionTags;

  List<UserCollectionTag> get userCollectionTagsToList {
    return userCollectionTags.values.toList();
  }

  int get requestedUntilPageNumber;

  /// Whether munin can load more items and has not reached the end.
  bool get canLoadMoreItems;

  ListUserCollectionsResponse._();

  factory ListUserCollectionsResponse(
          [void Function(ListUserCollectionsResponseBuilder) updates]) =
      _$ListUserCollectionsResponse;

  String toJson() {
    return json.encode(serializers.serializeWith(
        ListUserCollectionsResponse.serializer, this));
  }

  static ListUserCollectionsResponse fromJson(String jsonString) {
    return serializers.deserializeWith(
        ListUserCollectionsResponse.serializer, json.decode(jsonString));
  }

  static Serializer<ListUserCollectionsResponse> get serializer =>
      _$listUserCollectionsResponseSerializer;
}
