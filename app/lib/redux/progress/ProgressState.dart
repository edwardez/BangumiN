import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/progress/common/InProgressCollection.dart';
import 'package:munin/models/bangumi/progress/html/SubjectEpisodes.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'ProgressState.g.dart';

abstract class ProgressState
    implements Built<ProgressState, ProgressStateBuilder> {
  /// Maps of subjects that user is currently watching.
  /// Only subjects with [CollectionStatus.Do] is supposed to be stored
  /// in [progresses].
  BuiltMap<SubjectType, BuiltList<InProgressCollection>> get progresses;

  /// Maps of any subjects, and all of its episodes, regardless of user's [CollectionStatus]
  /// of the corresponding subject.
  /// Key is subject id.
  BuiltMap<int, SubjectEpisodes> get watchableSubjects;

  /// Loading status of subject episodes.
  BuiltMap<int, LoadingStatus> get subjectsLoadingStatus;

  factory ProgressState([updates(ProgressStateBuilder b)]) =>
      _$ProgressState((b) => b
        ..progresses
            .replace(BuiltMap<SubjectType, BuiltList<InProgressCollection>>())
        ..watchableSubjects
            .replace(BuiltMap<int, SubjectEpisodes>())
        ..subjectsLoadingStatus
            .replace(BuiltMap<int, LoadingStatus>())
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
