import 'package:built_value/built_value.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/search/SearchType.dart';

part 'SearchResult.g.dart';

@BuiltValue(instantiable: false)
abstract class SearchResult {
  @BuiltValueField(wireName: 'images')
  @nullable
  BangumiImage get image;

  String get name;

  int get id;

  SearchType get type;

  SearchResult rebuild(void updates(SearchResultBuilder b));

  SearchResultBuilder toBuilder();
}
