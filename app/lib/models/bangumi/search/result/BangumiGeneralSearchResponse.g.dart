// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BangumiGeneralSearchResponse.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BangumiGeneralSearchResponse>
    _$bangumiGeneralSearchResponseSerializer =
    new _$BangumiGeneralSearchResponseSerializer();

class _$BangumiGeneralSearchResponseSerializer
    implements StructuredSerializer<BangumiGeneralSearchResponse> {
  @override
  final Iterable<Type> types = const [
    BangumiGeneralSearchResponse,
    _$BangumiGeneralSearchResponse
  ];
  @override
  final String wireName = 'BangumiGeneralSearchResponse';

  @override
  Iterable serialize(
      Serializers serializers, BangumiGeneralSearchResponse object,
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
            specifiedType: const FullType(BuiltMap, const [
              const FullType(int),
              const FullType(SearchResultItem)
            ])));
    }
    return result;
  }

  @override
  BangumiGeneralSearchResponse deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BangumiGeneralSearchResponseBuilder();

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
                const FullType(SearchResultItem)
              ])) as BuiltMap);
          break;
      }
    }

    return result.build();
  }
}

class _$BangumiGeneralSearchResponse extends BangumiGeneralSearchResponse {
  @override
  final int totalCount;
  @override
  final int requestedResults;
  @override
  final BuiltMap<int, SearchResultItem> results;
  List<SearchResultItem> __resultsToList;
  bool __hasReachedEnd;

  factory _$BangumiGeneralSearchResponse(
          [void Function(BangumiGeneralSearchResponseBuilder) updates]) =>
      (new BangumiGeneralSearchResponseBuilder()..update(updates)).build();

  _$BangumiGeneralSearchResponse._(
      {this.totalCount, this.requestedResults, this.results})
      : super._() {
    if (totalCount == null) {
      throw new BuiltValueNullFieldError(
          'BangumiGeneralSearchResponse', 'totalCount');
    }
  }

  @override
  List<SearchResultItem> get resultsToList =>
      __resultsToList ??= super.resultsToList;

  @override
  bool get hasReachedEnd => __hasReachedEnd ??= super.hasReachedEnd;

  @override
  BangumiGeneralSearchResponse rebuild(
          void Function(BangumiGeneralSearchResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BangumiGeneralSearchResponseBuilder toBuilder() =>
      new BangumiGeneralSearchResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BangumiGeneralSearchResponse &&
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
    return (newBuiltValueToStringHelper('BangumiGeneralSearchResponse')
          ..add('totalCount', totalCount)
          ..add('requestedResults', requestedResults)
          ..add('results', results))
        .toString();
  }
}

class BangumiGeneralSearchResponseBuilder
    implements
        Builder<BangumiGeneralSearchResponse,
            BangumiGeneralSearchResponseBuilder>,
        BangumiSearchResponseBuilder {
  _$BangumiGeneralSearchResponse _$v;

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

  BangumiGeneralSearchResponseBuilder();

  BangumiGeneralSearchResponseBuilder get _$this {
    if (_$v != null) {
      _totalCount = _$v.totalCount;
      _requestedResults = _$v.requestedResults;
      _results = _$v.results?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant BangumiGeneralSearchResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BangumiGeneralSearchResponse;
  }

  @override
  void update(void Function(BangumiGeneralSearchResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BangumiGeneralSearchResponse build() {
    _$BangumiGeneralSearchResponse _$result;
    try {
      _$result = _$v ??
          new _$BangumiGeneralSearchResponse._(
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
            'BangumiGeneralSearchResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
