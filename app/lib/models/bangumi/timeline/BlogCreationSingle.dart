import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/timeline/common/FeedMetaInfo.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';

part 'BlogCreationSingle.g.dart';

abstract class BlogCreationSingle
    implements
        Built<BlogCreationSingle, BlogCreationSingleBuilder>,
        TimelineFeed {
  /// due to the limitation of bangumi, this has to be a string
  FeedMetaInfo get user;

  String get title;

  @nullable
  String get summary;

  /// blog id
  String get id;

  BlogCreationSingle._();

  factory BlogCreationSingle([updates(BlogCreationSingleBuilder b)]) =
      _$BlogCreationSingle;

  static Serializer<BlogCreationSingle> get serializer =>
      _$blogCreationSingleSerializer;
}
