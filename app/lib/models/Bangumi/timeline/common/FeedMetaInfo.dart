import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'FeedMetaInfo.g.dart';

abstract class FeedMetaInfo
    implements Built<FeedMetaInfo, FeedMetaInfoBuilder> {
  /// due to the limitation of bangumi, this has to be a string
  /// it's a relative time, i.e. xx minutes ago
  String get updatedAt;

  /// user nick name
  String get nickName;

  @nullable

  /// user avatar image url
  String get avatarImageUrl;

  /// user id, can only have digit and alphabetic
  String get userId;

  /// bangumi feed id
  int get feedId;

  String get actionName;

  FeedMetaInfo._();

  factory FeedMetaInfo([updates(FeedMetaInfoBuilder b)]) = _$FeedMetaInfo;


  static Serializer<FeedMetaInfo> get serializer => _$feedMetaInfoSerializer;
}
