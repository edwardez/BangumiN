import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/Bangumi/common/Images.dart';
import 'package:munin/models/Bangumi/common/ItemMetaInfo.dart';

part 'SubjectCommentMetaInfo.g.dart';

abstract class SubjectCommentMetaInfo
    implements
        ItemMetaInfo,
        Built<SubjectCommentMetaInfo, SubjectCommentMetaInfoBuilder> {
  @nullable
  Images get images;

  @nullable
  double get score;

  SubjectCommentMetaInfo._();

  factory SubjectCommentMetaInfo([updates(SubjectCommentMetaInfoBuilder b)]) =
      _$SubjectCommentMetaInfo;

  static Serializer<SubjectCommentMetaInfo> get serializer =>
      _$subjectCommentMetaInfoSerializer;
}
