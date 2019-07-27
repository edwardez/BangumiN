// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BangumiUserSearchResponse.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BangumiUserSearchResponse> _$bangumiUserSearchResponseSerializer =
    new _$BangumiUserSearchResponseSerializer();

class _$BangumiUserSearchResponseSerializer
    implements StructuredSerializer<BangumiUserSearchResponse> {
  @override
  final Iterable<Type> types = const [
    BangumiUserSearchResponse,
    _$BangumiUserSearchResponse
  ];
  @override
  final String wireName = 'BangumiUserSearchResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, BangumiUserSearchResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'count',
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
            specifiedType: const FullType(BuiltMap, const [
              const FullType(int),
              const FullType(SearchResultItem)
            ])));
    }
    if (object.hasReachedFullMatchEnd != null) {
      result
        ..add('hasReachedFullMatchEnd')
        ..add(serializers.serialize(object.hasReachedFullMatchEnd,
            specifiedType: const FullType(bool)));
    }
    if (object.hasReachedFuzzyMatchEnd != null) {
      result
        ..add('hasReachedFuzzyMatchEnd')
        ..add(serializers.serialize(object.hasReachedFuzzyMatchEnd,
            specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  BangumiUserSearchResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BangumiUserSearchResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'count':
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
                const FullType(SearchResultItem)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
        case 'hasReachedFullMatchEnd':
          result.hasReachedFullMatchEnd = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'hasReachedFuzzyMatchEnd':
          result.hasReachedFuzzyMatchEnd = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$BangumiUserSearchResponse extends BangumiUserSearchResponse {
  @override
  final int totalCount;
  @override
  final int requestedResults;
  @override
  final BuiltMap<int, SearchResultItem> results;
  @override
  final bool hasReachedFullMatchEnd;
  @override
  final bool hasReachedFuzzyMatchEnd;
  List<SearchResultItem> __resultsAsList;
  bool __hasReachedEnd;

  factory _$BangumiUserSearchResponse(
          [void Function(BangumiUserSearchResponseBuilder) updates]) =>
      (new BangumiUserSearchResponseBuilder()..update(updates)).build();

  _$BangumiUserSearchResponse._(
      {this.totalCount,
      this.requestedResults,
      this.results,
      this.hasReachedFullMatchEnd,
      this.hasReachedFuzzyMatchEnd})
      : super._() {
    if (totalCount == null) {
      throw new BuiltValueNullFieldError(
          'BangumiUserSearchResponse', 'totalCount');
    }
  }

  @override
  List<SearchResultItem> get resultsAsList =>
      __resultsAsList ??= super.resultsAsList;

  @override
  bool get hasReachedEnd => __hasReachedEnd ??= super.hasReachedEnd;

  @override
  BangumiUserSearchResponse rebuild(
          void Function(BangumiUserSearchResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BangumiUserSearchResponseBuilder toBuilder() =>
      new BangumiUserSearchResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BangumiUserSearchResponse &&
        totalCount == other.totalCount &&
        requestedResults == other.requestedResults &&
        results == other.results &&
        hasReachedFullMatchEnd == other.hasReachedFullMatchEnd &&
        hasReachedFuzzyMatchEnd == other.hasReachedFuzzyMatchEnd;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, totalCount.hashCode), requestedResults.hashCode),
                results.hashCode),
            hasReachedFullMatchEnd.hashCode),
        hasReachedFuzzyMatchEnd.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BangumiUserSearchResponse')
          ..add('totalCount', totalCount)
          ..add('requestedResults', requestedResults)
          ..add('results', results)
          ..add('hasReachedFullMatchEnd', hasReachedFullMatchEnd)
          ..add('hasReachedFuzzyMatchEnd', hasReachedFuzzyMatchEnd))
        .toString();
  }
}

class BangumiUserSearchResponseBuilder
    implements
        Builder<BangumiUserSearchResponse, BangumiUserSearchResponseBuilder>,
        BangumiSearchResponseBuilder {
  _$BangumiUserSearchResponse _$v;

  int _totalCount;
  int get totalCount => _$this._totalCount;
  set totalCount(int totalCount) => _$this._totalCount = totalCount;

  int _requestedResults;
  int get requestedResults => _$this._requestedResults;
  set requestedResults(int requestedResults) =>
      _$this._requestedResults = requestedResults;

  MapBuilder<int, SearchResultItem> _results;
  MapBuilder<int, SearchResultItem> get results =>
      _$this._results ??= new MapBuilder<int, SearchResultItem>();
  set results(MapBuilder<int, SearchResultItem> results) =>
      _$this._results = results;

  bool _hasReachedFullMatchEnd;
  bool get hasReachedFullMatchEnd => _$this._hasReachedFullMatchEnd;
  set hasReachedFullMatchEnd(bool hasReachedFullMatchEnd) =>
      _$this._hasReachedFullMatchEnd = hasReachedFullMatchEnd;

  bool _hasReachedFuzzyMatchEnd;
  bool get hasReachedFuzzyMatchEnd => _$this._hasReachedFuzzyMatchEnd;
  set hasReachedFuzzyMatchEnd(bool hasReachedFuzzyMatchEnd) =>
      _$this._hasReachedFuzzyMatchEnd = hasReachedFuzzyMatchEnd;

  BangumiUserSearchResponseBuilder();

  BangumiUserSearchResponseBuilder get _$this {
    if (_$v != null) {
      _totalCount = _$v.totalCount;
      _requestedResults = _$v.requestedResults;
      _results = _$v.results?.toBuilder();
      _hasReachedFullMatchEnd = _$v.hasReachedFullMatchEnd;
      _hasReachedFuzzyMatchEnd = _$v.hasReachedFuzzyMatchEnd;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant BangumiUserSearchResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BangumiUserSearchResponse;
  }

  @override
  void update(void Function(BangumiUserSearchResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BangumiUserSearchResponse build() {
    _$BangumiUserSearchResponse _$result;
    try {
      _$result = _$v ??
          new _$BangumiUserSearchResponse._(
              totalCount: totalCount,
              requestedResults: requestedResults,
              results: _results?.build(),
              hasReachedFullMatchEnd: hasReachedFullMatchEnd,
              hasReachedFuzzyMatchEnd: hasReachedFuzzyMatchEnd);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'results';
        _results?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'BangumiUserSearchResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
