import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/search/result/BangumiSearchResponse.dart';
import 'package:munin/providers/bangumi/search/BangumiSearchService.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/search/SearchActions.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

List<Epic<AppState>> createSearchEpics(
    BangumiSearchService bangumiSearchService) {
  final searchSubjectEpic = _createSearchSubjectEpic(bangumiSearchService);

  return [searchSubjectEpic];
}

Stream<dynamic> _searchSubject(BangumiSearchService bangumiSearchService,
    SearchSubjectAction action, BangumiSearchResponse responseInStore) async* {
  try {
    yield SearchLoadingAction(searchRequest: action.searchRequest);

    /// currently [maxResults] is hard-coded to 25
    int maxResults = 25;

    BangumiSearchResponse bangumiSearchResponse =
        await bangumiSearchService.searchSubject(
            query: action.searchRequest.query,
            searchType: action.searchRequest.searchType,
            maxResults: maxResults,
            start: responseInStore?.requestedResults);
    print('success!');
    // If the api call is successful, dispatch the results for display
    yield SearchSubjectSuccessAction(
        searchRequest: action.searchRequest,
        searchResponse: bangumiSearchResponse);
  } catch (error, stack) {
    // If the search call fails, dispatch an error so we can show it
    print(error.toString());
    print(stack);
    Scaffold.of(action.context)
        .showSnackBar(SnackBar(content: Text(error.toString())));
    yield SearchFailureAction.fromUnknownException(
        searchRequest: action.searchRequest);
  } finally {
    action.completer.complete();
  }
}

Epic<AppState> _createSearchSubjectEpic(
    BangumiSearchService bangumiSearchService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        // Narrow down to SearchAction actions
        .ofType(TypeToken<SearchSubjectAction>())
        .debounce(Duration(seconds: 2))
        // Cancel the previous search and start a new one with switchMap
        .switchMap((action) => _searchSubject(bangumiSearchService, action,
            store.state.searchState.results[action.searchRequest]));
  };
}
