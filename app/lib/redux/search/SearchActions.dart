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

class SearchMonoAction {
  final BuildContext context;
  final SearchRequest searchRequest;
  final Completer completer;

  SearchMonoAction({@required this.context,
    @required this.searchRequest,
    Completer completer})
      : this.completer = completer ?? new Completer();
}

class SearchUserAction {
  final BuildContext context;
  final SearchRequest searchRequest;
  final Completer completer;

  SearchUserAction({@required this.context,
    @required this.searchRequest,
    Completer completer})
      : this.completer = completer ?? new Completer();
}

class SearchLoadingAction {
  final SearchRequest searchRequest;

  SearchLoadingAction({@required this.searchRequest});
}

class SearchSuccessAction {
  final SearchRequest searchRequest;
  final BangumiSearchResponse searchResponse;

  SearchSuccessAction(
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

class SearchCleanUpAction {
  final SearchRequest searchRequest;

  SearchCleanUpAction({@required this.searchRequest});
}
