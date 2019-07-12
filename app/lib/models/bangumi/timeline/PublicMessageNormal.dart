import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/models/bangumi/timeline/common/FeedMetaInfo.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';

part 'PublicMessageNormal.g.dart';

abstract class PublicMessageNormal
    implements
        Built<PublicMessageNormal, PublicMessageNormalBuilder>,
        TimelineFeed {
  /// due to the limitation of bangumi, this has to be a string
  FeedMetaInfo get user;

  /// Content in raw html.
  String get contentHtml;

  /// Content in raw text, by parsing html.
  String get contentText;

  int get replyCount;

  PublicMessageNormal._();

  factory PublicMessageNormal([updates(PublicMessageNormalBuilder b)]) =
      _$PublicMessageNormal;

  static Serializer<PublicMessageNormal> get serializer =>
      _$publicMessageNormalSerializer;
}
