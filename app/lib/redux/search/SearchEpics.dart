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
  final searchMonoEpic = _createSearchMonoEpic(bangumiSearchService);

  return [searchSubjectEpic, searchMonoEpic];
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

    yield SearchSuccessAction(
        searchRequest: action.searchRequest,
        searchResponse: bangumiSearchResponse);
  } catch (error, stack) {
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
        .ofType(TypeToken<SearchSubjectAction>())
        .switchMap((action) => _searchSubject(bangumiSearchService, action,
            store.state.searchState.results[action.searchRequest]));
  };
}

Stream<dynamic> _searchMono(BangumiSearchService bangumiSearchService,
    SearchMonoAction action, BangumiSearchResponse responseInStore) async* {
  try {
    yield SearchLoadingAction(searchRequest: action.searchRequest);

    BangumiSearchResponse bangumiSearchResponse =
    await bangumiSearchService.searchMono(
        query: action.searchRequest.query,
        searchType: action.searchRequest.searchType);

    yield SearchSuccessAction(
        searchRequest: action.searchRequest,
        searchResponse: bangumiSearchResponse);
  } catch (error, stack) {
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

Epic<AppState> _createSearchMonoEpic(
    BangumiSearchService bangumiSearchService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions).ofType(TypeToken<SearchMonoAction>()).switchMap(
            (action) =>
            _searchMono(bangumiSearchService, action,
                store.state.searchState.results[action.searchRequest]));
  };
}
