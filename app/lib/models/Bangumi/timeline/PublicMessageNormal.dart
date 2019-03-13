import 'package:built_value/built_value.dart';
import 'package:munin/models/Bangumi/timeline/common/TimelineUserInfo.dart';

part 'PublicMessageNormal.g.dart';

abstract class PublicMessageNormal
    implements Built<PublicMessageNormal, PublicMessageNormalBuilder> {
  /// due to the limitation of bangumi, this has to be a string
  TimelineUserInfo get user;

  String get content;

  String get replyCount;

  int get id;

  PublicMessageNormal._();

  factory PublicMessageNormal([updates(PublicMessageNormalBuilder b)]) =
      _$PublicMessageNormal;
}
