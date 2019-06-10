import 'package:built_value/built_value.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/search/SearchType.dart';

part 'SearchResultItem.g.dart';

@BuiltValue(instantiable: false)
abstract class SearchResultItem {
  @BuiltValueField(wireName: 'images')
  @nullable
  BangumiImage get image;

  String get name;

  int get id;

  SearchType get type;

  SearchResultItem rebuild(void updates(SearchResultItemBuilder b));

  SearchResultItemBuilder toBuilder();
}
