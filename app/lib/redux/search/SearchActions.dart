import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/search/SearchRequest.dart';
import 'package:munin/models/bangumi/search/result/BangumiSearchResponse.dart';
import 'package:munin/redux/shared/CommonActions.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';

class SearchSubjectAction {
  final BuildContext context;
  final SearchRequest searchRequest;
  final Completer completer;

  SearchSubjectAction(
      {@required this.context,
      @required this.searchRequest,
      Completer completer})
      : this.completer = completer ?? new Completer();
}

class SearchLoadingAction {
  final SearchRequest searchRequest;

  SearchLoadingAction({@required this.searchRequest});
}

class SearchSubjectSuccessAction {
  final SearchRequest searchRequest;
  final BangumiSearchResponse searchResponse;

  SearchSubjectSuccessAction(
      {@required this.searchRequest, @required this.searchResponse});
}

class SearchFailureAction extends FailureAction {
  final SearchRequest searchRequest;

  SearchFailureAction(
      {@required LoadingStatus loadingStatus, @required this.searchRequest})
      : super(loadingStatus: loadingStatus);

  SearchFailureAction.fromUnknownException({@required this.searchRequest})
      : super.fromUnknownException();
}

class SearchSubjectCleanUpAction {
  final SearchRequest searchRequest;

  SearchSubjectCleanUpAction({@required this.searchRequest});
}
