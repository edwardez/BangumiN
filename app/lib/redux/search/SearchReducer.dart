import 'package:munin/models/bangumi/search/SearchRequest.dart';
import 'package:munin/models/bangumi/search/result/BangumiGeneralSearchResponse.dart';
import 'package:munin/redux/search/SearchActions.dart';
import 'package:munin/redux/search/SearchState.dart';
import 'package:redux/redux.dart';

final searchReducers = combineReducers<SearchState>([
  /// Search Subject
  TypedReducer<SearchState, SearchSuccessAction>(searchSubjectSuccessReducer),
]);

SearchState searchSubjectSuccessReducer(
    SearchState searchState, SearchSuccessAction searchSubjectSuccessAction) {
  SearchRequest searchRequest = searchSubjectSuccessAction.searchRequest;
  BangumiGeneralSearchResponse responseToUpdate =
      searchState.results[searchRequest];
  BangumiGeneralSearchResponse newResponse =
      searchSubjectSuccessAction.searchResponse;
  if (responseToUpdate == null) {
    responseToUpdate = newResponse;
  } else {
    responseToUpdate = responseToUpdate.rebuild((b) => b
      ..requestedResults = b.requestedResults + newResponse.requestedResults
      ..results.addAll(newResponse.results.asMap()));
  }

  return searchState.rebuild(
    (b) => b..results.addAll({searchRequest: responseToUpdate}),
  );
}
