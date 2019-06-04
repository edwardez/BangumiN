import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/subject/common/SujectBase.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'ThreadParentSubject.g.dart';

abstract class ThreadParentSubject
    implements
        SubjectBase,
        Built<ThreadParentSubject, ThreadParentSubjectBuilder> {
  BangumiImage get cover;

  ThreadParentSubject._();

  factory ThreadParentSubject(
          [void Function(ThreadParentSubjectBuilder) updates]) =
      _$ThreadParentSubject;

  String toJson() {
    return json.encode(
        serializers.serializeWith(ThreadParentSubject.serializer, this));
  }

  static ThreadParentSubject fromJson(String jsonString) {
    return serializers.deserializeWith(
        ThreadParentSubject.serializer, json.decode(jsonString));
  }

  static Serializer<ThreadParentSubject> get serializer =>
      _$threadParentSubjectSerializer;
}
