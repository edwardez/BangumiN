// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ThemeSetting.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ThemeSetting> _$themeSettingSerializer =
    new _$ThemeSettingSerializer();

class _$ThemeSettingSerializer implements StructuredSerializer<ThemeSetting> {
  @override
  final Iterable<Type> types = const [ThemeSetting, _$ThemeSetting];
  @override
  final String wireName = 'ThemeSetting';

  @override
  Iterable serialize(Serializers serializers, ThemeSetting object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'currentTheme',
      serializers.serialize(object.currentTheme,
          specifiedType: const FullType(MuninTheme)),
      'preferredFollowBrightnessSwitchThreshold',
      serializers.serialize(object.preferredFollowBrightnessSwitchThreshold,
          specifiedType: const FullType(int)),
      'preferredFollowBrightnessLightTheme',
      serializers.serialize(object.preferredFollowBrightnessLightTheme,
          specifiedType: const FullType(MuninTheme)),
      'preferredFollowBrightnessDarkTheme',
      serializers.serialize(object.preferredFollowBrightnessDarkTheme,
          specifiedType: const FullType(MuninTheme)),
      'themeSwitchMode',
      serializers.serialize(object.themeSwitchMode,
          specifiedType: const FullType(ThemeSwitchMode)),
    ];

    return result;
  }

  @override
  ThemeSetting deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ThemeSettingBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'currentTheme':
          result.currentTheme = serializers.deserialize(value,
              specifiedType: const FullType(MuninTheme)) as MuninTheme;
          break;
        case 'preferredFollowBrightnessSwitchThreshold':
          result.preferredFollowBrightnessSwitchThreshold = serializers
              .deserialize(value, specifiedType: const FullType(int)) as int;
          break;
        case 'preferredFollowBrightnessLightTheme':
          result.preferredFollowBrightnessLightTheme = serializers.deserialize(
              value,
              specifiedType: const FullType(MuninTheme)) as MuninTheme;
          break;
        case 'preferredFollowBrightnessDarkTheme':
          result.preferredFollowBrightnessDarkTheme = serializers.deserialize(
              value,
              specifiedType: const FullType(MuninTheme)) as MuninTheme;
          break;
        case 'themeSwitchMode':
          result.themeSwitchMode = serializers.deserialize(value,
                  specifiedType: const FullType(ThemeSwitchMode))
              as ThemeSwitchMode;
          break;
      }
    }

    return result.build();
  }
}

class _$ThemeSetting extends ThemeSetting {
  @override
  final MuninTheme currentTheme;
  @override
  final int preferredFollowBrightnessSwitchThreshold;
  @override
  final MuninTheme preferredFollowBrightnessLightTheme;
  @override
  final MuninTheme preferredFollowBrightnessDarkTheme;
  @override
  final ThemeSwitchMode themeSwitchMode;

  factory _$ThemeSetting([void Function(ThemeSettingBuilder) updates]) =>
      (new ThemeSettingBuilder()..update(updates)).build();

  _$ThemeSetting._(
      {this.currentTheme,
      this.preferredFollowBrightnessSwitchThreshold,
      this.preferredFollowBrightnessLightTheme,
      this.preferredFollowBrightnessDarkTheme,
      this.themeSwitchMode})
      : super._() {
    if (currentTheme == null) {
      throw new BuiltValueNullFieldError('ThemeSetting', 'currentTheme');
    }
    if (preferredFollowBrightnessSwitchThreshold == null) {
      throw new BuiltValueNullFieldError(
          'ThemeSetting', 'preferredFollowBrightnessSwitchThreshold');
    }
    if (preferredFollowBrightnessLightTheme == null) {
      throw new BuiltValueNullFieldError(
          'ThemeSetting', 'preferredFollowBrightnessLightTheme');
    }
    if (preferredFollowBrightnessDarkTheme == null) {
      throw new BuiltValueNullFieldError(
          'ThemeSetting', 'preferredFollowBrightnessDarkTheme');
    }
    if (themeSwitchMode == null) {
      throw new BuiltValueNullFieldError('ThemeSetting', 'themeSwitchMode');
    }
  }

  @override
  ThemeSetting rebuild(void Function(ThemeSettingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ThemeSettingBuilder toBuilder() => new ThemeSettingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ThemeSetting &&
        currentTheme == other.currentTheme &&
        preferredFollowBrightnessSwitchThreshold ==
            other.preferredFollowBrightnessSwitchThreshold &&
        preferredFollowBrightnessLightTheme ==
            other.preferredFollowBrightnessLightTheme &&
        preferredFollowBrightnessDarkTheme ==
            other.preferredFollowBrightnessDarkTheme &&
        themeSwitchMode == other.themeSwitchMode;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc(0, currentTheme.hashCode),
                    preferredFollowBrightnessSwitchThreshold.hashCode),
                preferredFollowBrightnessLightTheme.hashCode),
            preferredFollowBrightnessDarkTheme.hashCode),
        themeSwitchMode.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ThemeSetting')
          ..add('currentTheme', currentTheme)
          ..add('preferredFollowBrightnessSwitchThreshold',
              preferredFollowBrightnessSwitchThreshold)
          ..add('preferredFollowBrightnessLightTheme',
              preferredFollowBrightnessLightTheme)
          ..add('preferredFollowBrightnessDarkTheme',
              preferredFollowBrightnessDarkTheme)
          ..add('themeSwitchMode', themeSwitchMode))
        .toString();
  }
}

class ThemeSettingBuilder
    implements Builder<ThemeSetting, ThemeSettingBuilder> {
  _$ThemeSetting _$v;

  MuninTheme _currentTheme;
  MuninTheme get currentTheme => _$this._currentTheme;
  set currentTheme(MuninTheme currentTheme) =>
      _$this._currentTheme = currentTheme;

  int _preferredFollowBrightnessSwitchThreshold;
  int get preferredFollowBrightnessSwitchThreshold =>
      _$this._preferredFollowBrightnessSwitchThreshold;
  set preferredFollowBrightnessSwitchThreshold(
          int preferredFollowBrightnessSwitchThreshold) =>
      _$this._preferredFollowBrightnessSwitchThreshold =
          preferredFollowBrightnessSwitchThreshold;

  MuninTheme _preferredFollowBrightnessLightTheme;
  MuninTheme get preferredFollowBrightnessLightTheme =>
      _$this._preferredFollowBrightnessLightTheme;
  set preferredFollowBrightnessLightTheme(
          MuninTheme preferredFollowBrightnessLightTheme) =>
      _$this._preferredFollowBrightnessLightTheme =
          preferredFollowBrightnessLightTheme;

  MuninTheme _preferredFollowBrightnessDarkTheme;
  MuninTheme get preferredFollowBrightnessDarkTheme =>
      _$this._preferredFollowBrightnessDarkTheme;
  set preferredFollowBrightnessDarkTheme(
          MuninTheme preferredFollowBrightnessDarkTheme) =>
      _$this._preferredFollowBrightnessDarkTheme =
          preferredFollowBrightnessDarkTheme;

  ThemeSwitchMode _themeSwitchMode;
  ThemeSwitchMode get themeSwitchMode => _$this._themeSwitchMode;
  set themeSwitchMode(ThemeSwitchMode themeSwitchMode) =>
      _$this._themeSwitchMode = themeSwitchMode;

  ThemeSettingBuilder();

  ThemeSettingBuilder get _$this {
    if (_$v != null) {
      _currentTheme = _$v.currentTheme;
      _preferredFollowBrightnessSwitchThreshold =
          _$v.preferredFollowBrightnessSwitchThreshold;
      _preferredFollowBrightnessLightTheme =
          _$v.preferredFollowBrightnessLightTheme;
      _preferredFollowBrightnessDarkTheme =
          _$v.preferredFollowBrightnessDarkTheme;
      _themeSwitchMode = _$v.themeSwitchMode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ThemeSetting other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ThemeSetting;
  }

  @override
  void update(void Function(ThemeSettingBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ThemeSetting build() {
    final _$result = _$v ??
        new _$ThemeSetting._(
            currentTheme: currentTheme,
            preferredFollowBrightnessSwitchThreshold:
                preferredFollowBrightnessSwitchThreshold,
            preferredFollowBrightnessLightTheme:
                preferredFollowBrightnessLightTheme,
            preferredFollowBrightnessDarkTheme:
                preferredFollowBrightnessDarkTheme,
            themeSwitchMode: themeSwitchMode);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
