import 'package:built_value/built_value.dart';
import 'package:munin/models/bangumi/common/Images.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';

part 'DiscussionItem.g.dart';

/// a base Discussion interface
@BuiltValue(instantiable: false)
abstract class DiscussionItem {
  int get id;

  BangumiContent get bangumiContent;

  Images get images;

  /// For person/character, it's person/character name
  /// For episode, it's episode name
  /// For group topic/subject topic, it's postName
  String get title;

  /// For person/character, it's a fixed string: person/character
  /// For episode/subject topic, it's subject name
  /// For group topic, it's group name
  String get subTitle;

  int get replyCount;

  @nullable
  int get updatedAt;

  DiscussionItem rebuild(void updates(DiscussionItemBuilder b));

  DiscussionItemBuilder toBuilder();
}
