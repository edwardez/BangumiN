// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectReviewResponse.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SubjectReviewResponse> _$subjectReviewResponseSerializer =
    new _$SubjectReviewResponseSerializer();

class _$SubjectReviewResponseSerializer
    implements StructuredSerializer<SubjectReviewResponse> {
  @override
  final Iterable<Type> types = const [
    SubjectReviewResponse,
    _$SubjectReviewResponse
  ];
  @override
  final String wireName = 'SubjectReviewResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, SubjectReviewResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'requestedUntilPageNumber',
      serializers.serialize(object.requestedUntilPageNumber,
          specifiedType: const FullType(int)),
      'canLoadMoreItems',
      serializers.serialize(object.canLoadMoreItems,
          specifiedType: const FullType(bool)),
      'items',
      serializers.serialize(object.items,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(SubjectReview)])),
    ];
    if (object.lastValidBangumiPageNumber != null) {
      result
        ..add('lastValidBangumiPageNumber')
        ..add(serializers.serialize(object.lastValidBangumiPageNumber,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  SubjectReviewResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubjectReviewResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'requestedUntilPageNumber':
          result.requestedUntilPageNumber = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'lastValidBangumiPageNumber':
          result.lastValidBangumiPageNumber = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'canLoadMoreItems':
          result.canLoadMoreItems = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'items':
          result.items.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(SubjectReview)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$SubjectReviewResponse extends SubjectReviewResponse {
  @override
  final int requestedUntilPageNumber;
  @override
  final int lastValidBangumiPageNumber;
  @override
  final bool canLoadMoreItems;
  @override
  final BuiltMap<String, SubjectReview> items;

  factory _$SubjectReviewResponse(
          [void Function(SubjectReviewResponseBuilder) updates]) =>
      (new SubjectReviewResponseBuilder()..update(updates)).build();

  _$SubjectReviewResponse._(
      {this.requestedUntilPageNumber,
      this.lastValidBangumiPageNumber,
      this.canLoadMoreItems,
      this.items})
      : super._() {
    if (requestedUntilPageNumber == null) {
      throw new BuiltValueNullFieldError(
          'SubjectReviewResponse', 'requestedUntilPageNumber');
    }
    if (canLoadMoreItems == null) {
      throw new BuiltValueNullFieldError(
          'SubjectReviewResponse', 'canLoadMoreItems');
    }
    if (items == null) {
      throw new BuiltValueNullFieldError('SubjectReviewResponse', 'items');
    }
  }

  @override
  SubjectReviewResponse rebuild(
          void Function(SubjectReviewResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubjectReviewResponseBuilder toBuilder() =>
      new SubjectReviewResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubjectReviewResponse &&
        requestedUntilPageNumber == other.requestedUntilPageNumber &&
        lastValidBangumiPageNumber == other.lastValidBangumiPageNumber &&
        canLoadMoreItems == other.canLoadMoreItems &&
        items == other.items;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc(0, requestedUntilPageNumber.hashCode),
                lastValidBangumiPageNumber.hashCode),
            canLoadMoreItems.hashCode),
        items.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubjectReviewResponse')
          ..add('requestedUntilPageNumber', requestedUntilPageNumber)
          ..add('lastValidBangumiPageNumber', lastValidBangumiPageNumber)
          ..add('canLoadMoreItems', canLoadMoreItems)
          ..add('items', items))
        .toString();
  }
}

class SubjectReviewResponseBuilder
    implements Builder<SubjectReviewResponse, SubjectReviewResponseBuilder> {
  _$SubjectReviewResponse _$v;

  int _requestedUntilPageNumber;
  int get requestedUntilPageNumber => _$this._requestedUntilPageNumber;
  set requestedUntilPageNumber(int requestedUntilPageNumber) =>
      _$this._requestedUntilPageNumber = requestedUntilPageNumber;

  int _lastValidBangumiPageNumber;
  int get lastValidBangumiPageNumber => _$this._lastValidBangumiPageNumber;
  set lastValidBangumiPageNumber(int lastValidBangumiPageNumber) =>
      _$this._lastValidBangumiPageNumber = lastValidBangumiPageNumber;

  bool _canLoadMoreItems;
  bool get canLoadMoreItems => _$this._canLoadMoreItems;
  set canLoadMoreItems(bool canLoadMoreItems) =>
      _$this._canLoadMoreItems = canLoadMoreItems;

  MapBuilder<String, SubjectReview> _items;
  MapBuilder<String, SubjectReview> get items =>
      _$this._items ??= new MapBuilder<String, SubjectReview>();
  set items(MapBuilder<String, SubjectReview> items) => _$this._items = items;

  SubjectReviewResponseBuilder();

  SubjectReviewResponseBuilder get _$this {
    if (_$v != null) {
      _requestedUntilPageNumber = _$v.requestedUntilPageNumber;
      _lastValidBangumiPageNumber = _$v.lastValidBangumiPageNumber;
      _canLoadMoreItems = _$v.canLoadMoreItems;
      _items = _$v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubjectReviewResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubjectReviewResponse;
  }

  @override
  void update(void Function(SubjectReviewResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubjectReviewResponse build() {
    _$SubjectReviewResponse _$result;
    try {
      _$result = _$v ??
          new _$SubjectReviewResponse._(
              requestedUntilPageNumber: requestedUntilPageNumber,
              lastValidBangumiPageNumber: lastValidBangumiPageNumber,
              canLoadMoreItems: canLoadMoreItems,
              items: items.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SubjectReviewResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
