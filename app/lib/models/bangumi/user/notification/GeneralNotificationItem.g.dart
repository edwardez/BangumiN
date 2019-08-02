// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GeneralNotificationItem.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GeneralNotificationItem> _$generalNotificationItemSerializer =
    new _$GeneralNotificationItemSerializer();

class _$GeneralNotificationItemSerializer
    implements StructuredSerializer<GeneralNotificationItem> {
  @override
  final Iterable<Type> types = const [
    GeneralNotificationItem,
    _$GeneralNotificationItem
  ];
  @override
  final String wireName = 'GeneralNotificationItem';

  @override
  Iterable<Object> serialize(
      Serializers serializers, GeneralNotificationItem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'initiator',
      serializers.serialize(object.initiator,
          specifiedType: const FullType(BangumiUserBasic)),
      'bodyContentHtml',
      serializers.serialize(object.bodyContentHtml,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GeneralNotificationItem deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GeneralNotificationItemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'initiator':
          result.initiator.replace(serializers.deserialize(value,
                  specifiedType: const FullType(BangumiUserBasic))
              as BangumiUserBasic);
          break;
        case 'bodyContentHtml':
          result.bodyContentHtml = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GeneralNotificationItem extends GeneralNotificationItem {
  @override
  final int id;
  @override
  final BangumiUserBasic initiator;
  @override
  final String bodyContentHtml;

  factory _$GeneralNotificationItem(
          [void Function(GeneralNotificationItemBuilder) updates]) =>
      (new GeneralNotificationItemBuilder()..update(updates)).build();

  _$GeneralNotificationItem._({this.id, this.initiator, this.bodyContentHtml})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('GeneralNotificationItem', 'id');
    }
    if (initiator == null) {
      throw new BuiltValueNullFieldError(
          'GeneralNotificationItem', 'initiator');
    }
    if (bodyContentHtml == null) {
      throw new BuiltValueNullFieldError(
          'GeneralNotificationItem', 'bodyContentHtml');
    }
  }

  @override
  GeneralNotificationItem rebuild(
          void Function(GeneralNotificationItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GeneralNotificationItemBuilder toBuilder() =>
      new GeneralNotificationItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GeneralNotificationItem &&
        id == other.id &&
        initiator == other.initiator &&
        bodyContentHtml == other.bodyContentHtml;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, id.hashCode), initiator.hashCode),
        bodyContentHtml.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GeneralNotificationItem')
          ..add('id', id)
          ..add('initiator', initiator)
          ..add('bodyContentHtml', bodyContentHtml))
        .toString();
  }
}

class GeneralNotificationItemBuilder
    implements
        Builder<GeneralNotificationItem, GeneralNotificationItemBuilder>,
        BaseNotificationItemBuilder {
  _$GeneralNotificationItem _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  BangumiUserBasicBuilder _initiator;
  BangumiUserBasicBuilder get initiator =>
      _$this._initiator ??= new BangumiUserBasicBuilder();
  set initiator(BangumiUserBasicBuilder initiator) =>
      _$this._initiator = initiator;

  String _bodyContentHtml;
  String get bodyContentHtml => _$this._bodyContentHtml;
  set bodyContentHtml(String bodyContentHtml) =>
      _$this._bodyContentHtml = bodyContentHtml;

  GeneralNotificationItemBuilder();

  GeneralNotificationItemBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _initiator = _$v.initiator?.toBuilder();
      _bodyContentHtml = _$v.bodyContentHtml;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant GeneralNotificationItem other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$GeneralNotificationItem;
  }

  @override
  void update(void Function(GeneralNotificationItemBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GeneralNotificationItem build() {
    _$GeneralNotificationItem _$result;
    try {
      _$result = _$v ??
          new _$GeneralNotificationItem._(
              id: id,
              initiator: initiator.build(),
              bodyContentHtml: bodyContentHtml);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'initiator';
        initiator.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GeneralNotificationItem', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
