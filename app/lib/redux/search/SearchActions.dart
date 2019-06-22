import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/search/SearchRequest.dart';
import 'package:munin/models/bangumi/search/result/BangumiSearchResponse.dart';

abstract class SearchAction {
  final BuildContext context;
  final SearchRequest searchRequest;
  final Completer completer;

  SearchAction._(this.context, this.searchRequest, this.completer);
}

class SearchSubjectAction implements SearchAction {
  final BuildContext context;
  final SearchRequest searchRequest;
  final Completer completer;

  SearchSubjectAction({@required this.context,
    @required this.searchRequest,
    Completer completer})
      : this.completer = completer ?? Completer();
}

class SearchMonoAction implements SearchAction {
  final BuildContext context;
  final SearchRequest searchRequest;
  final Completer completer;

  SearchMonoAction({@required this.context,
    @required this.searchRequest,
    Completer completer})
      : this.completer = completer ?? Completer();
}

class SearchSuccessAction {
  final SearchRequest searchRequest;
  final BangumiSearchResponse searchResponse;

  SearchSuccessAction(
      {@required this.searchRequest, @required this.searchResponse});
}