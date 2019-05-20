import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:munin/models/bangumi/timeline/common/FeedLoadType.dart';
import 'package:munin/models/bangumi/timeline/common/FetchTimelineRequest.dart';
import 'package:munin/providers/bangumi/BangumiCookieService.dart';
import 'package:munin/providers/bangumi/timeline/parser/TimelineParser.dart';

/// bangumi returns 10 feeds each time, this currently cannot be changed
const int feedsPerPage = 10;

const int initialPageNum = 1;

// A Bangumi user service that handles user-related http requests and persist relevant info
class BangumiTimelineService {
  BangumiCookieService cookieClient;

  BangumiTimelineService({@required this.cookieClient})
      : assert(cookieClient != null);

  // get bangumi user basic info through api
  Future<FetchFeedsResult> getTimeline({@required FetchTimelineRequest fetchTimelineRequest,
    @required int nextPageNum,
    @required FeedLoadType feedLoadType,
    @required int upperFeedId,
    @required int lowerFeedId,
    @required BuiltMap<String, MutedUser> mutedUsers,
  }) async {
    Map<String, dynamic> queryParameters = {'ajax': '1'};

    if (nextPageNum != null) {
      queryParameters['page'] = nextPageNum;
    }

    queryParameters['type'] = fetchTimelineRequest
        .timelineCategoryFilter.toBangumiQueryParameterValue;

    Response feedsHtml = await cookieClient.dio
        .get('/timeline', queryParameters: queryParameters);

    TimelineParser timelineParser = TimelineParser();

    FetchFeedsResult fetchFeedsResult = timelineParser.process(
        feedsHtml.data,
        feedLoadType: feedLoadType,
        upperFeedId: upperFeedId,
        lowerFeedId: lowerFeedId,
        mutedUsers: mutedUsers
    );

    return fetchFeedsResult;
  }
}
