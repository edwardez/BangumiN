import 'package:built_value/built_value.dart';
import 'package:munin/models/Bangumi/timeline/common/TimelineUserInfo.dart';

part 'BlogCreationSingle.g.dart';

abstract class BlogCreationSingle
    implements Built<BlogCreationSingle, BlogCreationSingleBuilder> {
  /// due to the limitation of bangumi, this has to be a string
  TimelineUserInfo get user;

  String get title;

  String get summary;

  /// blog id
  int get id;

  BlogCreationSingle._();

  factory BlogCreationSingle([updates(BlogCreationSingleBuilder b)]) =
      _$BlogCreationSingle;
}
