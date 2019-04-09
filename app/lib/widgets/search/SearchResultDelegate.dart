import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/search/result/MonoSearchResult.dart';
import 'package:munin/models/bangumi/search/result/SearchResult.dart';
import 'package:munin/models/bangumi/search/result/SubjectSearchResult.dart';
import 'package:munin/models/bangumi/search/result/UserSearchResult.dart';
import 'package:munin/styles/theme/common.dart';
import 'package:munin/widgets/search/SubjectSearchResultWidget.dart';

class SearchResultDelegate extends StatelessWidget {
  final SearchResult searchResult;
  static const double portraitHorizontalPadding =
      defaultPortraitHorizontalPadding;

  SearchResultDelegate({Key key, @required this.searchResult})
      : assert(searchResult is SubjectSearchResult ||
            searchResult is UserSearchResult ||
            searchResult is MonoSearchResult),
        super(key: key);

  Widget getDelegatedWidget(SearchResult searchResult) {
    if (searchResult is SubjectSearchResult) {
      return SubjectSearchResultWidget(subjectSearchResult: searchResult);
    }
    return Text('No such result');
  }

  @override
  Widget build(BuildContext context) {
    return getDelegatedWidget(searchResult);
  }
}
