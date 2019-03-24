import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:munin/models/Bangumi/BangumiCookieCredentials.dart';
import 'package:munin/models/Bangumi/BangumiUserAvatar.dart';
import 'package:munin/models/Bangumi/BangumiUserBaic.dart';
import 'package:munin/models/Bangumi/BangumiUserIdentity.dart';
import 'package:munin/models/Bangumi/common/Images.dart';
import 'package:munin/models/Bangumi/mono/Actor.dart';
import 'package:munin/models/Bangumi/mono/Character.dart';
import 'package:munin/models/Bangumi/subject/Count.dart';
import 'package:munin/models/Bangumi/subject/InfoBox/InfoBoxItem.dart';
import 'package:munin/models/Bangumi/subject/InfoBox/InfoBoxRow.dart';
import 'package:munin/models/Bangumi/subject/Rating.dart';
import 'package:munin/models/Bangumi/subject/RelatedSubject.dart';
import 'package:munin/models/Bangumi/subject/Subject.dart';
import 'package:munin/models/Bangumi/subject/comment/SubjectComment.dart';
import 'package:munin/models/Bangumi/subject/comment/SubjectCommentMetaInfo.dart';
import 'package:munin/models/Bangumi/subject/common/SubjectType.dart';
import 'package:munin/models/Bangumi/timeline/BlogCreationSingle.dart';
import 'package:munin/models/Bangumi/timeline/CollectionUpdateSingle.dart';
import 'package:munin/models/Bangumi/timeline/FriendshipCreationSingle.dart';
import 'package:munin/models/Bangumi/timeline/GroupJoinSingle.dart';
import 'package:munin/models/Bangumi/timeline/IndexFavoriteSingle.dart';
import 'package:munin/models/Bangumi/timeline/MonoFavoriteSingle.dart';
import 'package:munin/models/Bangumi/timeline/ProgressUpdateEpisodeSingle.dart';
import 'package:munin/models/Bangumi/timeline/ProgressUpdateEpisodeUntil.dart';
import 'package:munin/models/Bangumi/timeline/PublicMessageNoReply.dart';
import 'package:munin/models/Bangumi/timeline/PublicMessageNormal.dart';
import 'package:munin/models/Bangumi/timeline/StatusUpdateMultiple.dart';
import 'package:munin/models/Bangumi/timeline/UnknownTimelineActivity.dart';
import 'package:munin/models/Bangumi/timeline/WikiCreationSingle.dart';
import 'package:munin/models/Bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/models/Bangumi/timeline/common/FeedMetaInfo.dart';
import 'package:munin/models/Bangumi/timeline/common/HyperBangumiItem.dart';
import 'package:munin/models/Bangumi/timeline/common/HyperImage.dart';
import 'package:munin/models/Bangumi/timeline/common/TimelineFeed.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/oauth/OauthState.dart';
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
  SubjectState,
  Subject,
  SubjectType,
  Count,
  Rating,
  Images,
  Character,
  RelatedSubject,
  SubjectComment,
  SubjectCommentMetaInfo,
  Actor,
  InfoBoxRow,
  InfoBoxItem


])
final Serializers serializers =
(_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
