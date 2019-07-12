import 'package:munin/models/bangumi/discussion/thread/common/Post.dart';
import 'package:munin/models/bangumi/discussion/thread/post/MainPostReply.dart';

/// In-place update the list with [MainPostReply]
List<Post> addFlattenedMainPostReplies(
    List<Post> posts, Iterable<MainPostReply> mainPostReplies) {
  for (var mainReply in mainPostReplies) {
    posts.add(mainReply);
    for (var subReply in mainReply.subReplies) {
      posts.add(subReply);
    }
  }

  return posts;
}
