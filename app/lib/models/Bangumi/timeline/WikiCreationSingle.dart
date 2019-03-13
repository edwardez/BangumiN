import 'package:built_value/built_value.dart';
import 'package:munin/models/Bangumi/timeline/common/TimelineUserInfo.dart';

part 'WikiCreationSingle.g.dart';

abstract class WikiCreationSingle
    implements Built<WikiCreationSingle, WikiCreationSingleBuilder> {
  TimelineUserInfo get user;

  String get newItemName;

  int get newItemId;

  WikiCreationSingle._();

  factory WikiCreationSingle([updates(WikiCreationSingleBuilder b)]) =
      _$WikiCreationSingle;
}
