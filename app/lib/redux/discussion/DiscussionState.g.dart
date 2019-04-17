// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DiscussionState.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DiscussionState> _$discussionStateSerializer =
    new _$DiscussionStateSerializer();

class _$DiscussionStateSerializer
    implements StructuredSerializer<DiscussionState> {
  @override
  final Iterable<Type> types = const [DiscussionState, _$DiscussionState];
  @override
  final String wireName = 'DiscussionState';

  @override
  Iterable serialize(Serializers serializers, DiscussionState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'results',
      serializers.serialize(object.results,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(FetchDiscussionRequest),
            const FullType(FetchDiscussionResponse)
          ])),
    ];
    if (object.fetchDiscussionRequestStatus != null) {
      result
        ..add('fetchDiscussionRequestStatus')
        ..add(serializers.serialize(object.fetchDiscussionRequestStatus,
            specifiedType: const FullType(BuiltMap, const [
              const FullType(FetchDiscussionRequest),
              const FullType(LoadingStatus)
            ])));
    }

    return result;
  }

  @override
  DiscussionState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DiscussionStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'results':
          result.results.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(FetchDiscussionRequest),
                const FullType(FetchDiscussionResponse)
              ])) as BuiltMap);
          break;
        case 'fetchDiscussionRequestStatus':
          result.fetchDiscussionRequestStatus.replace(serializers.deserialize(
              value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(FetchDiscussionRequest),
                const FullType(LoadingStatus)
              ])) as BuiltMap);
          break;
      }
    }

    return result.build();
  }
}

class _$DiscussionState extends DiscussionState {
  @override
  final BuiltMap<FetchDiscussionRequest, FetchDiscussionResponse> results;
  @override
  final BuiltMap<FetchDiscussionRequest, LoadingStatus>
      fetchDiscussionRequestStatus;

  factory _$DiscussionState([void Function(DiscussionStateBuilder) updates]) =>
      (new DiscussionStateBuilder()..update(updates)).build();

  _$DiscussionState._({this.results, this.fetchDiscussionRequestStatus})
      : super._() {
    if (results == null) {
      throw new BuiltValueNullFieldError('DiscussionState', 'results');
    }
  }

  @override
  DiscussionState rebuild(void Function(DiscussionStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DiscussionStateBuilder toBuilder() =>
      new DiscussionStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DiscussionState &&
        results == other.results &&
        fetchDiscussionRequestStatus == other.fetchDiscussionRequestStatus;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc(0, results.hashCode), fetchDiscussionRequestStatus.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DiscussionState')
          ..add('results', results)
          ..add('fetchDiscussionRequestStatus', fetchDiscussionRequestStatus))
        .toString();
  }
}

class DiscussionStateBuilder
    implements Builder<DiscussionState, DiscussionStateBuilder> {
  _$DiscussionState _$v;

  MapBuilder<FetchDiscussionRequest, FetchDiscussionResponse> _results;
  MapBuilder<FetchDiscussionRequest, FetchDiscussionResponse> get results =>
      _$this._results ??=
          new MapBuilder<FetchDiscussionRequest, FetchDiscussionResponse>();
  set results(
          MapBuilder<FetchDiscussionRequest, FetchDiscussionResponse>
              results) =>
      _$this._results = results;

  MapBuilder<FetchDiscussionRequest, LoadingStatus>
      _fetchDiscussionRequestStatus;
  MapBuilder<FetchDiscussionRequest, LoadingStatus>
      get fetchDiscussionRequestStatus =>
          _$this._fetchDiscussionRequestStatus ??=
              new MapBuilder<FetchDiscussionRequest, LoadingStatus>();
  set fetchDiscussionRequestStatus(
          MapBuilder<FetchDiscussionRequest, LoadingStatus>
              fetchDiscussionRequestStatus) =>
      _$this._fetchDiscussionRequestStatus = fetchDiscussionRequestStatus;

  DiscussionStateBuilder();

  DiscussionStateBuilder get _$this {
    if (_$v != null) {
      _results = _$v.results?.toBuilder();
      _fetchDiscussionRequestStatus =
          _$v.fetchDiscussionRequestStatus?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DiscussionState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DiscussionState;
  }

  @override
  void update(void Function(DiscussionStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DiscussionState build() {
    _$DiscussionState _$result;
    try {
      _$result = _$v ??
          new _$DiscussionState._(
              results: results.build(),
              fetchDiscussionRequestStatus:
                  _fetchDiscussionRequestStatus?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'results';
        results.build();
        _$failedField = 'fetchDiscussionRequestStatus';
        _fetchDiscussionRequestStatus?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DiscussionState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
