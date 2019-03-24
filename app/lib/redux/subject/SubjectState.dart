import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/Bangumi/subject/Subject.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'SubjectState.g.dart';

abstract class SubjectState
    implements Built<SubjectState, SubjectStateBuilder> {
  @nullable
  BuiltMap<int, Subject> get subjects;

  SubjectState._();

  /// TODO: check whether it'll be a performance issue to initialize map every time
  factory SubjectState([updates(SubjectStateBuilder b)]) =>
      _$SubjectState((b) => b
        ..subjects.replace(BuiltMap<int, Subject>())
        ..update(updates));

  String toJson() {
    return json
        .encode(serializers.serializeWith(SubjectState.serializer, this));
  }

  static SubjectState fromJson(String jsonString) {
    return serializers.deserializeWith(
        SubjectState.serializer, json.decode(jsonString));
  }

  static Serializer<SubjectState> get serializer => _$subjectStateSerializer;
}
