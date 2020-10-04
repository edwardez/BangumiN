import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/search/SearchRequest.dart';
import 'package:munin/models/bangumi/search/SearchType.dart';
import 'package:munin/redux/shared/utils.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/search/SearchResultsWidget.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';

final List<SearchType> _searchTypes = const [
  SearchType.AnySubject,
  SearchType.Character,
  SearchType.Person,
];

class SearchHomeDelegate extends SearchDelegate {
  SearchRequest selectedSearchRequest;

  static const double portraitHorizontalPadding =
      defaultPortraitHorizontalOffset;

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(AdaptiveIcons.backIconData),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    if (findAppState(context)
        .settingState
        .themeSetting
        .findCurrentTheme(context)
        .isDarkTheme) {
      return Theme.of(context);
    }

    return super.appBarTheme(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return _SuggestionList(
      query: query,
      onSelected: (SearchRequest searchRequest) {
        selectedSearchRequest = searchRequest;
        showResults(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text('搜索关键词不能为空'),
      );
    }

    /// User doesn't select any suggestion options, instead, user has pressed
    /// 'search' on keyboard
    /// We still perform search for user, and by default the first option
    /// in [_searchTypes] is used
    if (selectedSearchRequest == null || selectedSearchRequest.query != query) {
      selectedSearchRequest = SearchRequest((b) => b
        ..query = query
        ..searchType = _searchTypes[0]);
    }

    return SearchResultsWidget(
      searchRequest: selectedSearchRequest,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return query.isEmpty
        ? []
        : [
            IconButton(
              tooltip: '清除',
              icon: Icon(AdaptiveIcons.clearIconData),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            ),
          ];
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList({@required this.query, @required this.onSelected})
      : assert(onSelected != null);

  final String query;
  final ValueChanged<SearchRequest> onSelected;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _searchTypes.length,
      itemBuilder: (BuildContext context, int i) {
        final SearchType searchType = _searchTypes[i];
        return ListTile(
          title: Text('在 ${searchType.chineseName} 中搜索 $query'),
          onTap: () {
            SearchRequest searchRequest = SearchRequest((b) => b
              ..query = query
              ..searchType = searchType);
            onSelected(searchRequest);
          },
        );
      },
    );
  }
}
