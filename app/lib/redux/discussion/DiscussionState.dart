import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionRequest.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionResponse.dart';
import 'package:munin/models/bangumi/discussion/thread/blog/BlogThread.dart';
import 'package:munin/models/bangumi/discussion/thread/common/GetThreadRequest.dart';
import 'package:munin/models/bangumi/discussion/thread/episode/EpisodeThread.dart';
import 'package:munin/models/bangumi/discussion/thread/group/GroupThread.dart';
import 'package:munin/models/bangumi/discussion/thread/subject/SubjectTopicThread.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'DiscussionState.g.dart';

abstract class DiscussionState
    implements Built<DiscussionState, DiscussionStateBuilder> {
  BuiltMap<GetDiscussionRequest, GetDiscussionResponse> get discussions;

  /// A list of all threads that are posted in a group.
  /// Key is thread id.
  BuiltMap<int, GroupThread> get groupThreads;

  /// A list of all threads that are under some episodes.
  /// Key is thread id.
  BuiltMap<int, EpisodeThread> get episodeThreads;

  /// A list of all threads that are under some subjects.
  /// Key is thread id.
  BuiltMap<int, SubjectTopicThread> get subjectTopicThreads;

  /// A list of all threads that are posted as blog.
  /// Key is thread id.
  BuiltMap<int, BlogThread> get blogThreads;


  @nullable
  BuiltMap<GetThreadRequest, LoadingStatus> get getThreadLoadingStatus;

  bool shouldFetchResponse(GetDiscussionRequest request) {
    return discussions[request] == null || discussions[request].isStale;
  }

  factory DiscussionState([updates(DiscussionStateBuilder b)]) =>
      _$DiscussionState((b) => b
        ..discussions
            .replace(BuiltMap<GetDiscussionRequest, GetDiscussionResponse>())
        ..groupThreads.replace(BuiltMap<int, GroupThread>())
        ..episodeThreads.replace(BuiltMap<int, EpisodeThread>())
        ..subjectTopicThreads.replace(BuiltMap<int, SubjectTopicThread>())
        ..blogThreads.replace(BuiltMap<int, BlogThread>())
        ..getThreadLoadingStatus
            .replace(BuiltMap<GetThreadRequest, LoadingStatus>())
        ..update(updates));

  DiscussionState._();

  String toJson() {
    return json
        .encode(serializers.serializeWith(DiscussionState.serializer, this));
  }

  static DiscussionState fromJson(String jsonString) {
    return serializers.deserializeWith(
        DiscussionState.serializer, json.decode(jsonString));
  }

  static Serializer<DiscussionState> get serializer =>
      _$discussionStateSerializer;
}
