import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'CollectionStatus.g.dart';

@BuiltValueEnum(wireName: 'type')
class CollectionStatus extends EnumClass {
  /// we use a 'trick' here, bangumi will return all results if type is not in their list, so we use -1 to indicate all type
  @BuiltValueEnumConst(wireName: 'wish')
  static const CollectionStatus Wish = _$Wish;

  @BuiltValueEnumConst(wireName: 'collect')
  static const CollectionStatus Collect = _$Collect;

  @BuiltValueEnumConst(wireName: 'do')
  static const CollectionStatus Do = _$Do;

  @BuiltValueEnumConst(wireName: 'on_hold')
  static const CollectionStatus OnHold = _$OnHold;

  @BuiltValueEnumConst(wireName: 'dropped')
  static const CollectionStatus Dropped = _$Dropped;

  @BuiltValueEnumConst(wireName: 'untouched')
  static const CollectionStatus Untouched = _$Untouched;

  /// Get quantified chinese name by subject type
  /// '一本书', '一张唱片' ...etc
  /// TODO(edward): I feel like there is a better way to get it's enum type...
  @memoized
  String get chineseName {
    switch (this) {
      case CollectionStatus.Wish:
        return '想';
      case CollectionStatus.Collect:
        return '过';
      case CollectionStatus.Do:
        return '在';
      case CollectionStatus.OnHold:
        return '搁置';
      case CollectionStatus.Dropped:
        return '抛弃';
      case CollectionStatus.Untouched:
      default:
        return '';
    }
  }

  @memoized
  String get wiredName {
    switch (this) {
      case CollectionStatus.Wish:
        return 'wish';
      case CollectionStatus.Collect:
        return 'collect';
      case CollectionStatus.Do:
        return 'do';
      case CollectionStatus.OnHold:
        return 'on_hold';
      case CollectionStatus.Dropped:
        return 'dropped';
      case CollectionStatus.Untouched:
      default:
        return '';
    }
  }

  static isInvalid(CollectionStatus status) {
    return status == null || status == CollectionStatus.Untouched;
  }

  const CollectionStatus._(String name) : super(name);

  static BuiltSet<CollectionStatus> get values => _$values;

  static CollectionStatus valueOf(String name) => _$valueOf(name);

  static Serializer<CollectionStatus> get serializer =>
      _$collectionStatusSerializer;
}
