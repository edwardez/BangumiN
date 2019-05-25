import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/common/ItemMetaInfo.dart';

part 'FeedMetaInfo.g.dart';

abstract class FeedMetaInfo
    implements ItemMetaInfo, Built<FeedMetaInfo, FeedMetaInfoBuilder> {
  /// Bangumi feed id.
  int get feedId;

  FeedMetaInfo._();

  factory FeedMetaInfo([updates(FeedMetaInfoBuilder b)]) = _$FeedMetaInfo;

  static Serializer<FeedMetaInfo> get serializer => _$feedMetaInfoSerializer;
}
