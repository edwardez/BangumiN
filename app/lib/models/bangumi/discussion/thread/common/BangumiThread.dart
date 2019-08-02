import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:munin/models/bangumi/discussion/thread/common/Post.dart';
import 'package:munin/models/bangumi/discussion/thread/post/MainPostReply.dart';
import 'package:munin/widgets/discussion/thread/shared/ReadModeSwitcher.dart';

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

  /// A flattened list of all posts. It's used by [PostReadMode.Normal]
  @memoized
  List<Post> get normalModePosts {
    throw UnsupportedError('Subclass needs to implement this');
  }

  /// Posts sorted by [MainPostReply] with reverse order of [normalModePosts].
  /// It's used by [PostReadMode.HasNewestReplyFirstNestedPost]
  @memoized
  List<Post> get hasNewestReplyFirstNestedPosts {
    throw UnsupportedError('Subclass needs to implement this');
  }

  /// Posts flattened with a newest first order.
  /// It's used by [PostReadMode.NewestFirstFlattenedPost]
  @memoized
  List<Post> get newestFirstFlattenedPosts {
    throw UnsupportedError('Subclass needs to implement this');
  }

  BangumiThread rebuild(void updates(BangumiThreadBuilder b));

  BangumiThreadBuilder toBuilder();
}
