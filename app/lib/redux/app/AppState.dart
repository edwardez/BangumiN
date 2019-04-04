import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/BangumiUserBaic.dart';
import 'package:munin/redux/oauth/OauthState.dart';
import 'package:munin/redux/subject/SubjectState.dart';
import 'package:munin/redux/timeline/TimelineState.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'AppState.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  @nullable
  BangumiUserBasic get currentAuthenticatedUserBasicInfo;

  bool get isAuthenticated;

  OauthState get oauthState;

  TimelineState get timelineState;

  SubjectState get subjectState;

  factory AppState([updates(AppStateBuilder b)]) =>
      _$AppState((b) =>
      b
        ..oauthState.replace(OauthState())
        ..timelineState.replace(TimelineState())
        ..subjectState.replace(SubjectState())
        ..update(updates));

  AppState._();

  String toJson() {
    return json.encode(serializers.serializeWith(AppState.serializer, this));
  }

  static AppState fromJson(String jsonString) {
    return serializers.deserializeWith(
        AppState.serializer, json.decode(jsonString));
  }

  static Serializer<AppState> get serializer => _$appStateSerializer;
}
