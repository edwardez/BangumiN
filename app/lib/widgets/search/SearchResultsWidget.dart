import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/search/SearchRequest.dart';
import 'package:munin/models/bangumi/search/SearchType.dart';
import 'package:munin/models/bangumi/search/result/BangumiGeneralSearchResponse.dart';
import 'package:munin/models/bangumi/search/result/SearchResult.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/search/SearchActions.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';
import 'package:munin/widgets/search/SearchResultDelegate.dart';
import 'package:munin/widgets/shared/chips/FilterChipsGroup.dart';
import 'package:munin/widgets/shared/common/RequestInProgressIndicatorWidget.dart';
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
  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  _ViewModel viewModel;
  SearchRequest currentSearchRequest;

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
        chipNameRetriever: (SearchType searchType) => searchType.chineseName,
        onChipSelected: (SearchType selectedSearchType) {
          currentSearchRequest = currentSearchRequest
              .rebuild((b) => b..searchType = selectedSearchType);
          vm.dispatchSearchAction(context, currentSearchRequest);
        });
  }

  _buildResultList(_ViewModel vm) {
    if (vm.bangumiSearchResponse == null) {
      return RequestInProgressIndicatorWidget(
          loadingStatus: vm.loadingStatus,
          showAppBar: false,
          refreshAction: null);
    }

    List<SearchResult> results = vm.bangumiSearchResponse.resultsAsList;

    if (results.isEmpty) {
      return Center(
        child: Text('搜索到0个结果'),
      );
    }

    bool hasReachedEnd = vm.bangumiSearchResponse.hasReachedEnd;
    return EasyRefresh(
      key: _easyRefreshKey,
      behavior: ScrollOverBehavior(),
      autoLoad: !hasReachedEnd,
      refreshFooter: ClassicsFooter(
        key: _footerKey,
        loadText: '上拉释放',
        loadReadyText: '释放加载',
        loadingText: '加载中',
        loadedText: '加载完成',
        noMoreText: '没有更多数据',
        bgColor: Colors.transparent,
        textColor: Theme.of(context).textTheme.body1.color,
      ),
      child: ListView.builder(
          //ListView的Item
          itemCount: results.length,
          itemBuilder: (BuildContext context, int index) {
            return SearchResultDelegate(
              searchResult: results[index],
              preferredSubjectInfoLanguage: vm.preferredSubjectInfoLanguage,

            );
          }),
      onRefresh: null,
      loadMore: () async {
        /// dispatch event only if we've not reached the end
        if (!hasReachedEnd) {
          return vm.dispatchSearchAction(null, currentSearchRequest);
        }
      },
    );
  }

  _buildListView(BuildContext context, SearchType searchType, _ViewModel vm) {
    List<Widget> widgets = [];
    FilterChipsGroup<SearchType> filterChips =
        _buildFilterChipsWidget(context, currentSearchRequest.searchType, vm);
    if (filterChips != null) {
      widgets.add(filterChips);
    }

    widgets.add(Expanded(
      child: _buildResultList(vm),
    ));

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store store) {
        viewModel = _ViewModel.fromStore(store, currentSearchRequest);
        return viewModel;
      },
      distinct: true,
      onInit: (store) {
        currentSearchRequest = widget.searchRequest;
        final bangumiSearchResponse =
            store.state.searchState.results[currentSearchRequest];

        /// Dispatches a new event only if there is currently no response
        /// Otherwise, leaves the refreshing task to refresh widget
        if (bangumiSearchResponse == null) {
          final action = _createSearchAction(context, currentSearchRequest);
          store.dispatch(action);
        }
      },
      onDispose: (store) {
        store.dispatch(
            SearchCleanUpAction(searchRequest: currentSearchRequest));
      },
      builder: (BuildContext context, _ViewModel vm) {
        return Column(
          children:
              _buildListView(context, currentSearchRequest.searchType, vm),
        );
      },
    );
  }
}

class _ViewModel {
  final BangumiGeneralSearchResponse bangumiSearchResponse;
  final PreferredSubjectInfoLanguage preferredSubjectInfoLanguage;
  final SearchRequest searchRequest;
  final LoadingStatus loadingStatus;
  final Function(BuildContext context, SearchRequest externalSearchRequest)
      dispatchSearchAction;

  factory _ViewModel.fromStore(
      Store<AppState> store, SearchRequest searchRequest) {
    _dispatchSearchAction(
        BuildContext context, SearchRequest externalSearchRequest) async {
      final action = _createSearchAction(context, externalSearchRequest);

      store.dispatch(action);
      return action.completer.future;
    }

    return _ViewModel(
      searchRequest: searchRequest,
      bangumiSearchResponse: store.state.searchState.results[searchRequest],
      loadingStatus:
          store.state.searchState.searchRequestsStatus[searchRequest],
      dispatchSearchAction:
          (BuildContext context, SearchRequest externalSearchRequest) =>
              _dispatchSearchAction(context, externalSearchRequest),
      preferredSubjectInfoLanguage: store.state.settingState.generalSetting
          .preferredSubjectInfoLanguage,
    );
  }

  _ViewModel({
    @required this.searchRequest,
    @required this.bangumiSearchResponse,
    @required this.loadingStatus,
    @required this.dispatchSearchAction,
    @required this.preferredSubjectInfoLanguage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          bangumiSearchResponse == other.bangumiSearchResponse &&
          loadingStatus == other.loadingStatus &&
          searchRequest == other.searchRequest &&
          preferredSubjectInfoLanguage == other.preferredSubjectInfoLanguage
  ;

  @override
  int get hashCode =>
      hash4(bangumiSearchResponse, loadingStatus, searchRequest,
          preferredSubjectInfoLanguage);
}

_createSearchAction(BuildContext context, SearchRequest externalSearchRequest) {
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
