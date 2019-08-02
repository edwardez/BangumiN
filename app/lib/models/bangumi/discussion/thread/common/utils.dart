import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart' show PriorityQueue;
import 'package:munin/models/bangumi/discussion/thread/common/Post.dart';
import 'package:munin/models/bangumi/discussion/thread/post/MainPostReply.dart';
import 'package:munin/models/bangumi/discussion/thread/post/SubPostReply.dart';

abstract class HasMainPostRepliesMap {
  BuiltList<MainPostReply> get mainPostReplies;

  BuiltMap<int, MainPostReply> get mainPostRepliesMap {
    var mainPostRepliesMap = BuiltMap<int, MainPostReply>();

    for (var mainPostReply in mainPostReplies) {
      mainPostRepliesMap = mainPostRepliesMap
          .rebuild((b) => b.addAll({mainPostReply.id: mainPostReply}));
    }

    return mainPostRepliesMap;
  }
}

/// Merge [prependedPosts] with [mainPostReplies].
///
/// [reverse] is set to false by default, if set to true, mainPostReplies will
/// be added in reverse order at first, then an reversed [prependedPosts] will
/// be added. Note that [SubPostReply] inside [MainPostReply] is not reversed.
List<Post> mergePostsWithMainPostReplies(List<Post> prependedPosts,
    Iterable<MainPostReply> mainPostReplies, {
      bool reverse = false,
    }) {
  List<Post> posts = [];
  if (reverse) {
    for (var mainReply in mainPostReplies
        .toList()
        .reversed) {
      posts.add(mainReply);
      for (SubPostReply subReply in mainReply.subReplies) {
        posts.add(subReply);
      }
    }
    posts.addAll(prependedPosts);
  } else {
    posts.addAll(prependedPosts);

    for (var mainReply in mainPostReplies) {
      posts.add(mainReply);
      for (var subReply in mainReply.subReplies) {
        posts.add(subReply);
      }
    }
  }

  return posts;
}

/// Merge [prependedPosts] with [mainPostReplies].
/// [mainPostReplies] with newer reply is shown first.
List<Post> mergePostsWithHasNewestReplyFirstNestedPosts(
    List<Post> prependedPosts,
    Iterable<MainPostReply> mainPostReplies,) {
  final sortedMainPostPriorityQueue = PriorityQueue<MainPostReply>((a, b) =>
      b.includedPostsNewestReplyTime.compareTo(a.includedPostsNewestReplyTime));

  for (var mainReply in mainPostReplies) {
    sortedMainPostPriorityQueue.add(mainReply);
  }

  List<Post> posts = [...prependedPosts];
  for (var mainReply in sortedMainPostPriorityQueue.toList()) {
    posts.add(mainReply);
    for (SubPostReply subReply in mainReply.subReplies) {
      posts.add(subReply);
    }
  }

  return posts;
}

/// Reverses all [Post] inside [mainPostReplies] and ordered by newest First.
/// [prependedPosts] will always be put in head.
List<Post> flattenedReverseOrderMainPostReplies(List<Post> prependedPosts,
    Iterable<MainPostReply> mainPostReplies) {
  final posts = [...prependedPosts];

  final priorityQueue = PriorityQueue<Post>(
          (a, b) =>
          b.postTimeInMilliSeconds.compareTo(a.postTimeInMilliSeconds));

  for (var mainReply in mainPostReplies) {
    priorityQueue.add(mainReply);
    for (var subReply in mainReply.subReplies) {
      priorityQueue.add(subReply);
    }
  }

  posts.addAll(priorityQueue.toList());
  return posts;
}
