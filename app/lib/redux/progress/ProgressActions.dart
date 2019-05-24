import 'dart:async';
import 'dart:collection';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeUpdateType.dart';
import 'package:munin/models/bangumi/progress/common/InProgressCollection.dart';
import 'package:munin/models/bangumi/progress/common/InProgressSubjectInfo.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/redux/shared/CommonActions.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';

/// Get progress related actions
class GetProgressAction {
  final BuildContext context;
  final BuiltSet<SubjectType> subjectTypes;
  final bool showSnackBar;

  final Completer completer;

  GetProgressAction(
      {@required this.context,
      @required this.subjectTypes,
      Completer completer,
      this.showSnackBar = true})
      : this.completer = completer ?? new Completer();
}

class GetProgressLoadingAction {
  GetProgressLoadingAction();
}

class GetProgressSuccessAction {
  final BuiltSet<SubjectType> subjectTypes;
  final LinkedHashMap<SubjectType, LinkedHashMap<int, InProgressCollection>>
      progresses;

  GetProgressSuccessAction(
      {@required this.progresses, @required this.subjectTypes});
}

class GetProgressFailureAction extends FailureAction {
  final String username;

  GetProgressFailureAction(
      {@required this.username, @required LoadingStatus loadingStatus})
      : super(loadingStatus: loadingStatus);

  GetProgressFailureAction.fromUnknownException({@required this.username})
      : super.fromUnknownException();
}

/// Update progress related actions
abstract class UpdateProgressAction {
  final BuildContext context;

  /// The relevant subject instance
  final InProgressSubjectInfo subject;

  final Completer completer;

  UpdateProgressAction._(this.context, this.completer, this.subject);
}

class UpdateAnimeOrRealSingleEpisodeAction implements UpdateProgressAction {
  final int episodeId;
  final BuildContext context;
  final EpisodeUpdateType episodeUpdateType;

  /// It's intended that here `newEpisodeNumber` is double,
  /// because for single episode `newEpisodeNumber` can be double, while for
  /// other progress update actions `newEpisodeNumber` must be int
  final double newEpisodeNumber;

  final InProgressSubjectInfo subject;

  final Completer completer;

  UpdateAnimeOrRealSingleEpisodeAction(
      {@required this.context,
      @required this.episodeId,
      @required this.episodeUpdateType,
      @required this.newEpisodeNumber,
      @required this.subject,
      Completer completer})
      : this.completer = completer ?? new Completer(),
        assert(episodeUpdateType != EpisodeUpdateType.CollectUntil);
}

class UpdateAnimeOrRealSingleEpisodeSuccessAction {
  final InProgressSubjectInfo subject;
  final int episodeId;
  final EpisodeUpdateType episodeUpdateType;

  UpdateAnimeOrRealSingleEpisodeSuccessAction(
      {@required this.subject,
      @required this.episodeId,
      @required this.episodeUpdateType});
}

class UpdateAnimeOrRealBatchEpisodesAction implements UpdateProgressAction {
  final BuildContext context;
  final EpisodeUpdateType episodeUpdateType;

  final int newEpisodeNumber;
  final InProgressSubjectInfo subject;

  final Completer completer;

  UpdateAnimeOrRealBatchEpisodesAction(
      {@required this.context,
      @required this.newEpisodeNumber,
      @required this.subject,
      Completer completer})
      : this.completer = completer ?? new Completer(),
        this.episodeUpdateType = EpisodeUpdateType.CollectUntil;
}

class UpdateAnimeOrRealBatchEpisodesSuccessAction {
  final InProgressSubjectInfo subject;
  final int newEpisodeNumber;

  UpdateAnimeOrRealBatchEpisodesSuccessAction(
      {@required this.subject, @required this.newEpisodeNumber});
}

class UpdateBookProgressAction implements UpdateProgressAction {
  final BuildContext context;
  final int newEpisodeNumber;
  final int newVolumeNumber;
  final InProgressSubjectInfo subject;

  final Completer completer;

  UpdateBookProgressAction(
      {@required this.context,
      @required this.newEpisodeNumber,
      @required this.newVolumeNumber,
      @required this.subject,
      Completer completer})
      : this.completer = completer ?? new Completer();

  String toActionSuccessString() {
    return '已读到${subject.name}的第$newEpisodeNumber话，第$newVolumeNumber卷';
  }
}

class UpdateBookProgressSuccessAction {
  final InProgressSubjectInfo subject;
  final int newEpisodeNumber;
  final int newVolumeNumber;

  UpdateBookProgressSuccessAction(
      {@required this.subject,
      @required this.newEpisodeNumber,
      @required this.newVolumeNumber});
}
