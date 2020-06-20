import 'dart:async';
import 'dart:collection';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeUpdateType.dart';
import 'package:munin/models/bangumi/progress/common/InProgressCollection.dart';
import 'package:munin/models/bangumi/progress/common/InProgressSubjectInfo.dart';
import 'package:munin/models/bangumi/progress/html/SubjectEpisodes.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';

/// Get progress related actions
class GetProgressRequestAction {
  final BuildContext context;
  final BuiltSet<SubjectType> subjectTypes;
  final bool showSnackBar;

  final Completer completer;

  GetProgressRequestAction(
      {@required this.context,
      @required this.subjectTypes,
      Completer completer,
      this.showSnackBar = true})
      : this.completer = completer ?? Completer();

  /// A constructor that's used when a request is sent upon app launch.
  ///
  /// Some parameters are hidden since they are not available on app launch.
  GetProgressRequestAction.initialLaunch({@required this.subjectTypes})
      : this.completer = Completer(),
        this.showSnackBar = false,
        this.context = null;
}

class GetSubjectEpisodesRequestAction {
  final int subjectId;

  final Completer completer;

  GetSubjectEpisodesRequestAction({
    @required this.subjectId,
    Completer completer,
  }) : this.completer = completer ?? Completer();
}

class GetSubjectEpisodesSuccessAction {
  final SubjectEpisodes subjectEpisodes;
  final int subjectId;

  GetSubjectEpisodesSuccessAction({
    @required this.subjectEpisodes,
    @required this.subjectId,
  });
}

/// Deletes a in progress subject from store.
class DeleteInProgressSubjectAction {
  final SubjectType subjectType;
  final int subjectId;

  DeleteInProgressSubjectAction({
    @required this.subjectType,
    @required this.subjectId,
  });
}

class GetProgressSuccessAction {
  final BuiltSet<SubjectType> subjectTypes;
  final LinkedHashMap<SubjectType, LinkedHashMap<int, InProgressCollection>>
      progresses;

  GetProgressSuccessAction(
      {@required this.progresses, @required this.subjectTypes});
}

/// Action that updates progress of  in-progress episode/episodes.
/// This action updates episode progress as seen on progress widget. To update
/// episode status of episode as seen on subject episode widget,
/// use
abstract class UpdateProgressAction {
  final BuildContext context;

  final InProgressSubjectInfo subject;

  final Completer completer;

  UpdateProgressAction._(this.context, this.completer, this.subject);
}

class UpdateInProgressEpisodeAction implements UpdateProgressAction {
  final BuildContext context;

  /// The relevant subject instance
  final InProgressSubjectInfo subject;

  final Completer completer;

  final int episodeId;

  final EpisodeUpdateType episodeUpdateType;

  /// It's intended that here `newEpisodeNumber` is double,
  /// because for single episode `newEpisodeNumber` can be double, while for
  /// other progress update actions `newEpisodeNumber` must be int
  final double newEpisodeNumber;

  UpdateInProgressEpisodeAction({
    @required this.context,
    @required this.episodeId,
    @required this.episodeUpdateType,
    @required this.newEpisodeNumber,
    @required this.subject,
    Completer completer,
  })  : this.completer = completer ?? new Completer(),
        assert(episodeUpdateType != EpisodeUpdateType.CollectUntil);
}

class UpdateInProgressEpisodeSuccessAction {
  /// The relevant subject instance
  final InProgressSubjectInfo subject;
  final int episodeId;
  final EpisodeUpdateType episodeUpdateType;

  UpdateInProgressEpisodeSuccessAction({
    @required this.subject,
    @required this.episodeId,
    @required this.episodeUpdateType,
  });
}

class UpdateInProgressBatchEpisodesAction implements UpdateProgressAction {
  final BuildContext context;

  /// The relevant subject instance
  final InProgressSubjectInfo subject;

  final Completer completer;

  final EpisodeUpdateType episodeUpdateType;

  final int newEpisodeNumber;

  UpdateInProgressBatchEpisodesAction({
    @required this.context,
    @required this.newEpisodeNumber,
    @required this.subject,
    Completer completer,
  })  : this.completer = completer ?? new Completer(),
        this.episodeUpdateType = EpisodeUpdateType.CollectUntil;
}

class UpdateInProgressBatchEpisodesSuccessAction {
  /// The relevant subject instance
  final InProgressSubjectInfo subject;
  final int newEpisodeNumber;

  UpdateInProgressBatchEpisodesSuccessAction({
    @required this.subject,
    @required this.newEpisodeNumber,
  });
}

class UpdateBookProgressAction implements UpdateProgressAction {
  final BuildContext context;

  /// The relevant subject instance
  final InProgressSubjectInfo subject;

  final Completer completer;

  final int newEpisodeNumber;
  final int newVolumeNumber;

  UpdateBookProgressAction({
    @required this.context,
    @required this.newEpisodeNumber,
    @required this.newVolumeNumber,
    @required this.subject,
    Completer completer,
  }) : this.completer = completer ?? new Completer();

  String toActionSuccessString() {
    return '已读到${subject.name}的第$newEpisodeNumber话，第$newVolumeNumber卷';
  }
}

class UpdateBookProgressSuccessAction {
  /// The relevant subject instance
  final int subjectId;
  final int newEpisodeNumber;
  final int newVolumeNumber;

  UpdateBookProgressSuccessAction({
    @required this.subjectId,
    @required this.newEpisodeNumber,
    @required this.newVolumeNumber,
  });
}

/// Action that updates progress of any episode/episodes of a subject.
/// This action updates episode progress as seen on subject episode widget. To
/// update episode status of episode as seen on progress episode widget,
/// use [UpdateProgressAction].
class UpdateSubjectEpisodeAction {
  final BuildContext context;

  final int subjectId;
  final int episodeId;

  UpdateSubjectEpisodeAction({
    @required this.context,
    @required this.subjectId,
    @required this.episodeId,
  });
}

class UpdateSingleSubjectEpisodeAction extends UpdateSubjectEpisodeAction {
  final BuildContext context;
  final int subjectId;
  final int episodeId;
  final EpisodeUpdateType episodeUpdateType;

  UpdateSingleSubjectEpisodeAction({
    @required this.context,
    @required this.subjectId,
    @required this.episodeId,
    @required this.episodeUpdateType,
  });
}

class UpdateBatchSubjectEpisodesAction extends UpdateSubjectEpisodeAction {
  final BuildContext context;
  final int subjectId;
  final int episodeId;

  UpdateBatchSubjectEpisodesAction({
    @required this.context,
    @required this.subjectId,
    @required this.episodeId,
  });
}
