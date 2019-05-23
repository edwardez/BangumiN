import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/Images.dart';
import 'package:munin/models/bangumi/timeline/common/FeedMetaInfo.dart';
import 'package:munin/models/bangumi/timeline/common/Mono.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';

part 'MonoFavoriteSingle.g.dart';

abstract class MonoFavoriteSingle
    implements
        Built<MonoFavoriteSingle, MonoFavoriteSingleBuilder>,
        TimelineFeed {
  FeedMetaInfo get user;

  String get monoName;

  Images get avatar;

  /// id on bangumi page, i.e. for https://bgm.tv/character/1 , id is 1
  String get id;

  Mono get monoType;

  MonoFavoriteSingle._();

  factory MonoFavoriteSingle([updates(MonoFavoriteSingleBuilder b)]) =
      _$MonoFavoriteSingle;

  static Serializer<MonoFavoriteSingle> get serializer =>
      _$monoFavoriteSingleSerializer;
}
