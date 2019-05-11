import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/progress/api/InProgressAnimeOrRealCollection.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeType.dart';
import 'package:munin/models/bangumi/progress/common/InProgressSubject.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/providers/bangumi/progress/BangumiProgressService.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/progress/ProgressActions.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

List<Epic<AppState>> createProgressEpics(
    BangumiProgressService bangumiProgressService) {
  final getProgressEpic = _createGetProgressEpic(bangumiProgressService);
  final updateProgressEpic = _createUpdateProgressEpic(bangumiProgressService);

  return [getProgressEpic, updateProgressEpic];
}

Stream<dynamic> _getProgress(BangumiProgressService bangumiProgressService,
    GetProgressAction action, String username) async* {
  try {
    assert(action.subjectTypes.isNotEmpty);

    yield GetProgressLoadingAction();

    List<
        Future<
            LinkedHashMap<SubjectType,
                LinkedHashMap<int, InProgressSubject>>>> futures = [];

    /// If at least one valid watchable types are in action,
    /// execute the method to get watchable subjects
    if (SubjectType.validWatchableTypes
        .intersection(action.subjectTypes.toSet())
        .isNotEmpty) {
      futures.add(bangumiProgressService.getInProgressWatchableSubjectsFromApi(
          username: username, subjectTypes: action.subjectTypes));
    }

    List<LinkedHashMap<SubjectType, LinkedHashMap<int, InProgressSubject>>>
        subjectsPerType = await Future.wait(futures);

    LinkedHashMap<SubjectType, LinkedHashMap<int, InProgressSubject>>
        mergedSubjects = subjectsPerType.fold(
            LinkedHashMap<SubjectType, LinkedHashMap<int, InProgressSubject>>(),
            (mapSoFar, subjects) {
      mapSoFar.addAll(subjects);
      return mapSoFar;
    });

    yield GetProgressSuccessAction(
        progresses: mergedSubjects, subjectTypes: action.subjectTypes);
    action.completer.complete();
  } catch (error, stack) {
    action.completer.completeError(error, stack);
    print(error.toString());
    print(stack);
    yield GetProgressFailureAction.fromUnknownException(username: username);
    if (action.showSnackBar) {
      Scaffold.of(action.context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }
}

Epic<AppState> _createGetProgressEpic(
    BangumiProgressService bangumiProgressService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions).ofType(TypeToken<GetProgressAction>()).switchMap(
        (action) => _getProgress(bangumiProgressService, action,
            store.state.currentAuthenticatedUserBasicInfo.username));
  };
}

Stream<dynamic> _updateProgress(BangumiProgressService bangumiProgressService,
    UpdateProgressAction action, EpicStore<AppState> store) async* {
  try {
    if (action is UpdateAnimeOrRealSingleEpisodeAction) {
      await bangumiProgressService.updateSingleAnimeOrRealSingleEpisode(
          episodeId: action.episodeId,
          episodeUpdateType: action.episodeUpdateType);
      yield UpdateAnimeOrRealSingleEpisodeSuccessAction(
        episodeId: action.episodeId,
        subject: action.subject,
        episodeUpdateType: action.episodeUpdateType,
      );
    } else if (action is UpdateAnimeOrRealBatchEpisodesAction) {
      InProgressSubject progress = store
          .state.progressState.progresses[action.subject.type]
          .firstWhere((subject) => subject.subject.id == action.subject.id);
      assert(progress != null);

      List<int> episodeIds = (progress as InProgressAnimeOrRealCollection)
          .episodes
          .values
          .fold<List<int>>([], (episodeIdsSoFar, episode) {
        if (episode.episodeType == EpisodeType.RegularEpisode &&
            episode.sequentialNumber <= action.newEpisodeNumber) {
          episodeIdsSoFar.add(episode.id);
        }

        return episodeIdsSoFar;
      });

      await bangumiProgressService.updateAnimeOrRealBatchEpisodes(
          episodeIds: episodeIds);
      yield UpdateAnimeOrRealBatchEpisodesSuccessAction(
          subject: action.subject, newEpisodeNumber: action.newEpisodeNumber);
    } else if (action is UpdateBookProgressAction) {
      await bangumiProgressService.updateBookProgress(
          subjectId: action.subject.id,
          newEpisodeNumber: action.newEpisodeNumber,
          newVolumeNumber: action.newVolumeNumber);
      yield UpdateBookProgressSuccessAction(
        subject: action.subject,
        newEpisodeNumber: action.newEpisodeNumber,
        newVolumeNumber: action.newVolumeNumber,
      );
      Scaffold.of(action.context).showSnackBar(
          SnackBar(content: Text(action.toActionSuccessString())));
    }
  } catch (error, stack) {
    print(error.toString());
    print(stack);

    Scaffold.of(action.context)
        .showSnackBar(SnackBar(content: Text(error.toString())));
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
