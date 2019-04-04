import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/timeline/common/FeedMetaInfo.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';

part 'WikiCreationSingle.g.dart';

abstract class WikiCreationSingle
    implements
        Built<WikiCreationSingle, WikiCreationSingleBuilder>,
        TimelineFeed {
  FeedMetaInfo get user;

  String get newItemName;

  String get newItemId;

  WikiCreationSingle._();

  factory WikiCreationSingle([updates(WikiCreationSingleBuilder b)]) =
      _$WikiCreationSingle;

  static Serializer<WikiCreationSingle> get serializer =>
      _$wikiCreationSingleSerializer;
}
