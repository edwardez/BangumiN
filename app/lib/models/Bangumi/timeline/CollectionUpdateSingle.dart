import 'package:built_value/built_value.dart';
import 'package:munin/models/Bangumi/timeline/common/TimelineUserInfo.dart';

part 'CollectionUpdateSingle.g.dart';

abstract class CollectionUpdateSingle
    implements Built<CollectionUpdateSingle, CollectionUpdateSingleBuilder> {
  /// due to the limitation of bangumi, this has to be a string
  TimelineUserInfo get user;

  String get subjectComment;

  int get subjectId;

  String get subjectImageUrl;

  double get subjectScore;

  String get subjectTitle;

  CollectionUpdateSingle._();

  factory CollectionUpdateSingle([updates(CollectionUpdateSingleBuilder b)]) =
      _$CollectionUpdateSingle;
}
