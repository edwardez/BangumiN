import 'package:munin/models/bangumi/search/result/BangumiGeneralSearchResponse.dart';
import 'package:munin/providers/bangumi/search/BangumiSearchService.dart';
import 'package:munin/redux/app/AppActions.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/search/SearchActions.dart';
import 'package:munin/shared/utils/misc/async.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

List<Epic<AppState>> createSearchEpics(
    BangumiSearchService bangumiSearchService) {
  final searchSubjectOrMonoEpic =
      _createSearchSubjectOrMonoEpic(bangumiSearchService);

  return [
    searchSubjectOrMonoEpic,
  ];
}

Stream<dynamic> _searchSubjectOrMonoEpic(
    BangumiSearchService bangumiSearchService,
    SearchAction action,
    BangumiGeneralSearchResponse responseInStore) async* {
  try {
    if (responseInStore?.hasReachedEnd ?? false) {
      action.completer.complete();
      return;
    }

    BangumiGeneralSearchResponse bangumiSearchResponse;
    if (action is SearchSubjectAction) {
      bangumiSearchResponse = await bangumiSearchService.searchSubject(
          query: action.searchRequest.query,
          searchType: action.searchRequest.searchType,
          // currently [maxResults] is hard-coded to 25
          maxResults: 25,
          start: responseInStore?.requestedResults);
    } else if (action is SearchMonoAction) {
      bangumiSearchResponse = await bangumiSearchService.searchMono(
          query: action.searchRequest.query,
          searchType: action.searchRequest.searchType);
    } else {
      throw UnsupportedError('$action is not supported');
    }

    yield SearchSuccessAction(
        searchRequest: action.searchRequest,
        searchResponse: bangumiSearchResponse);

    action.completer.complete();
  } catch (error, stack) {
    yield HandleErrorAction(
      error: error,
      context: action.context,
      stack: stack,
    );
    action.completer.completeError(error, stack);
  } finally {
    completeDanglingCompleter(action.completer);
  }
}

Epic<AppState> _createSearchSubjectOrMonoEpic(
    BangumiSearchService bangumiSearchService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions
        .whereType<SearchAction>()
        .switchMap((action) => _searchSubjectOrMonoEpic(
              bangumiSearchService,
              action,
              store.state.searchState.results[action.searchRequest],
            ));
  };
}
