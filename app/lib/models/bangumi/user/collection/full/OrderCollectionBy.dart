import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:quiver/core.dart';

part 'OrderCollectionBy.g.dart';

/// Order collection by one of these types.
///
/// Note that bangumi doesn't allow ascending order, all orders are in descending
/// sequence.
class OrderCollectionBy extends EnumClass {
  static const OrderCollectionBy Rating = _$Rating;

  static const OrderCollectionBy CollectedTime = _$CollectedTime;

  static const OrderCollectionBy ReleaseDate = _$ReleaseDate;

  static const OrderCollectionBy Alphabetical = _$Alphabetical;

  String get chineseName {
    switch (this) {
      case OrderCollectionBy.Rating:
        return '评分';
      case OrderCollectionBy.ReleaseDate:
        return '发售日';
      case OrderCollectionBy.Alphabetical:
        return '名称';
      case OrderCollectionBy.CollectedTime:
        return '收藏日期';
      default:
        assert(false, '$this doesn\'t have a valid chinese name');
        return '-';
    }
  }

  String get chineseSortExplanation {
    switch (this) {
      case OrderCollectionBy.Rating:
        return '从高到低';
      case OrderCollectionBy.ReleaseDate:
        return '从近到远';
      case OrderCollectionBy.Alphabetical:
        return '原文标题A-Z';
      case OrderCollectionBy.CollectedTime:
        return '从近到远';
      default:
        assert(false, '$this doesn\'t have a valid chinese name');
        return '-';
    }
  }

  /// Returns wired name if it exists, or [Optional.absent()] if the corresponding
  /// type doesn't have a [wiredName].
  Optional<String> get wiredName {
    switch (this) {
      case OrderCollectionBy.Rating:
        return Optional.of('rate');
      case OrderCollectionBy.ReleaseDate:
        return Optional.of('date');
      case OrderCollectionBy.Alphabetical:
        return Optional.of('title');
      default:
        return Optional.absent();
    }
  }

  const OrderCollectionBy._(String name) : super(name);

  static BuiltSet<OrderCollectionBy> get values => _$values;

  static OrderCollectionBy valueOf(String name) => _$valueOf(name);

  static Serializer<OrderCollectionBy> get serializer =>
      _$orderCollectionBySerializer;
}
