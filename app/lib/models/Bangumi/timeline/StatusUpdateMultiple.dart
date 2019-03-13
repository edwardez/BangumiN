import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:munin/models/Bangumi/timeline/common/HyperBangumiItem.dart';
import 'package:munin/models/Bangumi/timeline/common/HyperImage.dart';
import 'package:munin/models/Bangumi/timeline/common/TimelineUserInfo.dart';

part 'StatusUpdateMultiple.g.dart';

/// this can be the most tricky status update type among all
/// It can be used to represent: subject, book, anime, music, person favorite,
/// character favorite, friendship, doujin activities, group join... that are merged by bangumi into one
/// on user profile page, all links to text and images will be shown so length of
/// hyperImages and hyperTexts should always be the same as long as all subjects
/// have a cover
/// However on the main timeline, bangumi omits some hyperImages/hyperTexts so
/// length might not be the same
abstract class StatusUpdateMultiple
    implements Built<StatusUpdateMultiple, StatusUpdateMultipleBuilder> {
  /// due to the limitation of bangumi, this has to be a string
  TimelineUserInfo get user;

  BuiltList<HyperImage> get hyperImages;

  BuiltList<HyperBangumiItem> get hyperBangumiItems;

  StatusUpdateMultiple._();

  factory StatusUpdateMultiple([updates(StatusUpdateMultipleBuilder b)]) =
      _$StatusUpdateMultiple;
}
