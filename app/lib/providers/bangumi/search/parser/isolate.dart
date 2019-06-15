import 'dart:collection';

import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/search/SearchType.dart';
import 'package:munin/models/bangumi/search/result/MonoSearchResult.dart';
import 'package:munin/providers/bangumi/search/parser/MonoSearchParser.dart';

LinkedHashMap<int, MonoSearchResult> processMonoSearch(
    ParseMonoSearchMessage message) {
  return MonoSearchParser()
      .processMonoSearch(message.html, searchType: message.searchType);
}

class ParseMonoSearchMessage {
  final String html;

  final SearchType searchType;

  const ParseMonoSearchMessage(this.html, {@required this.searchType});
}
