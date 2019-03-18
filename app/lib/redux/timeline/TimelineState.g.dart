// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TimelineState.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TimelineState> _$timelineStateSerializer =
    new _$TimelineStateSerializer();

class _$TimelineStateSerializer implements StructuredSerializer<TimelineState> {
  @override
  final Iterable<Type> types = const [TimelineState, _$TimelineState];
  @override
  final String wireName = 'TimelineState';

  @override
  Iterable serialize(Serializers serializers, TimelineState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.feedChunks != null) {
      result
        ..add('feedChunks')
        ..add(serializers.serialize(object.feedChunks,
            specifiedType: const FullType(FeedChunks)));
    }

    return result;
  }

  @override
  TimelineState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TimelineStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'feedChunks':
          result.feedChunks.replace(serializers.deserialize(value,
              specifiedType: const FullType(FeedChunks)) as FeedChunks);
          break;
      }
    }

    return result.build();
  }
}

class _$TimelineState extends TimelineState {
  @override
  final FeedChunks feedChunks;

  factory _$TimelineState([void updates(TimelineStateBuilder b)]) =>
      (new TimelineStateBuilder()..update(updates)).build();

  _$TimelineState._({this.feedChunks}) : super._();

  @override
  TimelineState rebuild(void updates(TimelineStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TimelineStateBuilder toBuilder() => new TimelineStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TimelineState && feedChunks == other.feedChunks;
  }

  @override
  int get hashCode {
    return $jf($jc(0, feedChunks.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TimelineState')
          ..add('feedChunks', feedChunks))
        .toString();
  }
}

class TimelineStateBuilder
    implements Builder<TimelineState, TimelineStateBuilder> {
  _$TimelineState _$v;

  FeedChunksBuilder _feedChunks;

  FeedChunksBuilder get feedChunks =>
      _$this._feedChunks ??= new FeedChunksBuilder();

  set feedChunks(FeedChunksBuilder feedChunks) =>
      _$this._feedChunks = feedChunks;

  TimelineStateBuilder();

  TimelineStateBuilder get _$this {
    if (_$v != null) {
      _feedChunks = _$v.feedChunks?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TimelineState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TimelineState;
  }

  @override
  void update(void updates(TimelineStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TimelineState build() {
    _$TimelineState _$result;
    try {
      _$result = _$v ?? new _$TimelineState._(feedChunks: _feedChunks?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'feedChunks';
        _feedChunks?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TimelineState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
