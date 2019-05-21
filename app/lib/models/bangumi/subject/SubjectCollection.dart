import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'SubjectCollection.g.dart';

@BuiltValue(wireName: 'Collection')
abstract class SubjectCollection
    implements Built<SubjectCollection, SubjectCollectionBuilder> {
  SubjectCollection._();

  factory SubjectCollection([updates(SubjectCollectionBuilder b)]) =
      _$SubjectCollection;

  @BuiltValueField(wireName: 'wish')
  int get wish;

  @BuiltValueField(wireName: 'collect')
  int get collect;

  @BuiltValueField(wireName: 'doing')
  int get doing;

  @BuiltValueField(wireName: 'on_hold')
  int get onHold;

  @BuiltValueField(wireName: 'dropped')
  int get dropped;

  String toJson() {
    return json
        .encode(serializers.serializeWith(SubjectCollection.serializer, this));
  }

  static SubjectCollection fromJson(String jsonString) {
    return serializers.deserializeWith(
        SubjectCollection.serializer, json.decode(jsonString));
  }

  static Serializer<SubjectCollection> get serializer =>
      _$subjectCollectionSerializer;
}
