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
import 'package:munin/models/bangumi/discussion/enums/RakuenFilter.dart';
import 'package:munin/models/bangumi/discussion/enums/base.dart';
import 'package:munin/models/bangumi/mono/Actor.dart';
import 'package:munin/models/bangumi/mono/Character.dart';
import 'package:munin/models/bangumi/progress/api/EpisodeProgress.dart';
import 'package:munin/models/bangumi/progress/api/InProgressAnimeOrRealCollection.dart';
import 'package:munin/models/bangumi/progress/api/InProgressBookCollection.dart';
import 'package:munin/models/bangumi/progress/common/AirStatus.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeStatus.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeType.dart';
import 'package:munin/models/bangumi/progress/common/InProgressSubject.dart';
import 'package:munin/models/bangumi/progress/common/InProgressSubjectInfo.dart';
import 'package:munin/models/bangumi/search/SearchRequest.dart';
import 'package:munin/models/bangumi/search/SearchType.dart';
import 'package:munin/models/bangumi/search/result/BangumiGeneralSearchResponse.dart';
import 'package:munin/models/bangumi/search/result/BangumiSearchResponse.dart';
import 'package:munin/models/bangumi/search/result/MonoSearchResult.dart';
import 'package:munin/models/bangumi/search/result/SearchResult.dart';
import 'package:munin/models/bangumi/search/result/SubjectSearchResult.dart';
import 'package:munin/models/bangumi/search/result/UserSearchResult.dart';
import 'package:munin/models/bangumi/setting/MuninTheme.dart';
import 'package:munin/models/bangumi/setting/ThemeSetting.dart';
import 'package:munin/models/bangumi/setting/ThemeSwitchMode.dart';
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
import 'package:munin/models/bangumi/timeline/common/FetchTimelineRequest.dart';
import 'package:munin/models/bangumi/timeline/common/HyperBangumiItem.dart';
import 'package:munin/models/bangumi/timeline/common/HyperImage.dart';
import 'package:munin/models/bangumi/timeline/common/Mono.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineCategoryFilter.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineSource.dart';
import 'package:munin/models/bangumi/user/Relationship.dart';
import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/models/bangumi/user/collection/CollectionPreview.dart';
import 'package:munin/models/bangumi/user/collection/SubjectPreview.dart';
import 'package:munin/models/bangumi/user/social/NetworkServiceTag.dart';
import 'package:munin/models/bangumi/user/social/NetworkServiceTagLink.dart';
import 'package:munin/models/bangumi/user/social/NetworkServiceTagPlainText.dart';
import 'package:munin/models/bangumi/user/social/NetworkServiceType.dart';
import 'package:munin/models/bangumi/user/timeline/TimelinePreview.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/app/BasicAppState.dart';
import 'package:munin/redux/discussion/DiscussionState.dart';
import 'package:munin/redux/oauth/OauthState.dart';
import 'package:munin/redux/progress/ProgressState.dart';
import 'package:munin/redux/search/SearchState.dart';
import 'package:munin/redux/setting/SettingState.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';
import 'package:munin/redux/subject/SubjectState.dart';
import 'package:munin/redux/timeline/FeedChunks.dart';
import 'package:munin/redux/timeline/TimelineState.dart';
import 'package:munin/redux/user/UserState.dart';

part 'serializers.g.dart';

@SerializersFor(const [

  /// Top level state
  AppState,

  /// If [AppState] is serialized, it's recommended to serialize [BasicAppState], too
  BasicAppState,

  /// Oauth
  OauthState,

  /// Common
  BangumiContent,

  /// Timeline
  TimelineState,
  FetchTimelineRequest,
  TimelineCategoryFilter,
  TimelineSource,
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

  /// Subject
  LoadingStatus,
  BangumiSubject,
  SubjectType,
  Count,
  Rating,
  Images,
  Character,
  Mono,
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

  /// Search
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
  DiscussionFilter,
  RakuenTopicFilter,
  FetchDiscussionRequest,
  FetchDiscussionResponse,
  DiscussionState,


  /// User
  UserProfile,
  NetworkServiceTag,
  NetworkServiceTagLink,
  NetworkServiceTagPlainText,
  NetworkServiceType,
  SubjectPreview,
  CollectionPreview,
  TimelinePreview,
  Relationship,
  UserState,


  /// Progress
  ProgressState,
  InProgressSubject,
  EpisodeProgress,
  InProgressAnimeOrRealCollection,
  InProgressBookCollection,
  InProgressSubject,
  InProgressSubjectInfo,
  EpisodeStatus,
  EpisodeType,
  AirStatus,

  /// Settings
  SettingState,
  ThemeSetting,
  MuninTheme,
  ThemeSwitchMode,
])
final Serializers serializers =
(_$serializers.toBuilder()
  ..addBuilderFactory(
      FullType(BuiltList, [ FullType(SubjectPreview)]),
          () => ListBuilder<SubjectPreview>())..addBuilderFactory(
      FullType(BuiltList, [ FullType(InProgressSubject)]),
          () => ListBuilder<InProgressSubject>())
  ..addPlugin(StandardJsonPlugin())

)
    .build();
