import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/progress/api/InProgressAnimeOrRealCollection.dart';
import 'package:munin/models/bangumi/progress/common/InProgressCollection.dart';
import 'package:munin/models/bangumi/progress/html/SubjectEpisodes.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/providers/bangumi/progress/BangumiProgressService.dart';
import 'package:munin/redux/app/AppActions.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/progress/ProgressActions.dart';
import 'package:munin/redux/progress/common.dart';
import 'package:munin/shared/utils/misc/async.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

List<Epic<AppState>> createProgressEpics(
    BangumiProgressService bangumiProgressService) {
  final getProgressEpic = _createGetProgressEpic(bangumiProgressService);
  final updateProgressEpic = _createUpdateProgressEpic(bangumiProgressService);
  final getSubjectEpisodesEpic =
  _createGetSubjectEpisodesEpic(bangumiProgressService);

  final updateSubjectEpisodeEpic =
  _createUpdateSubjectEpisodeEpic(bangumiProgressService);
  return [
    getProgressEpic,
    updateProgressEpic,
    getSubjectEpisodesEpic,
    updateSubjectEpisodeEpic,
  ];
}

Stream<dynamic> _getProgress(BangumiProgressService bangumiProgressService,
    GetProgressRequestAction action, String username) async* {
  try {
    assert(action.subjectTypes.isNotEmpty);

    List<
        Future<
            LinkedHashMap<SubjectType,
                LinkedHashMap<int, InProgressCollection>>>> futures = [];

    /// If at least one valid watchable types are in action,
    /// execute the method to get watchable subjects
    if (SubjectType.validWatchableTypes
        .intersection(action.subjectTypes.toSet())
        .isNotEmpty) {
      futures.add(bangumiProgressService.getInProgressWatchableSubjectsFromApi(
          username: username, subjectTypes: action.subjectTypes));
    }

    List<LinkedHashMap<SubjectType, LinkedHashMap<int, InProgressCollection>>>
        subjectsPerType = await Future.wait(futures);

    LinkedHashMap<SubjectType, LinkedHashMap<int, InProgressCollection>>
        mergedSubjects = subjectsPerType.fold(
        LinkedHashMap<SubjectType,
            LinkedHashMap<int, InProgressCollection>>(),
            (mapSoFar, subjects) {
      mapSoFar.addAll(subjects);
      return mapSoFar;
    });

    yield GetProgressSuccessAction(
        progresses: mergedSubjects, subjectTypes: action.subjectTypes);
    action.completer.complete();
  } catch (error, stack) {
    print(error.toString());
    print(stack);
    action.completer.completeError(error, stack);

    yield HandleErrorAction(
      context: action.context,
      error: error,
      showErrorMessageSnackBar: action.showSnackBar,
    );
  }
}

Epic<AppState> _createGetProgressEpic(
    BangumiProgressService bangumiProgressService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<GetProgressRequestAction>())
        .switchMap((action) =>
        _getProgress(
          bangumiProgressService,
          action,
          store.state.currentAuthenticatedUserBasicInfo.username,
        ));
  };
}

Stream<dynamic> _getSubjectEpisodesEpic(
    BangumiProgressService bangumiProgressService,
    GetSubjectEpisodesRequestAction action,
    String username,) async* {
  try {
    SubjectEpisodes subjectEpisodes = await bangumiProgressService
        .getSubjectEpisodes(username: username, subjectId: action.subjectId);

    yield GetSubjectEpisodesSuccessAction(
      subjectEpisodes: subjectEpisodes,
      subjectId: action.subjectId,
    );
    action.completer.complete();
  } catch (error, stack) {
    print(error.toString());
    print(stack);
    action.completer.completeError(error);
  } finally {
    completeDanglingCompleter(action.completer);
  }
}

Epic<AppState> _createGetSubjectEpisodesEpic(
    BangumiProgressService bangumiProgressService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<GetSubjectEpisodesRequestAction>())
        .switchMap((action) =>
        _getSubjectEpisodesEpic(
          bangumiProgressService,
          action,
          store.state.currentAuthenticatedUserBasicInfo.username,
        ));
  };
}

/// Updates relevant subject progress as seen on progress widget.
Stream<dynamic> _updateProgress(BangumiProgressService bangumiProgressService,
    UpdateProgressAction action, EpicStore<AppState> store) async* {
  try {
    if (action is UpdateInProgressEpisodeAction) {
      await bangumiProgressService.updateSingleAnimeOrRealSingleEpisode(
          episodeId: action.episodeId,
          episodeUpdateType: action.episodeUpdateType);

      yield UpdateInProgressEpisodeSuccessAction(
        episodeId: action.episodeId,
        subject: action.subject,
        episodeUpdateType: action.episodeUpdateType,
      );
    } else if (action is UpdateInProgressBatchEpisodesAction) {
      InProgressCollection progress = store
          .state.progressState.progresses[action.subject.type]
          .firstWhere((subject) => subject.subject.id == action.subject.id);
      assert(progress != null);

      List<int> episodeIds = (progress as InProgressAnimeOrRealCollection)
          .episodes
          .values
          .fold<List<int>>([], (episodeIdsSoFar, episode) {
        if (isEpisodeProgressAffectedByCollectUntilOperation(
            episode, action.newEpisodeNumber)) {
          episodeIdsSoFar.add(episode.id);
        }

        return episodeIdsSoFar;
      });
      await bangumiProgressService.updateAnimeOrRealBatchEpisodes(
          episodeIds: episodeIds);
      yield UpdateInProgressBatchEpisodesSuccessAction(
          subject: action.subject, newEpisodeNumber: action.newEpisodeNumber);
    } else if (action is UpdateBookProgressAction) {
      await bangumiProgressService.updateBookProgress(
          subjectId: action.subject.id,
          newEpisodeNumber: action.newEpisodeNumber,
          newVolumeNumber: action.newVolumeNumber);
      yield UpdateBookProgressSuccessAction(
        subjectId: action.subject.id,
        newEpisodeNumber: action.newEpisodeNumber,
        newVolumeNumber: action.newVolumeNumber,
      );
      Scaffold.of(action.context).showSnackBar(
          SnackBar(content: Text(action.toActionSuccessString())));
    }
  } catch (error, stack) {
    print(error.toString());
    print(stack);
    yield HandleErrorAction(
      context: action.context,
      error: error,
      showErrorMessageSnackBar: false,
    );
  } finally {
    action.completer.complete();
  }
}

Epic<AppState> _createUpdateProgressEpic(
    BangumiProgressService bangumiProgressService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    /// concatMap should be used: user might update another subject while the first one is not finished yet
    return Observable(actions)
        .ofType(TypeToken<UpdateProgressAction>())
        .concatMap(
            (action) => _updateProgress(bangumiProgressService, action, store));
  };
}

/// Updates relevant subject episode as seen on subject episode widget.
Stream<dynamic> _updateSubjectEpisodeEpic(
    BangumiProgressService bangumiProgressService,
    UpdateSubjectEpisodeAction action,
    EpicStore<AppState> store) async* {

  /// Gets all episode ids that might be affected by [EpisodeUpdateType.CollectUntil].
  /// Different from [EpisodeProgress], [SimpleHtmlEpisode] which is inside [SubjectEpisodes]
  /// are only available on web page and don't have a valid [sequentialNumber].
  /// Thus we have to guess which episodes are affected by scanning through all
  /// available episodes. Fortunately, Bangumi web page lists all episodes in
  /// a sequential order so this logic should work most times.
  List<int> calculateCollectionUntilSubjectEpisodeIds({
    @required SubjectEpisodes subjectEpisodes,
    @required int collectedUntilEpisodeId,
  }) {
    List<int> episodeIds = [];

    for (var episode in subjectEpisodes.episodes.values) {
      if (isEpisodeAffectedByCollectUntilOperation(episode)
      ) {
        episodeIds.add(episode.id);
        assert(episode.id <= collectedUntilEpisodeId,
        'Munin tried to guess which episode to update for a [EpisodeUpdateType.CollectUntil]'
            ' but it seems like data is malformed. Id ${episode.id} is higher '
            'than current collectedUntilEpisodeId($collectedUntilEpisodeId) '
            'whike it should always be smaller.'
        );

        // Bangumi web page lists all episodes in sequential, breaks loop after
        // reaching the target episode id.
        if (episode.id == collectedUntilEpisodeId) {
          break;
        }
      }
    }
    return episodeIds;
  }

  try {
    if (action is UpdateSingleSubjectEpisodeAction) {
      await bangumiProgressService.updateSingleAnimeOrRealSingleEpisode(
          episodeId: action.episodeId,
          episodeUpdateType: action.episodeUpdateType);
    } else if (action is UpdateBatchSubjectEpisodesAction) {
      var subjectEpisodes = store.state.progressState.watchableSubjects[action
          .subjectId];

      List<int> episodeIdsToUpdate = calculateCollectionUntilSubjectEpisodeIds(
        subjectEpisodes: subjectEpisodes,
        collectedUntilEpisodeId: action.episodeId,
      );

      await bangumiProgressService.updateAnimeOrRealBatchEpisodes(
          episodeIds: episodeIdsToUpdate);
    } else {
      throw UnsupportedError('不支持的更新操作');
    }

    /// Re-retrieves data from bangumi server to reflect change on widget.
    yield GetSubjectEpisodesRequestAction(
      subjectId: action.subjectId,
    );
  } catch (error, stack) {
    print(error.toString());
    print(stack);
    yield HandleErrorAction(
      context: action.context,
      error: error,
      showErrorMessageSnackBar: false,
    );
  }
}

Epic<AppState> _createUpdateSubjectEpisodeEpic(
    BangumiProgressService bangumiProgressService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    /// concatMap should be used: user might update another subject while the first one is not finished yet
    return Observable(actions)
        .ofType(TypeToken<UpdateSubjectEpisodeAction>())
        .concatMap((action) =>
        _updateSubjectEpisodeEpic(bangumiProgressService, action, store));
  };
}
