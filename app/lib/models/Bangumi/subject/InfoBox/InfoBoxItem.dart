import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/Bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'InfoBoxItem.g.dart';

/// The smallest element in a info box
/// i.e. a staff under a job
abstract class InfoBoxItem implements Built<InfoBoxItem, InfoBoxItemBuilder> {
  InfoBoxItem._();

  BangumiContent get type;

  /// Item name, i.e. staff name, air date...
  String get name;

  @nullable
  /// id of the InfoBoxItem, if there is any. For plain text such id doesn't exist
  String get id;

  /// if we cannot parse content, a fallback webview might be used
  /// hence an optional link is needed
  @nullable
  String get pageUrl;

  factory InfoBoxItem([updates(InfoBoxItemBuilder b)]) = _$InfoBoxItem;

  String toJson() {
    return json.encode(serializers.serializeWith(InfoBoxItem.serializer, this));
  }

  static InfoBoxItem fromJson(String jsonString) {
    return serializers.deserializeWith(
        InfoBoxItem.serializer, json.decode(jsonString));
  }

  static Serializer<InfoBoxItem> get serializer => _$infoBoxItemSerializer;
}
