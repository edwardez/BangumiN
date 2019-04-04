// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(Actor.serializer)
      ..add(AppState.serializer)
      ..add(BangumiContent.serializer)
      ..add(BangumiCookieCredentials.serializer)
      ..add(BangumiSubject.serializer)
      ..add(BangumiUserAvatar.serializer)
      ..add(BangumiUserBasic.serializer)
      ..add(BangumiUserIdentity.serializer)
      ..add(BlogCreationSingle.serializer)
      ..add(Character.serializer)
      ..add(CollectionStatus.serializer)
      ..add(CollectionStatusFromBangumi.serializer)
      ..add(CollectionUpdateSingle.serializer)
      ..add(Count.serializer)
      ..add(FeedChunks.serializer)
      ..add(FeedMetaInfo.serializer)
      ..add(FriendshipCreationSingle.serializer)
      ..add(GroupJoinSingle.serializer)
      ..add(HyperBangumiItem.serializer)
      ..add(HyperImage.serializer)
      ..add(Images.serializer)
      ..add(IndexFavoriteSingle.serializer)
      ..add(InfoBoxItem.serializer)
      ..add(InfoBoxRow.serializer)
      ..add(LoadingStatus.serializer)
      ..add(MonoFavoriteSingle.serializer)
      ..add(OauthState.serializer)
      ..add(ProgressUpdateEpisodeSingle.serializer)
      ..add(ProgressUpdateEpisodeUntil.serializer)
      ..add(PublicMessageNoReply.serializer)
      ..add(PublicMessageNormal.serializer)
      ..add(Rating.serializer)
      ..add(RelatedSubject.serializer)
      ..add(StatusUpdateMultiple.serializer)
      ..add(SubjectCollectionInfo.serializer)
      ..add(SubjectComment.serializer)
      ..add(SubjectCommentMetaInfo.serializer)
      ..add(SubjectState.serializer)
      ..add(SubjectType.serializer)
      ..add(TimelineState.serializer)
      ..add(UnknownTimelineActivity.serializer)
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
          const FullType(BuiltList, const [const FullType(SubjectComment)]),
          () => new ListBuilder<SubjectComment>())
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
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(TimelineFeed)]),
          () => new ListBuilder<TimelineFeed>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(TimelineFeed)]),
          () => new ListBuilder<TimelineFeed>())
      ..addBuilderFactory(
          const FullType(BuiltMap,
              const [const FullType(int), const FullType(BangumiSubject)]),
          () => new MapBuilder<int, BangumiSubject>())
      ..addBuilderFactory(
          const FullType(BuiltMap,
              const [const FullType(int), const FullType(LoadingStatus)]),
          () => new MapBuilder<int, LoadingStatus>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(int),
            const FullType(SubjectCollectionInfo)
          ]),
          () => new MapBuilder<int, SubjectCollectionInfo>())
      ..addBuilderFactory(
          const FullType(BuiltMap,
              const [const FullType(int), const FullType(LoadingStatus)]),
          () => new MapBuilder<int, LoadingStatus>())
      ..addBuilderFactory(
          const FullType(BuiltMap,
              const [const FullType(int), const FullType(LoadingStatus)]),
          () => new MapBuilder<int, LoadingStatus>()))
    .build();

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
