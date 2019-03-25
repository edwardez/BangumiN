// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FeedChunks.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FeedChunks> _$feedChunksSerializer = new _$FeedChunksSerializer();

class _$FeedChunksSerializer implements StructuredSerializer<FeedChunks> {
  @override
  final Iterable<Type> types = const [FeedChunks, _$FeedChunks];
  @override
  final String wireName = 'FeedChunks';

  @override
  Iterable serialize(Serializers serializers, FeedChunks object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'first',
      serializers.serialize(object.first,
          specifiedType:
              const FullType(BuiltList, const [const FullType(TimelineFeed)])),
      'second',
      serializers.serialize(object.second,
          specifiedType:
              const FullType(BuiltList, const [const FullType(TimelineFeed)])),
    ];

    return result;
  }

  @override
  FeedChunks deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FeedChunksBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'first':
          result.first.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TimelineFeed)]))
              as BuiltList);
          break;
        case 'second':
          result.second.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TimelineFeed)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$FeedChunks extends FeedChunks {
  @override
  final BuiltList<TimelineFeed> first;
  @override
  final BuiltList<TimelineFeed> second;
  int __feedsCount;
  int __firstChunkMaxIdOrNull;
  int __firstChunkMinIdOrNull;
  int __secondChunkMaxIdOrNull;
  int __secondChunkMinIdOrNull;

  factory _$FeedChunks([void updates(FeedChunksBuilder b)]) =>
      (new FeedChunksBuilder()..update(updates)).build();

  _$FeedChunks._({this.first, this.second}) : super._() {
    if (first == null) {
      throw new BuiltValueNullFieldError('FeedChunks', 'first');
    }
    if (second == null) {
      throw new BuiltValueNullFieldError('FeedChunks', 'second');
    }
  }

  @override
  int get feedsCount => __feedsCount ??= super.feedsCount;

  @override
  int get firstChunkMaxIdOrNull =>
      __firstChunkMaxIdOrNull ??= super.firstChunkMaxIdOrNull;

  @override
  int get firstChunkMinIdOrNull =>
      __firstChunkMinIdOrNull ??= super.firstChunkMinIdOrNull;

  @override
  int get secondChunkMaxIdOrNull =>
      __secondChunkMaxIdOrNull ??= super.secondChunkMaxIdOrNull;

  @override
  int get secondChunkMinIdOrNull =>
      __secondChunkMinIdOrNull ??= super.secondChunkMinIdOrNull;

  @override
  FeedChunks rebuild(void updates(FeedChunksBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  FeedChunksBuilder toBuilder() => new FeedChunksBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FeedChunks &&
        first == other.first &&
        second == other.second;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, first.hashCode), second.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FeedChunks')
          ..add('first', first)
          ..add('second', second))
        .toString();
  }
}

class FeedChunksBuilder implements Builder<FeedChunks, FeedChunksBuilder> {
  _$FeedChunks _$v;

  ListBuilder<TimelineFeed> _first;
  ListBuilder<TimelineFeed> get first =>
      _$this._first ??= new ListBuilder<TimelineFeed>();
  set first(ListBuilder<TimelineFeed> first) => _$this._first = first;

  ListBuilder<TimelineFeed> _second;
  ListBuilder<TimelineFeed> get second =>
      _$this._second ??= new ListBuilder<TimelineFeed>();
  set second(ListBuilder<TimelineFeed> second) => _$this._second = second;

  FeedChunksBuilder();

  FeedChunksBuilder get _$this {
    if (_$v != null) {
      _first = _$v.first?.toBuilder();
      _second = _$v.second?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FeedChunks other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FeedChunks;
  }

  @override
  void update(void updates(FeedChunksBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$FeedChunks build() {
    _$FeedChunks _$result;
    try {
      _$result = _$v ??
          new _$FeedChunks._(first: first.build(), second: second.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'first';
        first.build();
        _$failedField = 'second';
        second.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'FeedChunks', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
