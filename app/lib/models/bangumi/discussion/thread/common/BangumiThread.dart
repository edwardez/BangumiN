import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:munin/models/bangumi/discussion/thread/common/Post.dart';
import 'package:munin/models/bangumi/discussion/thread/post/MainPostReply.dart';

part 'BangumiThread.g.dart';

@BuiltValue(instantiable: false)
abstract class BangumiThread {
  /// id of the thread.
  int get id;

  /// Title of the thread.
  String get title;

  /// A list of replies that are directly attached to the thread.
  /// [mainPostReplies] doesn't include [originalPost] and any reply that is a
  /// reply to [mainPostReplies].
  BuiltList<MainPostReply> get mainPostReplies;

  /// A flattened list of all posts.
  @memoized
  List<Post> get posts {
    throw UnsupportedError('Subclass must override getter `posts` instead'
        'of callling it directly.');
  }

  BangumiThread rebuild(void updates(BangumiThreadBuilder b));

  BangumiThreadBuilder toBuilder();
}
