import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/search/SearchRequest.dart';
import 'package:munin/models/bangumi/search/SearchType.dart';
import 'package:munin/models/bangumi/search/result/BangumiGeneralSearchResponse.dart';
import 'package:munin/models/bangumi/search/result/SearchResultItem.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/search/SearchActions.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/search/SearchResultDelegate.dart';
import 'package:munin/widgets/shared/chips/FilterChipsGroup.dart';
import 'package:munin/widgets/shared/common/MuninPadding.dart';
import 'package:munin/widgets/shared/refresh/MuninRefresh.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

class SearchResultsWidget extends StatefulWidget {
  final SearchRequest searchRequest;

  const SearchResultsWidget({
    Key key,
    @required this.searchRequest,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchResultsWidgetState();
  }
}

class _SearchResultsWidgetState extends State<SearchResultsWidget> {
  GlobalKey<MuninRefreshState> _muninRefreshKey =
  GlobalKey<MuninRefreshState>();

  _ViewModel viewModel;
  SearchRequest currentSearchRequest;

  @override
  void initState() {
    super.initState();
    currentSearchRequest = widget.searchRequest;
  }

  /// Build a widget to let user filter by type
  /// returns no if current search type doesn't need a filter chip
  FilterChipsGroup<SearchType> _buildFilterChipsWidget(
      BuildContext context, SearchType searchType, _ViewModel vm) {
    List<SearchType> filterTags;
    if (searchType.isSubjectSearchType) {
      filterTags = [
        SearchType.AnySubject,
        SearchType.Anime,
        SearchType.Game,
        SearchType.Book,
        SearchType.Music,
        SearchType.Real,
      ];
    } else {
      return null;
    }

    return FilterChipsGroup<SearchType>(
      filterChips: filterTags,
      selectedChip: searchType,
      chipLabelBuilder: (SearchType searchType) => Text(searchType.chineseName),
      onChipSelected: (SearchType selectedSearchType) {
        setState(() {
          currentSearchRequest = currentSearchRequest
              .rebuild((b) => b..searchType = selectedSearchType);
          _muninRefreshKey.currentState.callOnLoadMore();
        });
      },
      initialLeftOffset: defaultPortraitHorizontalOffset,
    );
  }

  Widget searchResultCountWidget(int count) {
    return MuninPadding.noVerticalOffset(
      child: Text(
        '搜索到$count个结果',
        style: defaultCaptionText(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store store) =>
          _ViewModel.fromStore(store, currentSearchRequest),
      distinct: true,
      onInitialBuild: (vm) {
        /// Dispatches a new event only if there is currently no response
        /// Otherwise, let refresh widget to load more items.
        if (vm.bangumiSearchResponse == null) {
          _muninRefreshKey.currentState.callOnLoadMore();
        }
      },
      builder: (BuildContext context, _ViewModel vm) {
        FilterChipsGroup<SearchType> filterChips = _buildFilterChipsWidget(
            context, currentSearchRequest.searchType, vm);

        List<SearchResultItem> results =
            vm.bangumiSearchResponse?.resultsAsList ?? [];

        bool hasReachedEnd = vm.bangumiSearchResponse?.hasReachedEnd ?? false;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (filterChips != null) filterChips,
            Expanded(
              child: MuninRefresh(
                key: _muninRefreshKey,
                onRefresh: null,
                onLoadMore: () {
                  return vm.dispatchSearchAction(context, currentSearchRequest);
                },
                refreshWidgetStyle: RefreshWidgetStyle.Adaptive,
                topWidgets: <Widget>[
                  // Adds `result != 0` check to avoid duplicate with [noMoreItemsWidget]
                  if (vm.bangumiSearchResponse != null &&
                      vm.bangumiSearchResponse.totalCount != 0)
                    searchResultCountWidget(
                        vm.bangumiSearchResponse.totalCount),
                ],
                itemCount: results.length,
                itemBuilder: (BuildContext context, int index) {
                  return MuninPadding.noVerticalOffset(
                    child: SearchResultDelegate(
                      searchResult: results[index],
                      preferredSubjectInfoLanguage:
                      vm.preferredSubjectInfoLanguage,
                    ),
                  );
                },
                noMoreItemsToLoad: hasReachedEnd,
                noMoreItemsWidget: Text(
                  '没有更多${currentSearchRequest.searchType.chineseName}分类下的结果',
                  style: defaultCaptionText(context),
                ),
                separatorBuilder: null,
                appBarUnderneathPadding: null,
              ),
            )
          ],
        );
      },
    );
  }
}

class _ViewModel {
  final BangumiGeneralSearchResponse bangumiSearchResponse;
  final PreferredSubjectInfoLanguage preferredSubjectInfoLanguage;
  final SearchRequest searchRequest;
  final Future<void> Function(
      BuildContext context, SearchRequest externalSearchRequest)
      dispatchSearchAction;

  factory _ViewModel.fromStore(Store<AppState> store,
      SearchRequest currentSearchRequest) {
    Future<void> _dispatchSearchAction(BuildContext context,
        SearchRequest newSearchRequest) async {
      final action = _createSearchAction(context, newSearchRequest);

      store.dispatch(action);
      return action.completer.future;
    }

    return _ViewModel(
      searchRequest: currentSearchRequest,
      bangumiSearchResponse:
      store.state.searchState.results[currentSearchRequest],
      dispatchSearchAction: _dispatchSearchAction,
      preferredSubjectInfoLanguage:
      store.state.settingState.generalSetting.preferredSubjectInfoLanguage,
    );
  }

  _ViewModel({
    @required this.searchRequest,
    @required this.bangumiSearchResponse,
    @required this.dispatchSearchAction,
    @required this.preferredSubjectInfoLanguage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          bangumiSearchResponse == other.bangumiSearchResponse &&
          searchRequest == other.searchRequest &&
          preferredSubjectInfoLanguage == other.preferredSubjectInfoLanguage;

  @override
  int get hashCode =>
      hash3(bangumiSearchResponse, searchRequest, preferredSubjectInfoLanguage);
}

SearchAction _createSearchAction(BuildContext context,
    SearchRequest externalSearchRequest) {
  dynamic action;
  if (externalSearchRequest.searchType.isSubjectSearchType) {
    action = SearchSubjectAction(
        context: context, searchRequest: externalSearchRequest);
  } else if (externalSearchRequest.searchType.isMonoSearchType) {
    action = SearchMonoAction(
        context: context, searchRequest: externalSearchRequest);
  } else {
    throw UnsupportedError('Not supported');
  }

  return action;
}
