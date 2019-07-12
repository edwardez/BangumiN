// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListUserCollectionsResponse.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ListUserCollectionsResponse>
    _$listUserCollectionsResponseSerializer =
    new _$ListUserCollectionsResponseSerializer();

class _$ListUserCollectionsResponseSerializer
    implements StructuredSerializer<ListUserCollectionsResponse> {
  @override
  final Iterable<Type> types = const [
    ListUserCollectionsResponse,
    _$ListUserCollectionsResponse
  ];
  @override
  final String wireName = 'ListUserCollectionsResponse';

  @override
  Iterable serialize(
      Serializers serializers, ListUserCollectionsResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'listUserCollectionsRequest',
      serializers.serialize(object.listUserCollectionsRequest,
          specifiedType: const FullType(ListUserCollectionsRequest)),
      'collections',
      serializers.serialize(object.collections,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(int),
            const FullType(CollectionOnUserList)
          ])),
      'userCollectionTags',
      serializers.serialize(object.userCollectionTags,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(UserCollectionTag)
          ])),
      'requestedUntilPageNumber',
      serializers.serialize(object.requestedUntilPageNumber,
          specifiedType: const FullType(int)),
      'canLoadMoreItems',
      serializers.serialize(object.canLoadMoreItems,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  ListUserCollectionsResponse deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ListUserCollectionsResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'listUserCollectionsRequest':
          result.listUserCollectionsRequest.replace(serializers.deserialize(
                  value,
                  specifiedType: const FullType(ListUserCollectionsRequest))
              as ListUserCollectionsRequest);
          break;
        case 'collections':
          result.collections.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(CollectionOnUserList)
              ])) as BuiltMap);
          break;
        case 'userCollectionTags':
          result.userCollectionTags.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(UserCollectionTag)
              ])) as BuiltMap);
          break;
        case 'requestedUntilPageNumber':
          result.requestedUntilPageNumber = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'canLoadMoreItems':
          result.canLoadMoreItems = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$ListUserCollectionsResponse extends ListUserCollectionsResponse {
  @override
  final ListUserCollectionsRequest listUserCollectionsRequest;
  @override
  final BuiltMap<int, CollectionOnUserList> collections;
  @override
  final BuiltMap<String, UserCollectionTag> userCollectionTags;
  @override
  final int requestedUntilPageNumber;
  @override
  final bool canLoadMoreItems;
  List<CollectionOnUserList> __toCollectionsList;

  factory _$ListUserCollectionsResponse(
          [void Function(ListUserCollectionsResponseBuilder) updates]) =>
      (new ListUserCollectionsResponseBuilder()..update(updates)).build();

  _$ListUserCollectionsResponse._(
      {this.listUserCollectionsRequest,
      this.collections,
      this.userCollectionTags,
      this.requestedUntilPageNumber,
      this.canLoadMoreItems})
      : super._() {
    if (listUserCollectionsRequest == null) {
      throw new BuiltValueNullFieldError(
          'ListUserCollectionsResponse', 'listUserCollectionsRequest');
    }
    if (collections == null) {
      throw new BuiltValueNullFieldError(
          'ListUserCollectionsResponse', 'collections');
    }
    if (userCollectionTags == null) {
      throw new BuiltValueNullFieldError(
          'ListUserCollectionsResponse', 'userCollectionTags');
    }
    if (requestedUntilPageNumber == null) {
      throw new BuiltValueNullFieldError(
          'ListUserCollectionsResponse', 'requestedUntilPageNumber');
    }
    if (canLoadMoreItems == null) {
      throw new BuiltValueNullFieldError(
          'ListUserCollectionsResponse', 'canLoadMoreItems');
    }
  }

  @override
  List<CollectionOnUserList> get toCollectionsList =>
      __toCollectionsList ??= super.toCollectionsList;

  @override
  ListUserCollectionsResponse rebuild(
          void Function(ListUserCollectionsResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListUserCollectionsResponseBuilder toBuilder() =>
      new ListUserCollectionsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListUserCollectionsResponse &&
        listUserCollectionsRequest == other.listUserCollectionsRequest &&
        collections == other.collections &&
        userCollectionTags == other.userCollectionTags &&
        requestedUntilPageNumber == other.requestedUntilPageNumber &&
        canLoadMoreItems == other.canLoadMoreItems;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc(0, listUserCollectionsRequest.hashCode),
                    collections.hashCode),
                userCollectionTags.hashCode),
            requestedUntilPageNumber.hashCode),
        canLoadMoreItems.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ListUserCollectionsResponse')
          ..add('listUserCollectionsRequest', listUserCollectionsRequest)
          ..add('collections', collections)
          ..add('userCollectionTags', userCollectionTags)
          ..add('requestedUntilPageNumber', requestedUntilPageNumber)
          ..add('canLoadMoreItems', canLoadMoreItems))
        .toString();
  }
}

class ListUserCollectionsResponseBuilder
    implements
        Builder<ListUserCollectionsResponse,
            ListUserCollectionsResponseBuilder> {
  _$ListUserCollectionsResponse _$v;

  ListUserCollectionsRequestBuilder _listUserCollectionsRequest;
  ListUserCollectionsRequestBuilder get listUserCollectionsRequest =>
      _$this._listUserCollectionsRequest ??=
          new ListUserCollectionsRequestBuilder();
  set listUserCollectionsRequest(
          ListUserCollectionsRequestBuilder listUserCollectionsRequest) =>
      _$this._listUserCollectionsRequest = listUserCollectionsRequest;

  MapBuilder<int, CollectionOnUserList> _collections;
  MapBuilder<int, CollectionOnUserList> get collections =>
      _$this._collections ??= new MapBuilder<int, CollectionOnUserList>();
  set collections(MapBuilder<int, CollectionOnUserList> collections) =>
      _$this._collections = collections;

  MapBuilder<String, UserCollectionTag> _userCollectionTags;
  MapBuilder<String, UserCollectionTag> get userCollectionTags =>
      _$this._userCollectionTags ??=
          new MapBuilder<String, UserCollectionTag>();
  set userCollectionTags(
          MapBuilder<String, UserCollectionTag> userCollectionTags) =>
      _$this._userCollectionTags = userCollectionTags;

  int _requestedUntilPageNumber;
  int get requestedUntilPageNumber => _$this._requestedUntilPageNumber;
  set requestedUntilPageNumber(int requestedUntilPageNumber) =>
      _$this._requestedUntilPageNumber = requestedUntilPageNumber;

  bool _canLoadMoreItems;
  bool get canLoadMoreItems => _$this._canLoadMoreItems;
  set canLoadMoreItems(bool canLoadMoreItems) =>
      _$this._canLoadMoreItems = canLoadMoreItems;

  ListUserCollectionsResponseBuilder();

  ListUserCollectionsResponseBuilder get _$this {
    if (_$v != null) {
      _listUserCollectionsRequest = _$v.listUserCollectionsRequest?.toBuilder();
      _collections = _$v.collections?.toBuilder();
      _userCollectionTags = _$v.userCollectionTags?.toBuilder();
      _requestedUntilPageNumber = _$v.requestedUntilPageNumber;
      _canLoadMoreItems = _$v.canLoadMoreItems;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListUserCollectionsResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ListUserCollectionsResponse;
  }

  @override
  void update(void Function(ListUserCollectionsResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ListUserCollectionsResponse build() {
    _$ListUserCollectionsResponse _$result;
    try {
      _$result = _$v ??
          new _$ListUserCollectionsResponse._(
              listUserCollectionsRequest: listUserCollectionsRequest.build(),
              collections: collections.build(),
              userCollectionTags: userCollectionTags.build(),
              requestedUntilPageNumber: requestedUntilPageNumber,
              canLoadMoreItems: canLoadMoreItems);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'listUserCollectionsRequest';
        listUserCollectionsRequest.build();
        _$failedField = 'collections';
        collections.build();
        _$failedField = 'userCollectionTags';
        userCollectionTags.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ListUserCollectionsResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
