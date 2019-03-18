import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:munin/models/Bangumi/BangumiCookieCredentials.dart';
import 'package:munin/models/Bangumi/BangumiUserAvatar.dart';
import 'package:munin/models/Bangumi/BangumiUserBaic.dart';
import 'package:munin/models/Bangumi/BangumiUserIdentity.dart';
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
  OauthState,
  TimelineState,
  FeedChunks,
  AppState,
])
final Serializers serializers =
(_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
