import 'package:munin/models/Bangumi/timeline/common/BangumiContent.dart';

/// A base interface for all BangumiContent types that have an id, a type and a page Url
abstract class HyperItem {
  /// id of the hyper text
  String get id;

  /// content type
  BangumiContent get contentType;

  String get pageUrl;
}
