// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BrowserSetting.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BrowserSetting> _$browserSettingSerializer =
    new _$BrowserSettingSerializer();

class _$BrowserSettingSerializer
    implements StructuredSerializer<BrowserSetting> {
  @override
  final Iterable<Type> types = const [BrowserSetting, _$BrowserSetting];
  @override
  final String wireName = 'BrowserSetting';

  @override
  Iterable<Object> serialize(Serializers serializers, BrowserSetting object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'launchBrowserPreference',
      serializers.serialize(object.launchBrowserPreference,
          specifiedType: const FullType(LaunchBrowserPreference)),
    ];

    return result;
  }

  @override
  BrowserSetting deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BrowserSettingBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'launchBrowserPreference':
          result.launchBrowserPreference = serializers.deserialize(value,
                  specifiedType: const FullType(LaunchBrowserPreference))
              as LaunchBrowserPreference;
          break;
      }
    }

    return result.build();
  }
}

class _$BrowserSetting extends BrowserSetting {
  @override
  final LaunchBrowserPreference launchBrowserPreference;

  factory _$BrowserSetting([void Function(BrowserSettingBuilder) updates]) =>
      (new BrowserSettingBuilder()..update(updates)).build();

  _$BrowserSetting._({this.launchBrowserPreference}) : super._() {
    if (launchBrowserPreference == null) {
      throw new BuiltValueNullFieldError(
          'BrowserSetting', 'launchBrowserPreference');
    }
  }

  @override
  BrowserSetting rebuild(void Function(BrowserSettingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BrowserSettingBuilder toBuilder() =>
      new BrowserSettingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BrowserSetting &&
        launchBrowserPreference == other.launchBrowserPreference;
  }

  @override
  int get hashCode {
    return $jf($jc(0, launchBrowserPreference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BrowserSetting')
          ..add('launchBrowserPreference', launchBrowserPreference))
        .toString();
  }
}

class BrowserSettingBuilder
    implements Builder<BrowserSetting, BrowserSettingBuilder> {
  _$BrowserSetting _$v;

  LaunchBrowserPreference _launchBrowserPreference;
  LaunchBrowserPreference get launchBrowserPreference =>
      _$this._launchBrowserPreference;
  set launchBrowserPreference(
          LaunchBrowserPreference launchBrowserPreference) =>
      _$this._launchBrowserPreference = launchBrowserPreference;

  BrowserSettingBuilder();

  BrowserSettingBuilder get _$this {
    if (_$v != null) {
      _launchBrowserPreference = _$v.launchBrowserPreference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BrowserSetting other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BrowserSetting;
  }

  @override
  void update(void Function(BrowserSettingBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BrowserSetting build() {
    final _$result = _$v ??
        new _$BrowserSetting._(
            launchBrowserPreference: launchBrowserPreference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
