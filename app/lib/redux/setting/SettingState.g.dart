// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SettingState.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SettingState> _$settingStateSerializer =
    new _$SettingStateSerializer();

class _$SettingStateSerializer implements StructuredSerializer<SettingState> {
  @override
  final Iterable<Type> types = const [SettingState, _$SettingState];
  @override
  final String wireName = 'SettingState';

  @override
  Iterable serialize(Serializers serializers, SettingState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'themeSetting',
      serializers.serialize(object.themeSetting,
          specifiedType: const FullType(ThemeSetting)),
      'muteSetting',
      serializers.serialize(object.muteSetting,
          specifiedType: const FullType(MuteSetting)),
    ];

    return result;
  }

  @override
  SettingState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SettingStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'themeSetting':
          result.themeSetting.replace(serializers.deserialize(value,
              specifiedType: const FullType(ThemeSetting)) as ThemeSetting);
          break;
        case 'muteSetting':
          result.muteSetting.replace(serializers.deserialize(value,
              specifiedType: const FullType(MuteSetting)) as MuteSetting);
          break;
      }
    }

    return result.build();
  }
}

class _$SettingState extends SettingState {
  @override
  final ThemeSetting themeSetting;
  @override
  final MuteSetting muteSetting;

  factory _$SettingState([void Function(SettingStateBuilder) updates]) =>
      (new SettingStateBuilder()..update(updates)).build();

  _$SettingState._({this.themeSetting, this.muteSetting}) : super._() {
    if (themeSetting == null) {
      throw new BuiltValueNullFieldError('SettingState', 'themeSetting');
    }
    if (muteSetting == null) {
      throw new BuiltValueNullFieldError('SettingState', 'muteSetting');
    }
  }

  @override
  SettingState rebuild(void Function(SettingStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SettingStateBuilder toBuilder() => new SettingStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SettingState &&
        themeSetting == other.themeSetting &&
        muteSetting == other.muteSetting;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, themeSetting.hashCode), muteSetting.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SettingState')
          ..add('themeSetting', themeSetting)
          ..add('muteSetting', muteSetting))
        .toString();
  }
}

class SettingStateBuilder
    implements Builder<SettingState, SettingStateBuilder> {
  _$SettingState _$v;

  ThemeSettingBuilder _themeSetting;
  ThemeSettingBuilder get themeSetting =>
      _$this._themeSetting ??= new ThemeSettingBuilder();
  set themeSetting(ThemeSettingBuilder themeSetting) =>
      _$this._themeSetting = themeSetting;

  MuteSettingBuilder _muteSetting;
  MuteSettingBuilder get muteSetting =>
      _$this._muteSetting ??= new MuteSettingBuilder();
  set muteSetting(MuteSettingBuilder muteSetting) =>
      _$this._muteSetting = muteSetting;

  SettingStateBuilder();

  SettingStateBuilder get _$this {
    if (_$v != null) {
      _themeSetting = _$v.themeSetting?.toBuilder();
      _muteSetting = _$v.muteSetting?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SettingState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SettingState;
  }

  @override
  void update(void Function(SettingStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SettingState build() {
    _$SettingState _$result;
    try {
      _$result = _$v ??
          new _$SettingState._(
              themeSetting: themeSetting.build(),
              muteSetting: muteSetting.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'themeSetting';
        themeSetting.build();
        _$failedField = 'muteSetting';
        muteSetting.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SettingState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
