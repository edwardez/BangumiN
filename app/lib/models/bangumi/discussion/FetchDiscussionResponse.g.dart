// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FetchDiscussionResponse.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FetchDiscussionResponse> _$fetchDiscussionResponseSerializer =
    new _$FetchDiscussionResponseSerializer();

class _$FetchDiscussionResponseSerializer
    implements StructuredSerializer<FetchDiscussionResponse> {
  @override
  final Iterable<Type> types = const [
    FetchDiscussionResponse,
    _$FetchDiscussionResponse
  ];
  @override
  final String wireName = 'FetchDiscussionResponse';

  @override
  Iterable serialize(Serializers serializers, FetchDiscussionResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'discussionItems',
      serializers.serialize(object.discussionItems,
          specifiedType:
              const FullType(BuiltSet, const [const FullType(DiscussionItem)])),
      'lastFetchedTime',
      serializers.serialize(object.lastFetchedTime,
          specifiedType: const FullType(DateTime)),
    ];

    return result;
  }

  @override
  FetchDiscussionResponse deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FetchDiscussionResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'discussionItems':
          result.discussionItems.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltSet, const [const FullType(DiscussionItem)]))
              as BuiltSet);
          break;
        case 'lastFetchedTime':
          result.lastFetchedTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
      }
    }

    return result.build();
  }
}

class _$FetchDiscussionResponse extends FetchDiscussionResponse {
  @override
  final BuiltSet<DiscussionItem> discussionItems;
  @override
  final DateTime lastFetchedTime;
  BuiltList<DiscussionItem> __discussionItemsAsList;

  factory _$FetchDiscussionResponse(
          [void Function(FetchDiscussionResponseBuilder) updates]) =>
      (new FetchDiscussionResponseBuilder()..update(updates)).build();

  _$FetchDiscussionResponse._({this.discussionItems, this.lastFetchedTime})
      : super._() {
    if (discussionItems == null) {
      throw new BuiltValueNullFieldError(
          'FetchDiscussionResponse', 'discussionItems');
    }
    if (lastFetchedTime == null) {
      throw new BuiltValueNullFieldError(
          'FetchDiscussionResponse', 'lastFetchedTime');
    }
  }

  @override
  BuiltList<DiscussionItem> get discussionItemsAsList =>
      __discussionItemsAsList ??= super.discussionItemsAsList;

  @override
  FetchDiscussionResponse rebuild(
          void Function(FetchDiscussionResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FetchDiscussionResponseBuilder toBuilder() =>
      new FetchDiscussionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FetchDiscussionResponse &&
        discussionItems == other.discussionItems &&
        lastFetchedTime == other.lastFetchedTime;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, discussionItems.hashCode), lastFetchedTime.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FetchDiscussionResponse')
          ..add('discussionItems', discussionItems)
          ..add('lastFetchedTime', lastFetchedTime))
        .toString();
  }
}

class FetchDiscussionResponseBuilder
    implements
        Builder<FetchDiscussionResponse, FetchDiscussionResponseBuilder> {
  _$FetchDiscussionResponse _$v;

  SetBuilder<DiscussionItem> _discussionItems;
  SetBuilder<DiscussionItem> get discussionItems =>
      _$this._discussionItems ??= new SetBuilder<DiscussionItem>();
  set discussionItems(SetBuilder<DiscussionItem> discussionItems) =>
      _$this._discussionItems = discussionItems;

  DateTime _lastFetchedTime;
  DateTime get lastFetchedTime => _$this._lastFetchedTime;
  set lastFetchedTime(DateTime lastFetchedTime) =>
      _$this._lastFetchedTime = lastFetchedTime;

  FetchDiscussionResponseBuilder();

  FetchDiscussionResponseBuilder get _$this {
    if (_$v != null) {
      _discussionItems = _$v.discussionItems?.toBuilder();
      _lastFetchedTime = _$v.lastFetchedTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FetchDiscussionResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FetchDiscussionResponse;
  }

  @override
  void update(void Function(FetchDiscussionResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FetchDiscussionResponse build() {
    _$FetchDiscussionResponse _$result;
    try {
      _$result = _$v ??
          new _$FetchDiscussionResponse._(
              discussionItems: discussionItems.build(),
              lastFetchedTime: lastFetchedTime);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'discussionItems';
        discussionItems.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'FetchDiscussionResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
