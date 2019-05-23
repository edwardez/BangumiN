import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/timeline/common/FeedMetaInfo.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';

part 'CollectionUpdateSingle.g.dart';

abstract class CollectionUpdateSingle
    implements
        Built<CollectionUpdateSingle, CollectionUpdateSingleBuilder>,
        TimelineFeed {
  /// due to the limitation of bangumi, this has to be a string
  FeedMetaInfo get user;

  @nullable
  String get subjectComment;

  String get subjectId;

  @nullable
  String get subjectImageUrl;

  @nullable
  double get subjectScore;

  String get subjectName;

  CollectionUpdateSingle._();

  factory CollectionUpdateSingle([updates(CollectionUpdateSingleBuilder b)]) =
      _$CollectionUpdateSingle;

  static Serializer<CollectionUpdateSingle> get serializer =>
      _$collectionUpdateSingleSerializer;
}
