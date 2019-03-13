import 'package:built_value/built_value.dart';
import 'package:munin/models/Bangumi/timeline/common/TimelineUserInfo.dart';

part 'PublicMessageNoReply.g.dart';

/// a special public message that's published by system and un-deletable
abstract class PublicMessageNoReply
    implements Built<PublicMessageNoReply, PublicMessageNoReplyBuilder> {
  /// due to the limitation of bangumi, this has to be a string
  TimelineUserInfo get user;

  String get content;

  PublicMessageNoReply._();

  factory PublicMessageNoReply([updates(PublicMessageNoReplyBuilder b)]) =
      _$PublicMessageNoReply;
}
