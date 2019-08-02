// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SearchState.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SearchState> _$searchStateSerializer = new _$SearchStateSerializer();

class _$SearchStateSerializer implements StructuredSerializer<SearchState> {
  @override
  final Iterable<Type> types = const [SearchState, _$SearchState];
  @override
  final String wireName = 'SearchState';

  @override
  Iterable<Object> serialize(Serializers serializers, SearchState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'results',
      serializers.serialize(object.results,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(SearchRequest),
            const FullType(BangumiSearchResponse)
          ])),
    ];

    return result;
  }

  @override
  SearchState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SearchStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'results':
          result.results.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(SearchRequest),
                const FullType(BangumiSearchResponse)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$SearchState extends SearchState {
  @override
  final BuiltMap<SearchRequest, BangumiSearchResponse> results;

  factory _$SearchState([void Function(SearchStateBuilder) updates]) =>
      (new SearchStateBuilder()..update(updates)).build();

  _$SearchState._({this.results}) : super._() {
    if (results == null) {
      throw new BuiltValueNullFieldError('SearchState', 'results');
    }
  }

  @override
  SearchState rebuild(void Function(SearchStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SearchStateBuilder toBuilder() => new SearchStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SearchState && results == other.results;
  }

  @override
  int get hashCode {
    return $jf($jc(0, results.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SearchState')..add('results', results))
        .toString();
  }
}

class SearchStateBuilder implements Builder<SearchState, SearchStateBuilder> {
  _$SearchState _$v;

  MapBuilder<SearchRequest, BangumiSearchResponse> _results;
  MapBuilder<SearchRequest, BangumiSearchResponse> get results =>
      _$this._results ??=
          new MapBuilder<SearchRequest, BangumiSearchResponse>();
  set results(MapBuilder<SearchRequest, BangumiSearchResponse> results) =>
      _$this._results = results;

  SearchStateBuilder();

  SearchStateBuilder get _$this {
    if (_$v != null) {
      _results = _$v.results?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SearchState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SearchState;
  }

  @override
  void update(void Function(SearchStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SearchState build() {
    _$SearchState _$result;
    try {
      _$result = _$v ?? new _$SearchState._(results: results.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'results';
        results.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SearchState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
