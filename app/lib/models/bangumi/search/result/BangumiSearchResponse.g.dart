// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BangumiSearchResponse.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BangumiSearchResponse> _$bangumiSearchResponseSerializer =
    new _$BangumiSearchResponseSerializer();

class _$BangumiSearchResponseSerializer
    implements StructuredSerializer<BangumiSearchResponse> {
  @override
  final Iterable<Type> types = const [
    BangumiSearchResponse,
    _$BangumiSearchResponse
  ];
  @override
  final String wireName = 'BangumiSearchResponse';

  @override
  Iterable serialize(Serializers serializers, BangumiSearchResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'results',
      serializers.serialize(object.totalCount,
          specifiedType: const FullType(int)),
    ];
    if (object.requestedResults != null) {
      result
        ..add('requestedResults')
        ..add(serializers.serialize(object.requestedResults,
            specifiedType: const FullType(int)));
    }
    if (object.results != null) {
      result
        ..add('results')
        ..add(serializers.serialize(object.results,
            specifiedType: const FullType(BuiltMap,
                const [const FullType(int), const FullType(SearchResult)])));
    }

    return result;
  }

  @override
  BangumiSearchResponse deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BangumiSearchResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'results':
          result.totalCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'requestedResults':
          result.requestedResults = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'results':
          result.results.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(SearchResult)
              ])) as BuiltMap);
          break;
      }
    }

    return result.build();
  }
}

class _$BangumiSearchResponse extends BangumiSearchResponse {
  @override
  final int totalCount;
  @override
  final int requestedResults;
  @override
  final BuiltMap<int, SearchResult> results;
  List<SearchResult> __resultsAsList;
  bool __hasReachedEnd;

  factory _$BangumiSearchResponse(
          [void updates(BangumiSearchResponseBuilder b)]) =>
      (new BangumiSearchResponseBuilder()..update(updates)).build();

  _$BangumiSearchResponse._(
      {this.totalCount, this.requestedResults, this.results})
      : super._() {
    if (totalCount == null) {
      throw new BuiltValueNullFieldError('BangumiSearchResponse', 'totalCount');
    }
  }

  @override
  List<SearchResult> get resultsAsList =>
      __resultsAsList ??= super.resultsAsList;

  @override
  bool get hasReachedEnd => __hasReachedEnd ??= super.hasReachedEnd;

  @override
  BangumiSearchResponse rebuild(void updates(BangumiSearchResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  BangumiSearchResponseBuilder toBuilder() =>
      new BangumiSearchResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BangumiSearchResponse &&
        totalCount == other.totalCount &&
        requestedResults == other.requestedResults &&
        results == other.results;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, totalCount.hashCode), requestedResults.hashCode),
        results.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BangumiSearchResponse')
          ..add('totalCount', totalCount)
          ..add('requestedResults', requestedResults)
          ..add('results', results))
        .toString();
  }
}

class BangumiSearchResponseBuilder
    implements Builder<BangumiSearchResponse, BangumiSearchResponseBuilder> {
  _$BangumiSearchResponse _$v;

  int _totalCount;
  int get totalCount => _$this._totalCount;
  set totalCount(int totalCount) => _$this._totalCount = totalCount;

  int _requestedResults;
  int get requestedResults => _$this._requestedResults;
  set requestedResults(int requestedResults) =>
      _$this._requestedResults = requestedResults;

  MapBuilder<int, SearchResult> _results;
  MapBuilder<int, SearchResult> get results =>
      _$this._results ??= new MapBuilder<int, SearchResult>();
  set results(MapBuilder<int, SearchResult> results) =>
      _$this._results = results;

  BangumiSearchResponseBuilder();

  BangumiSearchResponseBuilder get _$this {
    if (_$v != null) {
      _totalCount = _$v.totalCount;
      _requestedResults = _$v.requestedResults;
      _results = _$v.results?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BangumiSearchResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BangumiSearchResponse;
  }

  @override
  void update(void updates(BangumiSearchResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$BangumiSearchResponse build() {
    _$BangumiSearchResponse _$result;
    try {
      _$result = _$v ??
          new _$BangumiSearchResponse._(
              totalCount: totalCount,
              requestedResults: requestedResults,
              results: _results?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'results';
        _results?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'BangumiSearchResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
