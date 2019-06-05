// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BasicAppState.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BasicAppState> _$basicAppStateSerializer =
    new _$BasicAppStateSerializer();

class _$BasicAppStateSerializer implements StructuredSerializer<BasicAppState> {
  @override
  final Iterable<Type> types = const [BasicAppState, _$BasicAppState];
  @override
  final String wireName = 'BasicAppState';

  @override
  Iterable serialize(Serializers serializers, BasicAppState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'currentAuthenticatedUserBasicInfo',
      serializers.serialize(object.currentAuthenticatedUserBasicInfo,
          specifiedType: const FullType(BangumiUserSmall)),
      'isAuthenticated',
      serializers.serialize(object.isAuthenticated,
          specifiedType: const FullType(bool)),
      'settingState',
      serializers.serialize(object.settingState,
          specifiedType: const FullType(SettingState)),
    ];

    return result;
  }

  @override
  BasicAppState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BasicAppStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'currentAuthenticatedUserBasicInfo':
          result.currentAuthenticatedUserBasicInfo.replace(
              serializers.deserialize(value,
                      specifiedType: const FullType(BangumiUserSmall))
                  as BangumiUserSmall);
          break;
        case 'isAuthenticated':
          result.isAuthenticated = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'settingState':
          result.settingState.replace(serializers.deserialize(value,
              specifiedType: const FullType(SettingState)) as SettingState);
          break;
      }
    }

    return result.build();
  }
}

class _$BasicAppState extends BasicAppState {
  @override
  final BangumiUserSmall currentAuthenticatedUserBasicInfo;
  @override
  final bool isAuthenticated;
  @override
  final SettingState settingState;

  factory _$BasicAppState([void Function(BasicAppStateBuilder) updates]) =>
      (new BasicAppStateBuilder()..update(updates)).build();

  _$BasicAppState._(
      {this.currentAuthenticatedUserBasicInfo,
      this.isAuthenticated,
      this.settingState})
      : super._() {
    if (currentAuthenticatedUserBasicInfo == null) {
      throw new BuiltValueNullFieldError(
          'BasicAppState', 'currentAuthenticatedUserBasicInfo');
    }
    if (isAuthenticated == null) {
      throw new BuiltValueNullFieldError('BasicAppState', 'isAuthenticated');
    }
    if (settingState == null) {
      throw new BuiltValueNullFieldError('BasicAppState', 'settingState');
    }
  }

  @override
  BasicAppState rebuild(void Function(BasicAppStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BasicAppStateBuilder toBuilder() => new BasicAppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BasicAppState &&
        currentAuthenticatedUserBasicInfo ==
            other.currentAuthenticatedUserBasicInfo &&
        isAuthenticated == other.isAuthenticated &&
        settingState == other.settingState;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, currentAuthenticatedUserBasicInfo.hashCode),
            isAuthenticated.hashCode),
        settingState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BasicAppState')
          ..add('currentAuthenticatedUserBasicInfo',
              currentAuthenticatedUserBasicInfo)
          ..add('isAuthenticated', isAuthenticated)
          ..add('settingState', settingState))
        .toString();
  }
}

class BasicAppStateBuilder
    implements Builder<BasicAppState, BasicAppStateBuilder> {
  _$BasicAppState _$v;

  BangumiUserSmallBuilder _currentAuthenticatedUserBasicInfo;
  BangumiUserSmallBuilder get currentAuthenticatedUserBasicInfo =>
      _$this._currentAuthenticatedUserBasicInfo ??=
          new BangumiUserSmallBuilder();
  set currentAuthenticatedUserBasicInfo(
          BangumiUserSmallBuilder currentAuthenticatedUserBasicInfo) =>
      _$this._currentAuthenticatedUserBasicInfo =
          currentAuthenticatedUserBasicInfo;

  bool _isAuthenticated;
  bool get isAuthenticated => _$this._isAuthenticated;
  set isAuthenticated(bool isAuthenticated) =>
      _$this._isAuthenticated = isAuthenticated;

  SettingStateBuilder _settingState;
  SettingStateBuilder get settingState =>
      _$this._settingState ??= new SettingStateBuilder();
  set settingState(SettingStateBuilder settingState) =>
      _$this._settingState = settingState;

  BasicAppStateBuilder();

  BasicAppStateBuilder get _$this {
    if (_$v != null) {
      _currentAuthenticatedUserBasicInfo =
          _$v.currentAuthenticatedUserBasicInfo?.toBuilder();
      _isAuthenticated = _$v.isAuthenticated;
      _settingState = _$v.settingState?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BasicAppState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BasicAppState;
  }

  @override
  void update(void Function(BasicAppStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BasicAppState build() {
    _$BasicAppState _$result;
    try {
      _$result = _$v ??
          new _$BasicAppState._(
              currentAuthenticatedUserBasicInfo:
                  currentAuthenticatedUserBasicInfo.build(),
              isAuthenticated: isAuthenticated,
              settingState: settingState.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'currentAuthenticatedUserBasicInfo';
        currentAuthenticatedUserBasicInfo.build();

        _$failedField = 'settingState';
        settingState.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'BasicAppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
