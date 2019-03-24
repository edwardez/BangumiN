import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'Count.g.dart';

abstract class Count implements Built<Count, CountBuilder> {
  Count._();

  factory Count([updates(CountBuilder b)]) = _$Count;

  /// construct [Count] from a score ascending Array
  /// where scoreArray[0] is value for scoreOne
  /// if scoreArray length is shorter than 10, fill with dummy count value 0
  /// it assumes score starts from scoreOne and ends with scoreTen
  factory Count.fromAscendingScoreArray(List<int> scoreArray) {
    if (scoreArray.length < 10) {
      scoreArray = List.from(scoreArray);
      while (scoreArray.length < 10) {
        scoreArray.add(0);
      }
    }

    return Count((b) => b
      ..scoreOne = scoreArray[0]
      ..scoreTwo = scoreArray[1]
      ..scoreThree = scoreArray[2]
      ..scoreFour = scoreArray[3]
      ..scoreFive = scoreArray[4]
      ..scoreSix = scoreArray[5]
      ..scoreSeven = scoreArray[6]
      ..scoreEight = scoreArray[7]
      ..scoreNine = scoreArray[8]
      ..scoreTen = scoreArray[9]);
  }

  /// construct [Count] from a score descending Array
  /// where scoreArray[0] is value for scoreTen
  /// if scoreArray length is shorter than 10, fill with dummy count value 0
  /// it assumes score starts from scoreOne and ends with scoreTen
  factory Count.fromDescendingScoreArray(List<int> scoreArray) {
    if (scoreArray.length < 10) {
      scoreArray = List.from(scoreArray);
      while (scoreArray.length < 10) {
        scoreArray.add(0);
      }
    }

    return Count((b) => b
      ..scoreOne = scoreArray[9]
      ..scoreTwo = scoreArray[8]
      ..scoreThree = scoreArray[7]
      ..scoreFour = scoreArray[6]
      ..scoreFive = scoreArray[5]
      ..scoreSix = scoreArray[4]
      ..scoreSeven = scoreArray[3]
      ..scoreEight = scoreArray[2]
      ..scoreNine = scoreArray[1]
      ..scoreTen = scoreArray[0]);
  }

  @BuiltValueField(wireName: '1')
  int get scoreOne;

  @BuiltValueField(wireName: '2')
  int get scoreTwo;

  @BuiltValueField(wireName: '3')
  int get scoreThree;

  @BuiltValueField(wireName: '4')
  int get scoreFour;

  @BuiltValueField(wireName: '5')
  int get scoreFive;

  @BuiltValueField(wireName: '6')
  int get scoreSix;

  @BuiltValueField(wireName: '7')
  int get scoreSeven;

  @BuiltValueField(wireName: '8')
  int get scoreEight;

  @BuiltValueField(wireName: '9')
  int get scoreNine;

  @BuiltValueField(wireName: '10')
  int get scoreTen;

  String toJson() {
    return json.encode(serializers.serializeWith(Count.serializer, this));
  }

  static Count fromJson(String jsonString) {
    return serializers.deserializeWith(
        Count.serializer, json.decode(jsonString));
  }

  static Serializer<Count> get serializer => _$countSerializer;
}
