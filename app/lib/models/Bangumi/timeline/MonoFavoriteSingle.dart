import 'package:built_value/built_value.dart';
import 'package:munin/models/Bangumi/timeline/common/TimelineUserInfo.dart';

part 'MonoFavoriteSingle.g.dart';

abstract class MonoFavoriteSingle
    implements Built<MonoFavoriteSingle, MonoFavoriteSingleBuilder> {
  TimelineUserInfo get user;

  String get monoName;

  String get monoAvatarImageUrl;

  int get monoId;

  MonoFavoriteSingle._();

  factory MonoFavoriteSingle([updates(MonoFavoriteSingleBuilder b)]) =
      _$MonoFavoriteSingle;
}
