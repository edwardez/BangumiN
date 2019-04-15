import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/Images.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'DiscussionItem.g.dart';

/// a base TimelineFeed interface
abstract class DiscussionItem
    implements Built<DiscussionItem, DiscussionItemBuilder> {
  int get id;

  BangumiContent get bangumiContent;

  Images get images;

  /// For person/character, it's person/character name
  /// For episode, it's episode name
  /// For group topic/subject topic, it's postName
  String get title;

  /// For person/character, it's a fixed string: person/character
  /// For episode/subject topic, it's subject name
  /// For group topic, it's group name
  String get subTitle;

  int get replyCount;

  @nullable
  int get updatedAt;

  /// currently not in use
  /// username of the Original Poster
  /// This field is null if the content is not a post
  /// @nullable
  ///  String get opUsername;

  factory DiscussionItem([updates(DiscussionItemBuilder b)]) = _$DiscussionItem;

  DiscussionItem._();

  String toJson() {
    return json
        .encode(serializers.serializeWith(DiscussionItem.serializer, this));
  }

  static DiscussionItem fromJson(String jsonString) {
    return serializers.deserializeWith(
        DiscussionItem.serializer, json.decode(jsonString));
  }

  static Serializer<DiscussionItem> get serializer =>
      _$discussionItemSerializer;
}
