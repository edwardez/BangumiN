import 'dart:collection';

import 'package:built_collection/built_collection.dart';
import 'package:munin/models/bangumi/progress/api/EpisodeProgress.dart';
import 'package:munin/models/bangumi/progress/api/InProgressAnimeOrRealCollection.dart';
import 'package:munin/models/bangumi/progress/api/InProgressBookCollection.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeStatus.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeUpdateType.dart';
import 'package:munin/models/bangumi/progress/common/InProgressCollection.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/redux/progress/ProgressActions.dart';
import 'package:munin/redux/progress/ProgressState.dart';
import 'package:munin/redux/progress/common.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';
import 'package:redux/redux.dart';

final progressReducers = combineReducers<ProgressState>([
  TypedReducer<ProgressState, GetSubjectEpisodesLoadingAction>(
      getSubjectEpisodesLoadingReducer),
  TypedReducer<ProgressState, GetSubjectEpisodesFailureAction>(
      getSubjectEpisodesFailureReducer),
  TypedReducer<ProgressState, GetSubjectEpisodesSuccessAction>(
      getSubjectEpisodesSuccessReducer),
  TypedReducer<ProgressState, GetProgressSuccessAction>(
      getProgressSuccessReducer),
  TypedReducer<ProgressState, UpdateInProgressEpisodeSuccessAction>(
      updateInProgressEpisodeSuccessReducer),
  TypedReducer<ProgressState, UpdateInProgressBatchEpisodesSuccessAction>(
      updateInProgressBatchEpisodesSuccessReducer),
  TypedReducer<ProgressState, UpdateBookProgressSuccessAction>(
      updateBookProgressSuccessReducer),
]);

ProgressState getSubjectEpisodesLoadingReducer(ProgressState progressState,
    GetSubjectEpisodesLoadingAction action) {
  return progressState.rebuild((b) =>
  b
    ..subjectsLoadingStatus.addAll({
      action.subjectId: LoadingStatus.Loading,
    }));
}

ProgressState getSubjectEpisodesFailureReducer(ProgressState progressState,
    GetSubjectEpisodesFailureAction action) {
  return progressState.rebuild((b) =>
  b
    ..subjectsLoadingStatus.addAll({
      action.subjectId: action.loadingStatus,
    }));
}

ProgressState getSubjectEpisodesSuccessReducer(ProgressState progressState,
    GetSubjectEpisodesSuccessAction action) {
  return progressState.rebuild((b) =>
  b
    ..watchableSubjects.addAll(
      {action.subjectId: action.subjectEpisodes},
    ));
}

ProgressState getProgressSuccessReducer(ProgressState progressState,
    GetProgressSuccessAction getProgressSuccessAction) {
  for (SubjectType type in getProgressSuccessAction.subjectTypes) {
    LinkedHashMap<int, InProgressCollection> subjects =
        getProgressSuccessAction.progresses[type];

    assert(subjects != null);
    if (subjects == null) {
      continue;
    }

    progressState = progressState.rebuild((b) => b
      ..progresses
          .addAll({type: BuiltList<InProgressCollection>(subjects.values)}));
  }

  return progressState;
}

ProgressState updateInProgressEpisodeSuccessReducer(
    ProgressState progressState,
    UpdateInProgressEpisodeSuccessAction action) {
  Iterable<InProgressCollection> progresses = progressState
      .progresses[action.subject.type]
      .map<InProgressCollection>((InProgressCollection progress) {
    if (progress.subject.id == action.subject.id &&
        progress is InProgressAnimeOrRealCollection) {
      EpisodeStatus prevEpisodeStatus;
      EpisodeProgress newEpisodeProgress =
          progress.episodes[action.episodeId].rebuild((b) {
        prevEpisodeStatus = b.userEpisodeStatus;
        return b
          ..userEpisodeStatus =
              action.episodeUpdateType.destinationEpisodeStatus;
      });

      InProgressCollection newInProgressSubject = progress.rebuild((b) =>
      b
        ..episodes.addAll({action.episodeId: newEpisodeProgress})
        ..completedEpisodesCount += EpisodeUpdateType.watchedEpisodeCountChange(
            prevEpisodeStatus, action.episodeUpdateType));
      return newInProgressSubject;
    }

    return progress;
  });

  return progressState.rebuild((b) => b
    ..progresses.addAll(
        {action.subject.type: BuiltList<InProgressCollection>(progresses)}));
}

ProgressState updateInProgressBatchEpisodesSuccessReducer(
    ProgressState progressState,
    UpdateInProgressBatchEpisodesSuccessAction action) {
  Iterable<InProgressCollection> progresses = progressState
      .progresses[action.subject.type]
      .map<InProgressCollection>((InProgressCollection progress) {
    if (progress.subject.id == action.subject.id &&
        progress is InProgressAnimeOrRealCollection) {
      LinkedHashMap<int, EpisodeProgress> updatedEpisodes = LinkedHashMap();

      /// total number of changed episodes to add to completedEpisodesCount
      int totalChangedEpisodesCountToAdd = 0;
      for (var episode in progress.episodes.values) {
        if (isEpisodeProgressAffectedByCollectUntilOperation(
            episode, action.newEpisodeNumber)) {
          totalChangedEpisodesCountToAdd +=
              EpisodeUpdateType.watchedEpisodeCountChange(
                  episode.userEpisodeStatus, EpisodeUpdateType.Collect);
          episode = episode
              .rebuild((b) => b..userEpisodeStatus = EpisodeStatus.Collect);
          updatedEpisodes[episode.id] = episode;
        } else {
          updatedEpisodes[episode.id] = episode;
        }
      }

      return progress.rebuild((b) => b
        ..episodes.replace(updatedEpisodes)
        ..completedEpisodesCount += totalChangedEpisodesCountToAdd);
    }

    return progress;
  });

  return progressState.rebuild((b) => b
    ..progresses.addAll(
        {action.subject.type: BuiltList<InProgressCollection>(progresses)}));
}

ProgressState updateBookProgressSuccessReducer(
    ProgressState progressState, UpdateBookProgressSuccessAction action) {
  Iterable<InProgressCollection> progresses = progressState
      .progresses[action.subject.type]
      .map<InProgressCollection>((InProgressCollection progress) {
    if (progress.subject.id == action.subject.id &&
        progress is InProgressBookCollection) {
      InProgressBookCollection newEpisodeProgress = progress.rebuild((b) => b
        ..completedEpisodesCount = action.newEpisodeNumber
        ..completedVolumesCount = action.newVolumeNumber);
      return newEpisodeProgress;
    }

    return progress;
  });

  return progressState.rebuild((b) => b
    ..progresses.addAll(
        {action.subject.type: BuiltList<InProgressCollection>(progresses)}));
}
