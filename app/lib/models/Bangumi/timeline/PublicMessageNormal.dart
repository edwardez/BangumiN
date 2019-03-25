import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/Bangumi/timeline/common/FeedMetaInfo.dart';
import 'package:munin/models/Bangumi/timeline/common/TimelineFeed.dart';

part 'PublicMessageNormal.g.dart';

abstract class PublicMessageNormal
    implements
        Built<PublicMessageNormal, PublicMessageNormalBuilder>,
        TimelineFeed {
  /// due to the limitation of bangumi, this has to be a string
  FeedMetaInfo get user;

  String get content;

  int get replyCount;

  /// theoretically it should never be null, however to prevent unforeseen
  /// data corruption we mark it as nullable
  @nullable
  String get id;

  PublicMessageNormal._();

  factory PublicMessageNormal([updates(PublicMessageNormalBuilder b)]) =
      _$PublicMessageNormal;

  static Serializer<PublicMessageNormal> get serializer =>
      _$publicMessageNormalSerializer;
}
