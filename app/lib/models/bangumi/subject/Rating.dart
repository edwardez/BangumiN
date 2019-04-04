import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/subject/Count.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'Rating.g.dart';

abstract class Rating implements Built<Rating, RatingBuilder> {
  Rating._();

  factory Rating([updates(RatingBuilder b)]) = _$Rating;

  @BuiltValueField(wireName: 'total')
  int get total;

  @BuiltValueField(wireName: 'count')
  Count get count;

  @BuiltValueField(wireName: 'score')
  double get score;

  @nullable
  int get friendScoreVotesCount;

  @nullable
  double get friendScore;

  String toJson() {
    return json.encode(serializers.serializeWith(Rating.serializer, this));
  }

  static Rating fromJson(String jsonString) {
    return serializers.deserializeWith(
        Rating.serializer, json.decode(jsonString));
  }

  static Serializer<Rating> get serializer => _$ratingSerializer;
}
