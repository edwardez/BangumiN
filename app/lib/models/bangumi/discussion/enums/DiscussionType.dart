import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'DiscussionType.g.dart';

class DiscussionType extends EnumClass {
  /// web: https://bgm.tv/rakuen/topiclist
  static const DiscussionType Rakuen = _$Rakuen;

  /// web: https://bgm.tv/group
  static const DiscussionType Group = _$Group;

  const DiscussionType._(String name) : super(name);

  static BuiltSet<DiscussionType> get values => _$values;

  static DiscussionType valueOf(String name) => _$valueOf(name);

  static Serializer<DiscussionType> get serializer =>
      _$discussionTypeSerializer;
}
