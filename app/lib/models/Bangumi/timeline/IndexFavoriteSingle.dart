import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/Bangumi/timeline/common/FeedMetaInfo.dart';
import 'package:munin/models/Bangumi/timeline/common/TimelineFeed.dart';

part 'IndexFavoriteSingle.g.dart';

abstract class IndexFavoriteSingle
    implements
        Built<IndexFavoriteSingle, IndexFavoriteSingleBuilder>,
        TimelineFeed {
  /// due to the limitation of bangumi, this has to be a string
  FeedMetaInfo get user;

  String get title;

  /// id of the index
  String get id;

  @nullable
  String get summary;

  IndexFavoriteSingle._();

  factory IndexFavoriteSingle([updates(IndexFavoriteSingleBuilder b)]) =
      _$IndexFavoriteSingle;

  static Serializer<IndexFavoriteSingle> get serializer =>
      _$indexFavoriteSingleSerializer;
}
