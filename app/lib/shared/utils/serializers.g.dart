// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(Actor.serializer)
      ..add(AirStatus.serializer)
      ..add(AppState.serializer)
      ..add(BangumiContent.serializer)
      ..add(BangumiCookieCredentials.serializer)
      ..add(BangumiGeneralSearchResponse.serializer)
      ..add(BangumiSubject.serializer)
      ..add(BangumiUserAvatar.serializer)
      ..add(BangumiUserBasic.serializer)
      ..add(BangumiUserIdentity.serializer)
      ..add(BlogCreationSingle.serializer)
      ..add(Character.serializer)
      ..add(CollectionPreview.serializer)
      ..add(CollectionStatus.serializer)
      ..add(CollectionStatusFromBangumi.serializer)
      ..add(CollectionUpdateSingle.serializer)
      ..add(Count.serializer)
      ..add(DiscussionItem.serializer)
      ..add(DiscussionState.serializer)
      ..add(DiscussionType.serializer)
      ..add(EpisodeProgress.serializer)
      ..add(EpisodeStatus.serializer)
      ..add(EpisodeType.serializer)
      ..add(FeedChunks.serializer)
      ..add(FeedMetaInfo.serializer)
      ..add(FetchDiscussionRequest.serializer)
      ..add(FetchDiscussionResponse.serializer)
      ..add(FetchTimelineRequest.serializer)
      ..add(FriendshipCreationSingle.serializer)
      ..add(GroupJoinSingle.serializer)
      ..add(HyperBangumiItem.serializer)
      ..add(HyperImage.serializer)
      ..add(Images.serializer)
      ..add(InProgressAnimeOrRealCollection.serializer)
      ..add(InProgressBookCollection.serializer)
      ..add(InProgressSubjectInfo.serializer)
      ..add(IndexFavoriteSingle.serializer)
      ..add(InfoBoxItem.serializer)
      ..add(InfoBoxRow.serializer)
      ..add(LoadingStatus.serializer)
      ..add(MonoFavoriteSingle.serializer)
      ..add(MonoSearchResult.serializer)
      ..add(NetworkServiceTagLink.serializer)
      ..add(NetworkServiceTagPlainText.serializer)
      ..add(NetworkServiceType.serializer)
      ..add(OauthState.serializer)
      ..add(ProgressState.serializer)
      ..add(ProgressUpdateEpisodeSingle.serializer)
      ..add(ProgressUpdateEpisodeUntil.serializer)
      ..add(PublicMessageNoReply.serializer)
      ..add(PublicMessageNormal.serializer)
      ..add(Rating.serializer)
      ..add(RelatedSubject.serializer)
      ..add(Relationship.serializer)
      ..add(ReviewMetaInfo.serializer)
      ..add(SearchRequest.serializer)
      ..add(SearchState.serializer)
      ..add(SearchType.serializer)
      ..add(StatusUpdateMultiple.serializer)
      ..add(SubjectCollectionInfo.serializer)
      ..add(SubjectPreview.serializer)
      ..add(SubjectReview.serializer)
      ..add(SubjectSearchResult.serializer)
      ..add(SubjectState.serializer)
      ..add(SubjectType.serializer)
      ..add(TimelineCategoryFilter.serializer)
      ..add(TimelinePreview.serializer)
      ..add(TimelineSource.serializer)
      ..add(TimelineState.serializer)
      ..add(UnknownTimelineActivity.serializer)
      ..add(UserProfile.serializer)
      ..add(UserSearchResult.serializer)
      ..add(UserState.serializer)
      ..add(WikiCreationSingle.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Actor)]),
          () => new ListBuilder<Actor>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Character)]),
          () => new ListBuilder<Character>())
      ..addBuilderFactory(
          const FullType(BuiltListMultimap,
              const [const FullType(String), const FullType(RelatedSubject)]),
          () => new ListMultimapBuilder<String, RelatedSubject>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(SubjectReview)]),
          () => new ListBuilder<SubjectReview>())
      ..addBuilderFactory(
          const FullType(BuiltListMultimap,
              const [const FullType(String), const FullType(InfoBoxItem)]),
          () => new ListMultimapBuilder<String, InfoBoxItem>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltListMultimap,
              const [const FullType(String), const FullType(InfoBoxItem)]),
          () => new ListMultimapBuilder<String, InfoBoxItem>())
      ..addBuilderFactory(
          const FullType(BuiltListMultimap,
              const [const FullType(String), const FullType(InfoBoxItem)]),
          () => new ListMultimapBuilder<String, InfoBoxItem>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(HyperImage)]),
          () => new ListBuilder<HyperImage>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(HyperBangumiItem)]),
          () => new ListBuilder<HyperBangumiItem>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(InfoBoxItem)]),
          () => new ListBuilder<InfoBoxItem>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(NetworkServiceTag)]),
          () => new ListBuilder<NetworkServiceTag>())
      ..addBuilderFactory(
          const FullType(BuiltMap,
              const [const FullType(SubjectType), const FullType(CollectionPreview)]),
          () => new MapBuilder<SubjectType, CollectionPreview>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(TimelinePreview)]),
          () => new ListBuilder<TimelinePreview>())
      ..addBuilderFactory(
          const FullType(BuiltSet, const [const FullType(Relationship)]),
          () => new SetBuilder<Relationship>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(TimelineFeed)]),
          () => new ListBuilder<TimelineFeed>())
      ..addBuilderFactory(
          const FullType(BuiltMap,
              const [const FullType(CollectionStatus), const FullType(int)]),
          () => new MapBuilder<CollectionStatus, int>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(CollectionStatus),
            const FullType(BuiltList, const [const FullType(SubjectPreview)])
          ]),
          () => new MapBuilder<CollectionStatus, BuiltList<SubjectPreview>>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(FetchDiscussionRequest),
            const FullType(FetchDiscussionResponse)
          ]),
          () =>
              new MapBuilder<FetchDiscussionRequest, FetchDiscussionResponse>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(FetchDiscussionRequest),
            const FullType(LoadingStatus)
          ]),
          () => new MapBuilder<FetchDiscussionRequest, LoadingStatus>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(FetchTimelineRequest),
            const FullType(FeedChunks)
          ]),
          () => new MapBuilder<FetchTimelineRequest, FeedChunks>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(SearchRequest),
            const FullType(BangumiSearchResponse)
          ]),
          () => new MapBuilder<SearchRequest, BangumiSearchResponse>())
      ..addBuilderFactory(
          const FullType(BuiltMap,
              const [const FullType(SearchRequest), const FullType(LoadingStatus)]),
          () => new MapBuilder<SearchRequest, LoadingStatus>())
      ..addBuilderFactory(const FullType(BuiltMap, const [const FullType(String), const FullType(UserProfile)]), () => new MapBuilder<String, UserProfile>())
      ..addBuilderFactory(const FullType(BuiltMap, const [const FullType(String), const FullType(LoadingStatus)]), () => new MapBuilder<String, LoadingStatus>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(SubjectType),
            const FullType(BuiltList, const [const FullType(InProgressSubject)])
          ]),
          () => new MapBuilder<SubjectType, BuiltList<InProgressSubject>>())
      ..addBuilderFactory(const FullType(BuiltMap, const [const FullType(int), const FullType(BangumiSubject)]), () => new MapBuilder<int, BangumiSubject>())
      ..addBuilderFactory(const FullType(BuiltMap, const [const FullType(int), const FullType(LoadingStatus)]), () => new MapBuilder<int, LoadingStatus>())
      ..addBuilderFactory(const FullType(BuiltMap, const [const FullType(int), const FullType(SubjectCollectionInfo)]), () => new MapBuilder<int, SubjectCollectionInfo>())
      ..addBuilderFactory(const FullType(BuiltMap, const [const FullType(int), const FullType(LoadingStatus)]), () => new MapBuilder<int, LoadingStatus>())
      ..addBuilderFactory(const FullType(BuiltMap, const [const FullType(int), const FullType(LoadingStatus)]), () => new MapBuilder<int, LoadingStatus>())
      ..addBuilderFactory(const FullType(BuiltMap, const [const FullType(int), const FullType(EpisodeProgress)]), () => new MapBuilder<int, EpisodeProgress>())
      ..addBuilderFactory(const FullType(BuiltMap, const [const FullType(int), const FullType(SearchResult)]), () => new MapBuilder<int, SearchResult>())
      ..addBuilderFactory(const FullType(BuiltSet, const [const FullType(DiscussionItem)]), () => new SetBuilder<DiscussionItem>()))
    .build();

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
