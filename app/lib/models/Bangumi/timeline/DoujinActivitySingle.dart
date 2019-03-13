import 'package:built_value/built_value.dart';
import 'package:munin/models/Bangumi/timeline/common/TimelineUserInfo.dart';

part 'DoujinActivitySingle.g.dart';

abstract class DoujinActivitySingle
    implements Built<DoujinActivitySingle, DoujinActivitySingleBuilder> {
  /// due to the limitation of bangumi, this has to be a string
  TimelineUserInfo get user;

  /// doujin event parser currently won't be implemented, a url will be used for now
  String get url;

  String get activityTargetName;

  @nullable
  String get imageUrl;

  DoujinActivitySingle._();

  factory DoujinActivitySingle([updates(DoujinActivitySingleBuilder b)]) =
      _$DoujinActivitySingle;
}
