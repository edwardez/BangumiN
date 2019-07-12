import 'package:built_value/built_value.dart';
import 'package:munin/models/bangumi/user/social/NetworkServiceType.dart';

part 'NetworkServiceTag.g.dart';

@BuiltValue(instantiable: false)
abstract class NetworkServiceTag {
  NetworkServiceType get type;

  /// Content that's after this tag, this content is defined by user
  /// i.e. [PSN ID]: abcde
  /// Here content is abcde
  /// If the tag contains a hyperlink, then content is value of this hyperlink
  /// And the value is stored in [NetworkServiceTagLink.link]
  String get content;

  /// Whether value of the tag is a link or plain text
  bool get isLink;
}
