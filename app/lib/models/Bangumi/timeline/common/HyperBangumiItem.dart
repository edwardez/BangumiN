import 'package:built_value/built_value.dart';
import 'package:munin/models/Bangumi/timeline/common/BangumiContent.dart';

part 'HyperBangumiItem.g.dart';

/// A hyper link that directs to a [BangumiContent] page
abstract class HyperBangumiItem
    implements Built<HyperBangumiItem, HyperBangumiItemBuilder> {
  /// id of the hyper text
  int get id;

  /// user nick name
  BangumiContent get contentType;

  /// Item name, i.e. user name, subject name...
  String get name;

  /// if we cannot parse content, a fallback webview might be used
  /// hence an optional link is needed
  @nullable
  String get link;

  /// a item may or may not have an image
  @nullable
  String get imageUrl;

  HyperBangumiItem._();

  factory HyperBangumiItem([updates(HyperBangumiItemBuilder b)]) =
      _$HyperBangumiItem;
}
