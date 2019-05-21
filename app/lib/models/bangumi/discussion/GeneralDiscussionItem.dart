import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/Images.dart';
import 'package:munin/models/bangumi/discussion/DiscussionItem.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'GeneralDiscussionItem.g.dart';

/// a base TimelineFeed interface
abstract class GeneralDiscussionItem
    implements
        Built<GeneralDiscussionItem, GeneralDiscussionItemBuilder>,
        DiscussionItem {
  factory GeneralDiscussionItem([updates(GeneralDiscussionItemBuilder b)]) =
      _$GeneralDiscussionItem;

  GeneralDiscussionItem._();

  String toJson() {
    return json.encode(
        serializers.serializeWith(GeneralDiscussionItem.serializer, this));
  }

  static GeneralDiscussionItem fromJson(String jsonString) {
    return serializers.deserializeWith(
        GeneralDiscussionItem.serializer, json.decode(jsonString));
  }

  static Serializer<GeneralDiscussionItem> get serializer =>
      _$generalDiscussionItemSerializer;
}
