import 'package:built_value/built_value.dart';
import 'package:munin/models/bangumi/common/BangumiUserBasic.dart';
import 'package:munin/models/bangumi/discussion/thread/post/MainPostReply.dart';
import 'package:munin/models/bangumi/discussion/thread/post/SubPostReply.dart';

part 'Post.g.dart';

@BuiltValue(instantiable: false)
abstract class Post {
  BangumiUserBasic get author;

  /// Unique id of the post.
  int get id;

  /// Content of the post in html.
  String get contentHtml;

  /// Post epoch time in milli seconds.
  int get postTimeInMilliSeconds;

  /// Post sequential number of this post.
  /// For [InitialPost] or [MainPostReply], this is its canonical floor number.
  /// For [SubPostReply], this is the floorNumber that it's attached to.
  /// Note: [mainSequentialNumber] starts from 1, and 1 is reserved for
  /// [InitialGroupPost].
  int get mainSequentialNumber;

  /// Sequential name of the post. It's typically number of the post.
  /// For [InitialPost], it's always `#1`
  /// For [MainPostReply], it might be something like `#3`, meaning it's the third
  /// post of the thread.
  /// For [SubPostReply], it's made up of its own sub sequential number and the main
  /// number. Thus [SubPostReply] must override this method and provide its own
  /// implementation.
  String get sequentialName {
    throw UnsupportedError(
        'Child class needs to provide concrete implementation.');
  }

  Post rebuild(void updates(PostBuilder b));

  PostBuilder toBuilder();
}
