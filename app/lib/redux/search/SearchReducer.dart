import 'package:munin/models/bangumi/search/SearchRequest.dart';
import 'package:munin/models/bangumi/search/result/BangumiGeneralSearchResponse.dart';
import 'package:munin/redux/search/SearchActions.dart';
import 'package:munin/redux/search/SearchState.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';
import 'package:redux/redux.dart';

final searchReducers = combineReducers<SearchState>([
  /// Search Subject
  TypedReducer<SearchState, SearchLoadingAction>(searchLoadingReducer),
  TypedReducer<SearchState, SearchSuccessAction>(
      searchSubjectSuccessReducer),
  TypedReducer<SearchState, SearchFailureAction>(searchFailureReducer),
]);

/// Subject Actions
SearchState searchLoadingReducer(
    SearchState searchState, SearchLoadingAction searchLoadingAction) {
  return searchState.rebuild((b) => b
    ..searchRequestsStatus
        .addAll({searchLoadingAction.searchRequest: LoadingStatus.Loading}));
}

SearchState searchSubjectSuccessReducer(SearchState searchState,
    SearchSuccessAction searchSubjectSuccessAction) {
  SearchRequest searchRequest = searchSubjectSuccessAction.searchRequest;
  BangumiGeneralSearchResponse responseToUpdate = searchState
      .results[searchRequest];
  BangumiGeneralSearchResponse newResponse = searchSubjectSuccessAction
      .searchResponse;
  if (responseToUpdate == null) {
    responseToUpdate = newResponse;
  } else {
    responseToUpdate = responseToUpdate.rebuild((b) => b
      ..requestedResults = b.requestedResults + newResponse.requestedResults
      ..results.addAll(newResponse.results.asMap()));
  }

  return searchState.rebuild((b) => b
    ..results.addAll({searchRequest: responseToUpdate})
    ..searchRequestsStatus.addAll({searchRequest: LoadingStatus.Success}));
}

SearchState searchFailureReducer(
    SearchState searchState, SearchFailureAction searchFailureAction) {
  return searchState.rebuild((b) => b
    ..searchRequestsStatus.addAll({
      searchFailureAction.searchRequest: searchFailureAction.loadingStatus
    }));
}
