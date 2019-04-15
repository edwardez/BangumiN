import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:munin/models/bangumi/BangumiCookieCredentials.dart';
import 'package:munin/models/bangumi/BangumiUserAvatar.dart';
import 'package:munin/models/bangumi/BangumiUserBaic.dart';
import 'package:munin/models/bangumi/BangumiUserIdentity.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/collection/CollectionStatusFromBangumi.dart';
import 'package:munin/models/bangumi/collection/SubjectCollectionInfo.dart';
import 'package:munin/models/bangumi/common/Images.dart';
import 'package:munin/models/bangumi/discussion/DiscussionItem.dart';
import 'package:munin/models/bangumi/discussion/FetchDiscussionRequest.dart';
import 'package:munin/models/bangumi/discussion/FetchDiscussionResponse.dart';
import 'package:munin/models/bangumi/discussion/enums/DiscussionType.dart';
import 'package:munin/models/bangumi/mono/Actor.dart';
import 'package:munin/models/bangumi/mono/Character.dart';
import 'package:munin/models/bangumi/search/SearchRequest.dart';
import 'package:munin/models/bangumi/search/SearchType.dart';
import 'package:munin/models/bangumi/search/result/BangumiGeneralSearchResponse.dart';
import 'package:munin/models/bangumi/search/result/BangumiSearchResponse.dart';
import 'package:munin/models/bangumi/search/result/MonoSearchResult.dart';
import 'package:munin/models/bangumi/search/result/SearchResult.dart';
import 'package:munin/models/bangumi/search/result/SubjectSearchResult.dart';
import 'package:munin/models/bangumi/search/result/UserSearchResult.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/models/bangumi/subject/Count.dart';
import 'package:munin/models/bangumi/subject/InfoBox/InfoBoxItem.dart';
import 'package:munin/models/bangumi/subject/InfoBox/InfoBoxRow.dart';
import 'package:munin/models/bangumi/subject/Rating.dart';
import 'package:munin/models/bangumi/subject/RelatedSubject.dart';
import 'package:munin/models/bangumi/subject/comment/ReviewMetaInfo.dart';
import 'package:munin/models/bangumi/subject/comment/SubjectReview.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/models/bangumi/timeline/BlogCreationSingle.dart';
import 'package:munin/models/bangumi/timeline/CollectionUpdateSingle.dart';
import 'package:munin/models/bangumi/timeline/FriendshipCreationSingle.dart';
import 'package:munin/models/bangumi/timeline/GroupJoinSingle.dart';
import 'package:munin/models/bangumi/timeline/IndexFavoriteSingle.dart';
import 'package:munin/models/bangumi/timeline/MonoFavoriteSingle.dart';
import 'package:munin/models/bangumi/timeline/ProgressUpdateEpisodeSingle.dart';
import 'package:munin/models/bangumi/timeline/ProgressUpdateEpisodeUntil.dart';
import 'package:munin/models/bangumi/timeline/PublicMessageNoReply.dart';
import 'package:munin/models/bangumi/timeline/PublicMessageNormal.dart';
import 'package:munin/models/bangumi/timeline/StatusUpdateMultiple.dart';
import 'package:munin/models/bangumi/timeline/UnknownTimelineActivity.dart';
import 'package:munin/models/bangumi/timeline/WikiCreationSingle.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/models/bangumi/timeline/common/FeedMetaInfo.dart';
import 'package:munin/models/bangumi/timeline/common/HyperBangumiItem.dart';
import 'package:munin/models/bangumi/timeline/common/HyperImage.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/discussion/DiscussionState.dart';
import 'package:munin/redux/oauth/OauthState.dart';
import 'package:munin/redux/search/SearchState.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';
import 'package:munin/redux/subject/SubjectState.dart';
import 'package:munin/redux/timeline/FeedChunks.dart';
import 'package:munin/redux/timeline/TimelineState.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  BangumiContent,
  BangumiUserBasic,
  BangumiUserAvatar,
  BangumiUserIdentity,
  BangumiCookieCredentials,
  BlogCreationSingle,
  CollectionUpdateSingle,
  FriendshipCreationSingle,
  GroupJoinSingle,
  IndexFavoriteSingle,
  MonoFavoriteSingle,
  ProgressUpdateEpisodeSingle,
  ProgressUpdateEpisodeUntil,
  PublicMessageNoReply,
  PublicMessageNormal,
  StatusUpdateMultiple,
  UnknownTimelineActivity,
  WikiCreationSingle,
  HyperBangumiItem,
  HyperImage,
  FeedMetaInfo,
  FeedChunks,
  AppState,
  OauthState,
  TimelineState,

  /// Subject
  LoadingStatus,
  BangumiSubject,
  SubjectType,
  Count,
  Rating,
  Images,
  Character,
  RelatedSubject,
  SubjectReview,
  ReviewMetaInfo,
  Actor,
  InfoBoxRow,
  InfoBoxItem,
  SubjectCollectionInfo,
  CollectionStatusFromBangumi,
  CollectionStatus,
  SubjectState,

  /// search
  BangumiSearchResponse,
  BangumiGeneralSearchResponse,
  SearchResult,
  MonoSearchResult,
  SubjectSearchResult,
  UserSearchResult,
  SearchRequest,
  SearchType,
  SearchState,

  /// Discussion
  DiscussionItem,
  DiscussionType,
  FetchDiscussionRequest,
  FetchDiscussionResponse,
  DiscussionState
])
final Serializers serializers =
(_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
