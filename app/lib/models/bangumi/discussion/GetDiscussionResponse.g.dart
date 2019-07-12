// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetDiscussionResponse.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GetDiscussionResponse> _$getDiscussionResponseSerializer =
    new _$GetDiscussionResponseSerializer();

class _$GetDiscussionResponseSerializer
    implements StructuredSerializer<GetDiscussionResponse> {
  @override
  final Iterable<Type> types = const [
    GetDiscussionResponse,
    _$GetDiscussionResponse
  ];
  @override
  final String wireName = 'GetDiscussionResponse';

  @override
  Iterable serialize(Serializers serializers, GetDiscussionResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'discussionItems',
      serializers.serialize(object.discussionItems,
          specifiedType:
              const FullType(BuiltSet, const [const FullType(DiscussionItem)])),
      'appLastUpdatedAt',
      serializers.serialize(object.appLastUpdatedAt,
          specifiedType: const FullType(DateTime)),
    ];

    return result;
  }

  @override
  GetDiscussionResponse deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GetDiscussionResponseBuilder();

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
        case 'appLastUpdatedAt':
          result.appLastUpdatedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
      }
    }

    return result.build();
  }
}

class _$GetDiscussionResponse extends GetDiscussionResponse {
  @override
  final BuiltSet<DiscussionItem> discussionItems;
  @override
  final DateTime appLastUpdatedAt;
  BuiltList<DiscussionItem> __discussionItemsAsList;

  factory _$GetDiscussionResponse(
          [void Function(GetDiscussionResponseBuilder) updates]) =>
      (new GetDiscussionResponseBuilder()..update(updates)).build();

  _$GetDiscussionResponse._({this.discussionItems, this.appLastUpdatedAt})
      : super._() {
    if (discussionItems == null) {
      throw new BuiltValueNullFieldError(
          'GetDiscussionResponse', 'discussionItems');
    }
    if (appLastUpdatedAt == null) {
      throw new BuiltValueNullFieldError(
          'GetDiscussionResponse', 'appLastUpdatedAt');
    }
  }

  @override
  BuiltList<DiscussionItem> get discussionItemsAsList =>
      __discussionItemsAsList ??= super.discussionItemsAsList;

  @override
  GetDiscussionResponse rebuild(
          void Function(GetDiscussionResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetDiscussionResponseBuilder toBuilder() =>
      new GetDiscussionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetDiscussionResponse &&
        discussionItems == other.discussionItems &&
        appLastUpdatedAt == other.appLastUpdatedAt;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc(0, discussionItems.hashCode), appLastUpdatedAt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GetDiscussionResponse')
          ..add('discussionItems', discussionItems)
          ..add('appLastUpdatedAt', appLastUpdatedAt))
        .toString();
  }
}

class GetDiscussionResponseBuilder
    implements Builder<GetDiscussionResponse, GetDiscussionResponseBuilder> {
  _$GetDiscussionResponse _$v;

  SetBuilder<DiscussionItem> _discussionItems;
  SetBuilder<DiscussionItem> get discussionItems =>
      _$this._discussionItems ??= new SetBuilder<DiscussionItem>();
  set discussionItems(SetBuilder<DiscussionItem> discussionItems) =>
      _$this._discussionItems = discussionItems;

  DateTime _appLastUpdatedAt;
  DateTime get appLastUpdatedAt => _$this._appLastUpdatedAt;
  set appLastUpdatedAt(DateTime appLastUpdatedAt) =>
      _$this._appLastUpdatedAt = appLastUpdatedAt;

  GetDiscussionResponseBuilder();

  GetDiscussionResponseBuilder get _$this {
    if (_$v != null) {
      _discussionItems = _$v.discussionItems?.toBuilder();
      _appLastUpdatedAt = _$v.appLastUpdatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetDiscussionResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$GetDiscussionResponse;
  }

  @override
  void update(void Function(GetDiscussionResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GetDiscussionResponse build() {
    _$GetDiscussionResponse _$result;
    try {
      _$result = _$v ??
          new _$GetDiscussionResponse._(
              discussionItems: discussionItems.build(),
              appLastUpdatedAt: appLastUpdatedAt);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'discussionItems';
        discussionItems.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GetDiscussionResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
