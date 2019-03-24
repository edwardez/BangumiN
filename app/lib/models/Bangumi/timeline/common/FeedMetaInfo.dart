import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/Bangumi/common/Images.dart';
import 'package:munin/models/Bangumi/common/ItemMetaInfo.dart';

part 'FeedMetaInfo.g.dart';

abstract class FeedMetaInfo
    implements ItemMetaInfo, Built<FeedMetaInfo, FeedMetaInfoBuilder> {
  /// bangumi feed id
  int get feedId;

  @nullable
  Images get images;

  FeedMetaInfo._();

  factory FeedMetaInfo([updates(FeedMetaInfoBuilder b)]) = _$FeedMetaInfo;


  static Serializer<FeedMetaInfo> get serializer => _$feedMetaInfoSerializer;
}
