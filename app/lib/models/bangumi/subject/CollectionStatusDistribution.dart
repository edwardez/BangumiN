import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'CollectionStatusDistribution.g.dart';

@BuiltValue(wireName: 'Collection')
abstract class CollectionStatusDistribution
    implements
        Built<CollectionStatusDistribution,
            CollectionStatusDistributionBuilder> {
  @BuiltValueField(wireName: 'wish')
  int get wish;

  @BuiltValueField(wireName: 'collect')
  int get completed;

  @BuiltValueField(wireName: 'doing')
  int get inProgress;

  @BuiltValueField(wireName: 'on_hold')
  int get onHold;

  @BuiltValueField(wireName: 'dropped')
  int get dropped;

  bool get hasAtLeastOneCollection {
    return wish != 0 ||
        completed != 0 ||
        inProgress != 0 ||
        onHold != 0 ||
        dropped != 0;
  }

  CollectionStatusDistribution._();

  factory CollectionStatusDistribution(
          [void Function(CollectionStatusDistributionBuilder) updates]) =>
      _$CollectionStatusDistribution((b) => b
        ..wish = 0
        ..completed = 0
        ..inProgress = 0
        ..onHold = 0
        ..dropped = 0
        ..update(updates));

  String toJson() {
    return json.encode(serializers.serializeWith(
        CollectionStatusDistribution.serializer, this));
  }

  static CollectionStatusDistribution fromJson(String jsonString) {
    return serializers.deserializeWith(
        CollectionStatusDistribution.serializer, json.decode(jsonString));
  }

  static Serializer<CollectionStatusDistribution> get serializer =>
      _$collectionStatusDistributionSerializer;
}
