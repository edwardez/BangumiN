import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/search/result/MonoSearchResult.dart';
import 'package:munin/models/bangumi/search/result/SearchResultItem.dart';
import 'package:munin/models/bangumi/search/result/SubjectSearchResultItem.dart';
import 'package:munin/models/bangumi/search/result/UserSearchResultItem.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/search/MonoSearchResultWidget.dart';
import 'package:munin/widgets/search/SubjectSearchResultWidget.dart';

class SearchResultDelegate extends StatelessWidget {
  final SearchResultItem searchResult;
  final PreferredSubjectInfoLanguage preferredSubjectInfoLanguage;

  static const double portraitHorizontalPadding =
      defaultPortraitHorizontalOffset;

  const SearchResultDelegate(
      {Key key,
      @required this.searchResult,
      @required this.preferredSubjectInfoLanguage})
      : super(key: key);

  Widget getDelegatedWidget(SearchResultItem searchResult) {
    if (searchResult is SubjectSearchResultItem) {
      return SubjectSearchResultWidget(
        subjectSearchResult: searchResult,
        preferredSubjectInfoLanguage: preferredSubjectInfoLanguage,
      );
    }

    if (searchResult is MonoSearchResult) {
      return MonoSearchResultWidget(monoSearchResult: searchResult);
    }

    return Text('No such result');
  }

  @override
  Widget build(BuildContext context) {
    assert(searchResult is SubjectSearchResultItem ||
        searchResult is UserSearchResultItem ||
        searchResult is MonoSearchResult);

    return getDelegatedWidget(searchResult);
  }
}
