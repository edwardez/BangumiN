import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/progress/common/InProgressSubject.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'ProgressState.g.dart';

abstract class ProgressState
    implements Built<ProgressState, ProgressStateBuilder> {
  BuiltMap<SubjectType, BuiltList<InProgressSubject>> get progresses;

  factory ProgressState([updates(ProgressStateBuilder b)]) =>
      _$ProgressState((b) => b
        ..progresses
            .replace(BuiltMap<SubjectType, BuiltList<InProgressSubject>>())
        ..update(updates));

  ProgressState._();

  String toJson() {
    return json
        .encode(serializers.serializeWith(ProgressState.serializer, this));
  }

  static ProgressState fromJson(String jsonString) {
    return serializers.deserializeWith(
        ProgressState.serializer, json.decode(jsonString));
  }

  static Serializer<ProgressState> get serializer => _$progressStateSerializer;
}
