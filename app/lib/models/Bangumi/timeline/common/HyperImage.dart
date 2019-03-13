import 'package:built_value/built_value.dart';
import 'package:munin/models/Bangumi/timeline/common/BangumiContent.dart';

part 'HyperImage.g.dart';

/// HyperImage: image with a clickable link
abstract class HyperImage implements Built<HyperImage, HyperImageBuilder> {
  /// id of the hyper text
  int get id;

  /// content type
  BangumiContent get contentType;

  /// HyperImage name
  String get name;

  /// url of the image
  String get imageUrl;

  /// if we cannot parse content, a fallback webview might be used
  /// hence an optional link is needed
  @nullable
  String get link;

  HyperImage._();

  factory HyperImage([updates(HyperImageBuilder b)]) = _$HyperImage;
}
