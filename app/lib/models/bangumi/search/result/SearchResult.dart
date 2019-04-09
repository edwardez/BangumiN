import 'package:built_value/built_value.dart';
import 'package:munin/models/bangumi/common/Images.dart';
import 'package:munin/models/bangumi/search/SearchType.dart';

part 'SearchResult.g.dart';

@BuiltValue(instantiable: false)
abstract class SearchResult {
  @nullable
  Images get images;

  String get name;

  @BuiltValueField(wireName: 'name_cn')
  String get nameCn;

  int get id;

  SearchType get type;

  SearchResult rebuild(void updates(SearchResultBuilder b));

  SearchResultBuilder toBuilder();
}
