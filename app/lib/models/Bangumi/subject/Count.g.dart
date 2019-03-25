// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Count.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Count> _$countSerializer = new _$CountSerializer();

class _$CountSerializer implements StructuredSerializer<Count> {
  @override
  final Iterable<Type> types = const [Count, _$Count];
  @override
  final String wireName = 'Count';

  @override
  Iterable serialize(Serializers serializers, Count object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      '1',
      serializers.serialize(object.scoreOne,
          specifiedType: const FullType(int)),
      '2',
      serializers.serialize(object.scoreTwo,
          specifiedType: const FullType(int)),
      '3',
      serializers.serialize(object.scoreThree,
          specifiedType: const FullType(int)),
      '4',
      serializers.serialize(object.scoreFour,
          specifiedType: const FullType(int)),
      '5',
      serializers.serialize(object.scoreFive,
          specifiedType: const FullType(int)),
      '6',
      serializers.serialize(object.scoreSix,
          specifiedType: const FullType(int)),
      '7',
      serializers.serialize(object.scoreSeven,
          specifiedType: const FullType(int)),
      '8',
      serializers.serialize(object.scoreEight,
          specifiedType: const FullType(int)),
      '9',
      serializers.serialize(object.scoreNine,
          specifiedType: const FullType(int)),
      '10',
      serializers.serialize(object.scoreTen,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  Count deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CountBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case '1':
          result.scoreOne = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case '2':
          result.scoreTwo = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case '3':
          result.scoreThree = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case '4':
          result.scoreFour = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case '5':
          result.scoreFive = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case '6':
          result.scoreSix = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case '7':
          result.scoreSeven = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case '8':
          result.scoreEight = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case '9':
          result.scoreNine = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case '10':
          result.scoreTen = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$Count extends Count {
  @override
  final int scoreOne;
  @override
  final int scoreTwo;
  @override
  final int scoreThree;
  @override
  final int scoreFour;
  @override
  final int scoreFive;
  @override
  final int scoreSix;
  @override
  final int scoreSeven;
  @override
  final int scoreEight;
  @override
  final int scoreNine;
  @override
  final int scoreTen;

  factory _$Count([void updates(CountBuilder b)]) =>
      (new CountBuilder()..update(updates)).build();

  _$Count._(
      {this.scoreOne,
      this.scoreTwo,
      this.scoreThree,
      this.scoreFour,
      this.scoreFive,
      this.scoreSix,
      this.scoreSeven,
      this.scoreEight,
      this.scoreNine,
      this.scoreTen})
      : super._() {
    if (scoreOne == null) {
      throw new BuiltValueNullFieldError('Count', 'scoreOne');
    }
    if (scoreTwo == null) {
      throw new BuiltValueNullFieldError('Count', 'scoreTwo');
    }
    if (scoreThree == null) {
      throw new BuiltValueNullFieldError('Count', 'scoreThree');
    }
    if (scoreFour == null) {
      throw new BuiltValueNullFieldError('Count', 'scoreFour');
    }
    if (scoreFive == null) {
      throw new BuiltValueNullFieldError('Count', 'scoreFive');
    }
    if (scoreSix == null) {
      throw new BuiltValueNullFieldError('Count', 'scoreSix');
    }
    if (scoreSeven == null) {
      throw new BuiltValueNullFieldError('Count', 'scoreSeven');
    }
    if (scoreEight == null) {
      throw new BuiltValueNullFieldError('Count', 'scoreEight');
    }
    if (scoreNine == null) {
      throw new BuiltValueNullFieldError('Count', 'scoreNine');
    }
    if (scoreTen == null) {
      throw new BuiltValueNullFieldError('Count', 'scoreTen');
    }
  }

  @override
  Count rebuild(void updates(CountBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CountBuilder toBuilder() => new CountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Count &&
        scoreOne == other.scoreOne &&
        scoreTwo == other.scoreTwo &&
        scoreThree == other.scoreThree &&
        scoreFour == other.scoreFour &&
        scoreFive == other.scoreFive &&
        scoreSix == other.scoreSix &&
        scoreSeven == other.scoreSeven &&
        scoreEight == other.scoreEight &&
        scoreNine == other.scoreNine &&
        scoreTen == other.scoreTen;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc($jc(0, scoreOne.hashCode),
                                        scoreTwo.hashCode),
                                    scoreThree.hashCode),
                                scoreFour.hashCode),
                            scoreFive.hashCode),
                        scoreSix.hashCode),
                    scoreSeven.hashCode),
                scoreEight.hashCode),
            scoreNine.hashCode),
        scoreTen.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Count')
          ..add('scoreOne', scoreOne)
          ..add('scoreTwo', scoreTwo)
          ..add('scoreThree', scoreThree)
          ..add('scoreFour', scoreFour)
          ..add('scoreFive', scoreFive)
          ..add('scoreSix', scoreSix)
          ..add('scoreSeven', scoreSeven)
          ..add('scoreEight', scoreEight)
          ..add('scoreNine', scoreNine)
          ..add('scoreTen', scoreTen))
        .toString();
  }
}

class CountBuilder implements Builder<Count, CountBuilder> {
  _$Count _$v;

  int _scoreOne;
  int get scoreOne => _$this._scoreOne;
  set scoreOne(int scoreOne) => _$this._scoreOne = scoreOne;

  int _scoreTwo;
  int get scoreTwo => _$this._scoreTwo;
  set scoreTwo(int scoreTwo) => _$this._scoreTwo = scoreTwo;

  int _scoreThree;
  int get scoreThree => _$this._scoreThree;
  set scoreThree(int scoreThree) => _$this._scoreThree = scoreThree;

  int _scoreFour;
  int get scoreFour => _$this._scoreFour;
  set scoreFour(int scoreFour) => _$this._scoreFour = scoreFour;

  int _scoreFive;
  int get scoreFive => _$this._scoreFive;
  set scoreFive(int scoreFive) => _$this._scoreFive = scoreFive;

  int _scoreSix;
  int get scoreSix => _$this._scoreSix;
  set scoreSix(int scoreSix) => _$this._scoreSix = scoreSix;

  int _scoreSeven;
  int get scoreSeven => _$this._scoreSeven;
  set scoreSeven(int scoreSeven) => _$this._scoreSeven = scoreSeven;

  int _scoreEight;
  int get scoreEight => _$this._scoreEight;
  set scoreEight(int scoreEight) => _$this._scoreEight = scoreEight;

  int _scoreNine;
  int get scoreNine => _$this._scoreNine;
  set scoreNine(int scoreNine) => _$this._scoreNine = scoreNine;

  int _scoreTen;
  int get scoreTen => _$this._scoreTen;
  set scoreTen(int scoreTen) => _$this._scoreTen = scoreTen;

  CountBuilder();

  CountBuilder get _$this {
    if (_$v != null) {
      _scoreOne = _$v.scoreOne;
      _scoreTwo = _$v.scoreTwo;
      _scoreThree = _$v.scoreThree;
      _scoreFour = _$v.scoreFour;
      _scoreFive = _$v.scoreFive;
      _scoreSix = _$v.scoreSix;
      _scoreSeven = _$v.scoreSeven;
      _scoreEight = _$v.scoreEight;
      _scoreNine = _$v.scoreNine;
      _scoreTen = _$v.scoreTen;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Count other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Count;
  }

  @override
  void update(void updates(CountBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Count build() {
    final _$result = _$v ??
        new _$Count._(
            scoreOne: scoreOne,
            scoreTwo: scoreTwo,
            scoreThree: scoreThree,
            scoreFour: scoreFour,
            scoreFive: scoreFive,
            scoreSix: scoreSix,
            scoreSeven: scoreSeven,
            scoreEight: scoreEight,
            scoreNine: scoreNine,
            scoreTen: scoreTen);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
