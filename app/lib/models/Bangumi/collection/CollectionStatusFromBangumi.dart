import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/Bangumi/collection/CollectionStatus.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'CollectionStatusFromBangumi.g.dart';

/// An extra class to represent collection status
/// it's needed because of Bangumi's JSON structure
/// Ideally, customized serializer should be used to eliminate this class
@BuiltValue(wireName: 'status')
abstract class CollectionStatusFromBangumi
    implements
        Built<CollectionStatusFromBangumi, CollectionStatusFromBangumiBuilder> {
  CollectionStatusFromBangumi._();

  factory CollectionStatusFromBangumi(
          [updates(CollectionStatusFromBangumiBuilder b)]) =>
      _$CollectionStatusFromBangumi((b) => {
            b
              ..type = CollectionStatus.Untouched
              ..update(updates)
          });

  @BuiltValueField(wireName: 'type')
  CollectionStatus get type;

  /// these fields are currently not in use
  ///  @BuiltValueField(wireName: 'id')
  /// int get id;
  /// @BuiltValueField(wireName: 'name')
  ///  String get name;
  String toJson() {
    return json.encode(serializers.serializeWith(
        CollectionStatusFromBangumi.serializer, this));
  }

  static CollectionStatusFromBangumi fromJson(String jsonString) {
    return serializers.deserializeWith(
        CollectionStatusFromBangumi.serializer, json.decode(jsonString));
  }

  static Serializer<CollectionStatusFromBangumi> get serializer =>
      _$collectionStatusFromBangumiSerializer;
}
