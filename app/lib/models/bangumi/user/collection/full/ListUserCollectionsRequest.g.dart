// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListUserCollectionsRequest.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ListUserCollectionsRequest> _$listUserCollectionsRequestSerializer =
    new _$ListUserCollectionsRequestSerializer();

class _$ListUserCollectionsRequestSerializer
    implements StructuredSerializer<ListUserCollectionsRequest> {
  @override
  final Iterable<Type> types = const [
    ListUserCollectionsRequest,
    _$ListUserCollectionsRequest
  ];
  @override
  final String wireName = 'ListUserCollectionsRequest';

  @override
  Iterable serialize(Serializers serializers, ListUserCollectionsRequest object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
      'subjectType',
      serializers.serialize(object.subjectType,
          specifiedType: const FullType(SubjectType)),
      'collectionStatus',
      serializers.serialize(object.collectionStatus,
          specifiedType: const FullType(CollectionStatus)),
      'orderCollectionBy',
      serializers.serialize(object.orderCollectionBy,
          specifiedType: const FullType(OrderCollectionBy)),
    ];
    if (object.filterTag != null) {
      result
        ..add('filterTag')
        ..add(serializers.serialize(object.filterTag,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ListUserCollectionsRequest deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ListUserCollectionsRequestBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'subjectType':
          result.subjectType = serializers.deserialize(value,
              specifiedType: const FullType(SubjectType)) as SubjectType;
          break;
        case 'collectionStatus':
          result.collectionStatus = serializers.deserialize(value,
                  specifiedType: const FullType(CollectionStatus))
              as CollectionStatus;
          break;
        case 'orderCollectionBy':
          result.orderCollectionBy = serializers.deserialize(value,
                  specifiedType: const FullType(OrderCollectionBy))
              as OrderCollectionBy;
          break;
        case 'filterTag':
          result.filterTag = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ListUserCollectionsRequest extends ListUserCollectionsRequest {
  @override
  final String username;
  @override
  final SubjectType subjectType;
  @override
  final CollectionStatus collectionStatus;
  @override
  final OrderCollectionBy orderCollectionBy;
  @override
  final String filterTag;

  factory _$ListUserCollectionsRequest(
          [void Function(ListUserCollectionsRequestBuilder) updates]) =>
      (new ListUserCollectionsRequestBuilder()..update(updates)).build();

  _$ListUserCollectionsRequest._(
      {this.username,
      this.subjectType,
      this.collectionStatus,
      this.orderCollectionBy,
      this.filterTag})
      : super._() {
    if (username == null) {
      throw new BuiltValueNullFieldError(
          'ListUserCollectionsRequest', 'username');
    }
    if (subjectType == null) {
      throw new BuiltValueNullFieldError(
          'ListUserCollectionsRequest', 'subjectType');
    }
    if (collectionStatus == null) {
      throw new BuiltValueNullFieldError(
          'ListUserCollectionsRequest', 'collectionStatus');
    }
    if (orderCollectionBy == null) {
      throw new BuiltValueNullFieldError(
          'ListUserCollectionsRequest', 'orderCollectionBy');
    }
  }

  @override
  ListUserCollectionsRequest rebuild(
          void Function(ListUserCollectionsRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListUserCollectionsRequestBuilder toBuilder() =>
      new ListUserCollectionsRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListUserCollectionsRequest &&
        username == other.username &&
        subjectType == other.subjectType &&
        collectionStatus == other.collectionStatus &&
        orderCollectionBy == other.orderCollectionBy &&
        filterTag == other.filterTag;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, username.hashCode), subjectType.hashCode),
                collectionStatus.hashCode),
            orderCollectionBy.hashCode),
        filterTag.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ListUserCollectionsRequest')
          ..add('username', username)
          ..add('subjectType', subjectType)
          ..add('collectionStatus', collectionStatus)
          ..add('orderCollectionBy', orderCollectionBy)
          ..add('filterTag', filterTag))
        .toString();
  }
}

class ListUserCollectionsRequestBuilder
    implements
        Builder<ListUserCollectionsRequest, ListUserCollectionsRequestBuilder> {
  _$ListUserCollectionsRequest _$v;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  SubjectType _subjectType;
  SubjectType get subjectType => _$this._subjectType;
  set subjectType(SubjectType subjectType) => _$this._subjectType = subjectType;

  CollectionStatus _collectionStatus;
  CollectionStatus get collectionStatus => _$this._collectionStatus;
  set collectionStatus(CollectionStatus collectionStatus) =>
      _$this._collectionStatus = collectionStatus;

  OrderCollectionBy _orderCollectionBy;
  OrderCollectionBy get orderCollectionBy => _$this._orderCollectionBy;
  set orderCollectionBy(OrderCollectionBy orderCollectionBy) =>
      _$this._orderCollectionBy = orderCollectionBy;

  String _filterTag;
  String get filterTag => _$this._filterTag;
  set filterTag(String filterTag) => _$this._filterTag = filterTag;

  ListUserCollectionsRequestBuilder();

  ListUserCollectionsRequestBuilder get _$this {
    if (_$v != null) {
      _username = _$v.username;
      _subjectType = _$v.subjectType;
      _collectionStatus = _$v.collectionStatus;
      _orderCollectionBy = _$v.orderCollectionBy;
      _filterTag = _$v.filterTag;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListUserCollectionsRequest other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ListUserCollectionsRequest;
  }

  @override
  void update(void Function(ListUserCollectionsRequestBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ListUserCollectionsRequest build() {
    final _$result = _$v ??
        new _$ListUserCollectionsRequest._(
            username: username,
            subjectType: subjectType,
            collectionStatus: collectionStatus,
            orderCollectionBy: orderCollectionBy,
            filterTag: filterTag);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
