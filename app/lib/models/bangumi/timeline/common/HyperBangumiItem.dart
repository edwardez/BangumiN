import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/models/bangumi/timeline/common/HyperItem.dart';

part 'HyperBangumiItem.g.dart';

/// A hyper link that directs to a [BangumiContent] page
abstract class HyperBangumiItem
    implements Built<HyperBangumiItem, HyperBangumiItemBuilder>, HyperItem {
  /// id of the hyper text
  String get id;

  BangumiContent get contentType;

  /// Item name, i.e. user name, subject name...
  String get name;

  /// if we cannot parse content, a fallback webview might be used
  /// hence an optional link is needed
  @nullable
  String get pageUrl;

  /// a item may or may not have an image
  @nullable
  String get imageUrl;

  HyperBangumiItem._();

  factory HyperBangumiItem([updates(HyperBangumiItemBuilder b)]) =
      _$HyperBangumiItem;

  static Serializer<HyperBangumiItem> get serializer =>
      _$hyperBangumiItemSerializer;
}
