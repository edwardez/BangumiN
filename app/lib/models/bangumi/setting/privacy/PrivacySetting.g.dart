// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PrivacySetting.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PrivacySetting> _$privacySettingSerializer =
    new _$PrivacySettingSerializer();

class _$PrivacySettingSerializer
    implements StructuredSerializer<PrivacySetting> {
  @override
  final Iterable<Type> types = const [PrivacySetting, _$PrivacySetting];
  @override
  final String wireName = 'PrivacySetting';

  @override
  Iterable<Object> serialize(Serializers serializers, PrivacySetting object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'optInAnalytics',
      serializers.serialize(object.optInAnalytics,
          specifiedType: const FullType(bool)),
      'optInAutoSendCrashReport',
      serializers.serialize(object.optInAutoSendCrashReport,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  PrivacySetting deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PrivacySettingBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'optInAnalytics':
          result.optInAnalytics = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'optInAutoSendCrashReport':
          result.optInAutoSendCrashReport = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$PrivacySetting extends PrivacySetting {
  @override
  final bool optInAnalytics;
  @override
  final bool optInAutoSendCrashReport;

  factory _$PrivacySetting([void Function(PrivacySettingBuilder) updates]) =>
      (new PrivacySettingBuilder()..update(updates)).build();

  _$PrivacySetting._({this.optInAnalytics, this.optInAutoSendCrashReport})
      : super._() {
    if (optInAnalytics == null) {
      throw new BuiltValueNullFieldError('PrivacySetting', 'optInAnalytics');
    }
    if (optInAutoSendCrashReport == null) {
      throw new BuiltValueNullFieldError(
          'PrivacySetting', 'optInAutoSendCrashReport');
    }
  }

  @override
  PrivacySetting rebuild(void Function(PrivacySettingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PrivacySettingBuilder toBuilder() =>
      new PrivacySettingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrivacySetting &&
        optInAnalytics == other.optInAnalytics &&
        optInAutoSendCrashReport == other.optInAutoSendCrashReport;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(0, optInAnalytics.hashCode), optInAutoSendCrashReport.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PrivacySetting')
          ..add('optInAnalytics', optInAnalytics)
          ..add('optInAutoSendCrashReport', optInAutoSendCrashReport))
        .toString();
  }
}

class PrivacySettingBuilder
    implements Builder<PrivacySetting, PrivacySettingBuilder> {
  _$PrivacySetting _$v;

  bool _optInAnalytics;
  bool get optInAnalytics => _$this._optInAnalytics;
  set optInAnalytics(bool optInAnalytics) =>
      _$this._optInAnalytics = optInAnalytics;

  bool _optInAutoSendCrashReport;
  bool get optInAutoSendCrashReport => _$this._optInAutoSendCrashReport;
  set optInAutoSendCrashReport(bool optInAutoSendCrashReport) =>
      _$this._optInAutoSendCrashReport = optInAutoSendCrashReport;

  PrivacySettingBuilder();

  PrivacySettingBuilder get _$this {
    if (_$v != null) {
      _optInAnalytics = _$v.optInAnalytics;
      _optInAutoSendCrashReport = _$v.optInAutoSendCrashReport;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrivacySetting other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PrivacySetting;
  }

  @override
  void update(void Function(PrivacySettingBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PrivacySetting build() {
    final _$result = _$v ??
        new _$PrivacySetting._(
            optInAnalytics: optInAnalytics,
            optInAutoSendCrashReport: optInAutoSendCrashReport);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
