import 'package:built_collection/built_collection.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionRequest.dart';
import 'package:munin/models/bangumi/discussion/enums/DiscussionType.dart';
import 'package:munin/models/bangumi/discussion/enums/RakuenFilter.dart';
import 'package:munin/models/bangumi/discussion/thread/common/ThreadType.dart';
import 'package:munin/models/bangumi/setting/mute/MuteSetting.dart';
import 'package:munin/providers/bangumi/discussion/BangumiDiscussionService.dart';
import 'package:munin/shared/utils/collections/common.dart';
import 'package:test/test.dart';

import 'setup.dart';

void main() {
  group(BangumiDiscussionService, () {
    // Test golden blog entry.
    const goldenBlogId = 291754;
    BangumiDiscussionService bangumiDiscussionService;
    HttpTestHelper httpTestHelper;

    setUp(() async {
      httpTestHelper = await initializeHttpTestHelper();
      bangumiDiscussionService =
          BangumiDiscussionService(cookieClient: httpTestHelper.cookieService);
    });

    test('getRakuenTopics works', () async {
      final response = await bangumiDiscussionService.getRakuenTopics(
          getDiscussionRequest: GetDiscussionRequest((b) => b
            ..discussionFilter = RakuenTopicFilter.Unrestricted
            ..discussionType = DiscussionType.Rakuen),
          muteSetting: MuteSetting());

      expect(response.discussionItemsAsList, isNotEmpty);
    });

    test('getGroupThread works', () async {
      final topics = await bangumiDiscussionService.getRakuenTopics(
          getDiscussionRequest: GetDiscussionRequest((b) => b
            ..discussionFilter = RakuenTopicFilter.AllGroups
            ..discussionType = DiscussionType.Rakuen),
          muteSetting: MuteSetting());
      final threadId = topics.discussionItemsAsList.first.id;

      await bangumiDiscussionService.getGroupThread(
          threadId: threadId, mutedUsers: BuiltMap());
    });

    test('getEpisodeThread works', () async {
      final topics = await bangumiDiscussionService.getRakuenTopics(
          getDiscussionRequest: GetDiscussionRequest((b) => b
            ..discussionFilter = RakuenTopicFilter.Episode
            ..discussionType = DiscussionType.Rakuen),
          muteSetting: MuteSetting());
      final threadId = topics.discussionItemsAsList.first.id;

      await bangumiDiscussionService.getEpisodeThread(
          threadId: threadId, mutedUsers: BuiltMap());
    });

    test('getSubjectTopicThread works', () async {
      final topics = await bangumiDiscussionService.getRakuenTopics(
          getDiscussionRequest: GetDiscussionRequest((b) => b
            ..discussionFilter = RakuenTopicFilter.Subject
            ..discussionType = DiscussionType.Rakuen),
          muteSetting: MuteSetting());
      final threadId = topics.discussionItemsAsList.first.id;

      await bangumiDiscussionService.getSubjectTopicThread(
          threadId: threadId, mutedUsers: BuiltMap());
    });

    test('getGroupThread works', () async {
      await bangumiDiscussionService.getBlogThread(
          threadId: goldenBlogId, mutedUsers: BuiltMap());
    });

    test('creates and deletes reply', () async {
      final replyContent =
          'TestBlogReply${DateTime.now().millisecondsSinceEpoch}';
      final userId = await httpTestHelper.oauthService.verifyUser();
      final userInfo = await httpTestHelper.bangumiUserService
          .getUserBasicInfo(userId.toString());

      await bangumiDiscussionService.createReply(
        threadId: goldenBlogId,
        threadType: ThreadType.Blog,
        reply: replyContent,
        author: userInfo,
      );

      final blog = await bangumiDiscussionService.getBlogThread(
          threadId: goldenBlogId, mutedUsers: BuiltMap());
      final reply = blog.newestFirstFlattenedPosts.first;
      expect(reply.contentHtml, contains(replyContent));

      final editedReplyContent =
          'updateForEdit${DateTime.now().millisecondsSinceEpoch}';
      await bangumiDiscussionService.updateReply(
          reply.id, ThreadType.Blog, editedReplyContent);

      final editedReplyContentOnBangumi = await bangumiDiscussionService
          .getReplyContentForEdit(reply.id, ThreadType.Blog);
      expect(editedReplyContentOnBangumi, contains(editedReplyContent));

      await bangumiDiscussionService.deleteReply(
          replyId: reply.id, threadType: ThreadType.Blog);

      final updatedBlog = await bangumiDiscussionService.getBlogThread(
          threadId: goldenBlogId, mutedUsers: BuiltMap());
      final newestReplyAfterDeletion =
          firstOrNullInIterable(updatedBlog.newestFirstFlattenedPosts);
      expect(newestReplyAfterDeletion.id, isNot(equals(reply.id)));
    });
  });
}
