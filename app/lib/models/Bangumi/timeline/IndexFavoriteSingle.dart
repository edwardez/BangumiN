import 'package:built_value/built_value.dart';
import 'package:munin/models/Bangumi/timeline/common/TimelineUserInfo.dart';

part 'IndexFavoriteSingle.g.dart';

abstract class IndexFavoriteSingle
    implements Built<IndexFavoriteSingle, IndexFavoriteSingleBuilder> {
  /// due to the limitation of bangumi, this has to be a string
  TimelineUserInfo get user;

  String get title;

  /// id of the index
  int get id;

  String get summary;

  IndexFavoriteSingle._();

  factory IndexFavoriteSingle([updates(IndexFavoriteSingleBuilder b)]) =
      _$IndexFavoriteSingle;
}
