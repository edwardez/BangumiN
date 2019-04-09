// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SearchRequest.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SearchRequest> _$searchRequestSerializer =
    new _$SearchRequestSerializer();

class _$SearchRequestSerializer implements StructuredSerializer<SearchRequest> {
  @override
  final Iterable<Type> types = const [SearchRequest, _$SearchRequest];
  @override
  final String wireName = 'SearchRequest';

  @override
  Iterable serialize(Serializers serializers, SearchRequest object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'query',
      serializers.serialize(object.query,
          specifiedType: const FullType(String)),
      'searchType',
      serializers.serialize(object.searchType,
          specifiedType: const FullType(SearchType)),
    ];

    return result;
  }

  @override
  SearchRequest deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SearchRequestBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'query':
          result.query = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'searchType':
          result.searchType = serializers.deserialize(value,
              specifiedType: const FullType(SearchType)) as SearchType;
          break;
      }
    }

    return result.build();
  }
}

class _$SearchRequest extends SearchRequest {
  @override
  final String query;
  @override
  final SearchType searchType;

  factory _$SearchRequest([void updates(SearchRequestBuilder b)]) =>
      (new SearchRequestBuilder()..update(updates)).build();

  _$SearchRequest._({this.query, this.searchType}) : super._() {
    if (query == null) {
      throw new BuiltValueNullFieldError('SearchRequest', 'query');
    }
    if (searchType == null) {
      throw new BuiltValueNullFieldError('SearchRequest', 'searchType');
    }
  }

  @override
  SearchRequest rebuild(void updates(SearchRequestBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  SearchRequestBuilder toBuilder() => new SearchRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SearchRequest &&
        query == other.query &&
        searchType == other.searchType;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, query.hashCode), searchType.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SearchRequest')
          ..add('query', query)
          ..add('searchType', searchType))
        .toString();
  }
}

class SearchRequestBuilder
    implements Builder<SearchRequest, SearchRequestBuilder> {
  _$SearchRequest _$v;

  String _query;
  String get query => _$this._query;
  set query(String query) => _$this._query = query;

  SearchType _searchType;
  SearchType get searchType => _$this._searchType;
  set searchType(SearchType searchType) => _$this._searchType = searchType;

  SearchRequestBuilder();

  SearchRequestBuilder get _$this {
    if (_$v != null) {
      _query = _$v.query;
      _searchType = _$v.searchType;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SearchRequest other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SearchRequest;
  }

  @override
  void update(void updates(SearchRequestBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$SearchRequest build() {
    final _$result =
        _$v ?? new _$SearchRequest._(query: query, searchType: searchType);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
