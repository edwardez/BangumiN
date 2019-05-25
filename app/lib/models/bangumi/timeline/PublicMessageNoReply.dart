import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/models/bangumi/timeline/common/FeedMetaInfo.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';

part 'PublicMessageNoReply.g.dart';

/// a special public message that's published by system and un-deletable
abstract class PublicMessageNoReply
    implements
        Built<PublicMessageNoReply, PublicMessageNoReplyBuilder>,
        TimelineFeed {
  /// due to the limitation of bangumi, this has to be a string
  FeedMetaInfo get user;

  String get content;

  PublicMessageNoReply._();

  factory PublicMessageNoReply([updates(PublicMessageNoReplyBuilder b)]) =
      _$PublicMessageNoReply;

  static Serializer<PublicMessageNoReply> get serializer =>
      _$publicMessageNoReplySerializer;
}
