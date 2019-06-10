import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:munin/models/bangumi/search/result/SearchResultItem.dart';

part 'BangumiSearchResponse.g.dart';

@BuiltValue(instantiable: false)
abstract class BangumiSearchResponse {
  int get totalCount;

  @nullable
  int get requestedResults;

  @nullable
  BuiltMap<int, SearchResultItem> get results;

  /// seems like there is no better way in built_value to specify a getter
  /// in interface
  @memoized
  bool get hasReachedEnd {
    throw UnsupportedError('Sub concrete class need to implement this getter');
  }

  BangumiSearchResponse rebuild(void updates(BangumiSearchResponseBuilder b));

  BangumiSearchResponseBuilder toBuilder();
}
