import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/common/Images.dart';
import 'package:munin/models/bangumi/common/ItemMetaInfo.dart';

part 'ReviewMetaInfo.g.dart';

abstract class ReviewMetaInfo
    implements ItemMetaInfo, Built<ReviewMetaInfo, ReviewMetaInfoBuilder> {
  @nullable
  Images get userAvatars;

  @nullable
  double get score;

  @nullable
  CollectionStatus get collectionStatus;

  ReviewMetaInfo._();

  factory ReviewMetaInfo([updates(ReviewMetaInfoBuilder b)]) = _$ReviewMetaInfo;

  static Serializer<ReviewMetaInfo> get serializer =>
      _$reviewMetaInfoSerializer;
}
