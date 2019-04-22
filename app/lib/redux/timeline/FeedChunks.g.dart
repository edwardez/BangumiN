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
      'hasReachedEnd',
      serializers.serialize(object.hasReachedEnd,
          specifiedType: const FullType(bool)),
      'disableLoadingMore',
      serializers.serialize(object.disableLoadingMore,
          specifiedType: const FullType(bool)),
    ];
    if (object.lastFetchedTime != null) {
      result
        ..add('lastFetchedTime')
        ..add(serializers.serialize(object.lastFetchedTime,
            specifiedType: const FullType(DateTime)));
    }

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
        case 'lastFetchedTime':
          result.lastFetchedTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'hasReachedEnd':
          result.hasReachedEnd = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'disableLoadingMore':
          result.disableLoadingMore = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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
  final DateTime lastFetchedTime;
  @override
  final bool hasReachedEnd;
  @override
  final bool disableLoadingMore;
  bool __isStale;
  int __feedsCount;
  int __firstChunkMaxIdOrNull;
  int __firstChunkMinIdOrNull;

  factory _$FeedChunks([void Function(FeedChunksBuilder) updates]) =>
      (new FeedChunksBuilder()..update(updates)).build();

  _$FeedChunks._(
      {this.first,
      this.lastFetchedTime,
      this.hasReachedEnd,
      this.disableLoadingMore})
      : super._() {
    if (first == null) {
      throw new BuiltValueNullFieldError('FeedChunks', 'first');
    }
    if (hasReachedEnd == null) {
      throw new BuiltValueNullFieldError('FeedChunks', 'hasReachedEnd');
    }
    if (disableLoadingMore == null) {
      throw new BuiltValueNullFieldError('FeedChunks', 'disableLoadingMore');
    }
  }

  @override
  bool get isStale => __isStale ??= super.isStale;

  @override
  int get feedsCount => __feedsCount ??= super.feedsCount;

  @override
  int get firstChunkMaxIdOrNull =>
      __firstChunkMaxIdOrNull ??= super.firstChunkMaxIdOrNull;

  @override
  int get firstChunkMinIdOrNull =>
      __firstChunkMinIdOrNull ??= super.firstChunkMinIdOrNull;

  @override
  FeedChunks rebuild(void Function(FeedChunksBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FeedChunksBuilder toBuilder() => new FeedChunksBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FeedChunks &&
        first == other.first &&
        lastFetchedTime == other.lastFetchedTime &&
        hasReachedEnd == other.hasReachedEnd &&
        disableLoadingMore == other.disableLoadingMore;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, first.hashCode), lastFetchedTime.hashCode),
            hasReachedEnd.hashCode),
        disableLoadingMore.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FeedChunks')
          ..add('first', first)
          ..add('lastFetchedTime', lastFetchedTime)
          ..add('hasReachedEnd', hasReachedEnd)
          ..add('disableLoadingMore', disableLoadingMore))
        .toString();
  }
}

class FeedChunksBuilder implements Builder<FeedChunks, FeedChunksBuilder> {
  _$FeedChunks _$v;

  ListBuilder<TimelineFeed> _first;
  ListBuilder<TimelineFeed> get first =>
      _$this._first ??= new ListBuilder<TimelineFeed>();
  set first(ListBuilder<TimelineFeed> first) => _$this._first = first;

  DateTime _lastFetchedTime;
  DateTime get lastFetchedTime => _$this._lastFetchedTime;
  set lastFetchedTime(DateTime lastFetchedTime) =>
      _$this._lastFetchedTime = lastFetchedTime;

  bool _hasReachedEnd;
  bool get hasReachedEnd => _$this._hasReachedEnd;
  set hasReachedEnd(bool hasReachedEnd) =>
      _$this._hasReachedEnd = hasReachedEnd;

  bool _disableLoadingMore;
  bool get disableLoadingMore => _$this._disableLoadingMore;
  set disableLoadingMore(bool disableLoadingMore) =>
      _$this._disableLoadingMore = disableLoadingMore;

  FeedChunksBuilder();

  FeedChunksBuilder get _$this {
    if (_$v != null) {
      _first = _$v.first?.toBuilder();
      _lastFetchedTime = _$v.lastFetchedTime;
      _hasReachedEnd = _$v.hasReachedEnd;
      _disableLoadingMore = _$v.disableLoadingMore;
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
  void update(void Function(FeedChunksBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FeedChunks build() {
    _$FeedChunks _$result;
    try {
      _$result = _$v ??
          new _$FeedChunks._(
              first: first.build(),
              lastFetchedTime: lastFetchedTime,
              hasReachedEnd: hasReachedEnd,
              disableLoadingMore: disableLoadingMore);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'first';
        first.build();
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
