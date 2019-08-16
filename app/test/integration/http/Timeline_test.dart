import 'package:built_collection/built_collection.dart';
import 'package:munin/models/bangumi/BangumiUserSmall.dart';
import 'package:munin/models/bangumi/timeline/PublicMessageNormal.dart';
import 'package:munin/models/bangumi/timeline/common/FeedLoadType.dart';
import 'package:munin/models/bangumi/timeline/common/GetTimelineRequest.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineCategoryFilter.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineSource.dart';
import 'package:munin/providers/bangumi/timeline/BangumiTimelineService.dart';
import 'package:munin/providers/bangumi/timeline/parser/TimelineParser.dart';
import 'package:munin/providers/bangumi/user/BangumiUserService.dart';
import 'package:munin/shared/utils/collections/common.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:test/test.dart';

import 'setup.dart';

void main() {
  group('HttpTimeline', () {
    BangumiTimelineService bangumiTimelineService;
    BangumiUserService bangumiUserService;
    HttpTestHelper httpTestHelper;

    setUp(() async {
      httpTestHelper = await initializeHttpTestHelper();
      bangumiTimelineService =
          BangumiTimelineService(cookieClient: httpTestHelper.cookieService);
      bangumiUserService = BangumiUserService(
        sharedPreferenceService: MockSharedPreferenceService(),
        cookieClient: httpTestHelper.cookieService,
        oauthClient: httpTestHelper.oauthService,
      );
    });

    test('getTimeline works', () async {
      final response = await bangumiTimelineService.getTimeline(
          request: GetTimelineRequest((b) => b
            ..timelineCategoryFilter = TimelineCategoryFilter.AllFeeds
            ..timelineSource = TimelineSource.OnlyFriends),
          nextPageNum: 0,
          feedLoadType: FeedLoadType.Initial,
          upperFeedId: IntegerHelper.MAX_VALUE,
          lowerFeedId: IntegerHelper.MIN_VALUE,
          mutedUsers: BuiltMap(),
          userInfo: null);

      expect(response.feeds, isNotEmpty);
    });

    test('submits then deletes timeline', () async {
      Future<GetTimelineParsedResponse> getUserTimeline(
          BangumiUserSmall userInfo) async {
        return bangumiTimelineService.getTimeline(
            request: GetTimelineRequest((b) => b
              ..timelineCategoryFilter = TimelineCategoryFilter.PublicMessage
              ..timelineSource = TimelineSource.OnlyFriends
              ..username = userInfo.username),
            nextPageNum: 0,
            feedLoadType: FeedLoadType.Initial,
            upperFeedId: IntegerHelper.MAX_VALUE,
            lowerFeedId: IntegerHelper.MIN_VALUE,
            mutedUsers: BuiltMap(),
            userInfo: userInfo);
      }

      const messageContent = 'TestPublicmessageCreation';
      await bangumiTimelineService.submitTimelineMessage(messageContent);

      final userId = await httpTestHelper.oauthService.verifyUser();
      final userInfo = await bangumiUserService.getUserBasicInfo('$userId');
      final timeline = await getUserTimeline(userInfo);
      final PublicMessageNormal message = timeline.feeds.first;

      expect(message.contentHtml, contains(messageContent));

      const replyContent = 'TestTimelineReply';
      await bangumiTimelineService.createPublicMessageReply(
          replyContent, message.user.feedId);

      final fullPublicMessage = await bangumiTimelineService
          .getFullPublicMessage(message, BuiltMap());

      expect(
          fullPublicMessage.replies.first.contentHtml, contains(replyContent));

      await bangumiTimelineService.deleteTimeline(message.user.feedId);

      final PublicMessageNormal firstMessageAfterDeletionOrNull =
          firstOrNullInIterable<TimelineFeed>(
              (await getUserTimeline(userInfo)).feeds);

      expect(firstMessageAfterDeletionOrNull?.user?.feedId,
          isNot(equals(message.user.feedId)));
    });
  });
}
