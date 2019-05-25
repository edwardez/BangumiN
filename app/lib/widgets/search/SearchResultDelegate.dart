import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/search/result/MonoSearchResult.dart';
import 'package:munin/models/bangumi/search/result/SearchResult.dart';
import 'package:munin/models/bangumi/search/result/SubjectSearchResult.dart';
import 'package:munin/models/bangumi/search/result/UserSearchResult.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/search/MonoSearchResultWidget.dart';
import 'package:munin/widgets/search/SubjectSearchResultWidget.dart';

class SearchResultDelegate extends StatelessWidget {
  final SearchResult searchResult;
  final PreferredSubjectInfoLanguage preferredSubjectInfoLanguage;

  static const double portraitHorizontalPadding =
      defaultPortraitHorizontalPadding;

  const SearchResultDelegate(
      {Key key, @required this.searchResult, @required this.preferredSubjectInfoLanguage})
      : super(key: key);

  Widget getDelegatedWidget(SearchResult searchResult) {
    if (searchResult is SubjectSearchResult) {
      return SubjectSearchResultWidget(
        subjectSearchResult: searchResult,
        preferredSubjectInfoLanguage: preferredSubjectInfoLanguage,);
    }

    if (searchResult is MonoSearchResult) {
      return MonoSearchResultWidget(monoSearchResult: searchResult);
    }

    return Text('No such result');
  }

  @override
  Widget build(BuildContext context) {
    assert(searchResult is SubjectSearchResult ||
        searchResult is UserSearchResult ||
        searchResult is MonoSearchResult);

    return getDelegatedWidget(searchResult);
  }
}
