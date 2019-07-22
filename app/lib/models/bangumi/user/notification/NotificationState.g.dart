// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationState.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<NotificationState> _$notificationStateSerializer =
    new _$NotificationStateSerializer();

class _$NotificationStateSerializer
    implements StructuredSerializer<NotificationState> {
  @override
  final Iterable<Type> types = const [NotificationState, _$NotificationState];
  @override
  final String wireName = 'NotificationState';

  @override
  Iterable serialize(Serializers serializers, NotificationState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.allNotificationItems != null) {
      result
        ..add('allNotificationItems')
        ..add(serializers.serialize(object.allNotificationItems,
            specifiedType: const FullType(
                BuiltList, const [const FullType(BaseNotificationItem)])));
    }
    if (object.unreadNotificationItems != null) {
      result
        ..add('unreadNotificationItems')
        ..add(serializers.serialize(object.unreadNotificationItems,
            specifiedType: const FullType(
                BuiltList, const [const FullType(BaseNotificationItem)])));
    }
    return result;
  }

  @override
  NotificationState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NotificationStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'allNotificationItems':
          result.allNotificationItems.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(BaseNotificationItem)]))
              as BuiltList);
          break;
        case 'unreadNotificationItems':
          result.unreadNotificationItems.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(BaseNotificationItem)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$NotificationState extends NotificationState {
  @override
  final BuiltList<BaseNotificationItem> allNotificationItems;
  @override
  final BuiltList<BaseNotificationItem> unreadNotificationItems;

  factory _$NotificationState(
          [void Function(NotificationStateBuilder) updates]) =>
      (new NotificationStateBuilder()..update(updates)).build();

  _$NotificationState._(
      {this.allNotificationItems, this.unreadNotificationItems})
      : super._();

  @override
  NotificationState rebuild(void Function(NotificationStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NotificationStateBuilder toBuilder() =>
      new NotificationStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationState &&
        allNotificationItems == other.allNotificationItems &&
        unreadNotificationItems == other.unreadNotificationItems;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, allNotificationItems.hashCode),
        unreadNotificationItems.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NotificationState')
          ..add('allNotificationItems', allNotificationItems)
          ..add('unreadNotificationItems', unreadNotificationItems))
        .toString();
  }
}

class NotificationStateBuilder
    implements Builder<NotificationState, NotificationStateBuilder> {
  _$NotificationState _$v;

  ListBuilder<BaseNotificationItem> _allNotificationItems;
  ListBuilder<BaseNotificationItem> get allNotificationItems =>
      _$this._allNotificationItems ??= new ListBuilder<BaseNotificationItem>();
  set allNotificationItems(
          ListBuilder<BaseNotificationItem> allNotificationItems) =>
      _$this._allNotificationItems = allNotificationItems;

  ListBuilder<BaseNotificationItem> _unreadNotificationItems;
  ListBuilder<BaseNotificationItem> get unreadNotificationItems =>
      _$this._unreadNotificationItems ??=
          new ListBuilder<BaseNotificationItem>();
  set unreadNotificationItems(
          ListBuilder<BaseNotificationItem> unreadNotificationItems) =>
      _$this._unreadNotificationItems = unreadNotificationItems;

  NotificationStateBuilder();

  NotificationStateBuilder get _$this {
    if (_$v != null) {
      _allNotificationItems = _$v.allNotificationItems?.toBuilder();
      _unreadNotificationItems = _$v.unreadNotificationItems?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$NotificationState;
  }

  @override
  void update(void Function(NotificationStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NotificationState build() {
    _$NotificationState _$result;
    try {
      _$result = _$v ??
          new _$NotificationState._(
              allNotificationItems: _allNotificationItems?.build(),
              unreadNotificationItems: _unreadNotificationItems?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'allNotificationItems';
        _allNotificationItems?.build();
        _$failedField = 'unreadNotificationItems';
        _unreadNotificationItems?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'NotificationState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
