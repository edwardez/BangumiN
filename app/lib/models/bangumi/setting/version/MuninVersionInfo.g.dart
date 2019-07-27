// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MuninVersionInfo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<MuninVersionInfo> _$muninVersionInfoSerializer =
    new _$MuninVersionInfoSerializer();

class _$MuninVersionInfoSerializer
    implements StructuredSerializer<MuninVersionInfo> {
  @override
  final Iterable<Type> types = const [MuninVersionInfo, _$MuninVersionInfo];
  @override
  final String wireName = 'MuninVersionInfo';

  @override
  Iterable<Object> serialize(Serializers serializers, MuninVersionInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'latestVersion',
      serializers.serialize(object.latestVersion,
          specifiedType: const FullType(String)),
      'hasCriticalUpdate',
      serializers.serialize(object.hasCriticalUpdate,
          specifiedType: const FullType(bool)),
      'downloadPageUrl',
      serializers.serialize(object.downloadPageUrl,
          specifiedType: const FullType(String)),
    ];
    if (object.mutedUpdateVersion != null) {
      result
        ..add('mutedUpdateVersion')
        ..add(serializers.serialize(object.mutedUpdateVersion,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  MuninVersionInfo deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MuninVersionInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'latestVersion':
          result.latestVersion = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'hasCriticalUpdate':
          result.hasCriticalUpdate = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'downloadPageUrl':
          result.downloadPageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'mutedUpdateVersion':
          result.mutedUpdateVersion = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$MuninVersionInfo extends MuninVersionInfo {
  @override
  final String latestVersion;
  @override
  final bool hasCriticalUpdate;
  @override
  final String downloadPageUrl;
  @override
  final String mutedUpdateVersion;

  factory _$MuninVersionInfo(
          [void Function(MuninVersionInfoBuilder) updates]) =>
      (new MuninVersionInfoBuilder()..update(updates)).build();

  _$MuninVersionInfo._(
      {this.latestVersion,
      this.hasCriticalUpdate,
      this.downloadPageUrl,
      this.mutedUpdateVersion})
      : super._() {
    if (latestVersion == null) {
      throw new BuiltValueNullFieldError('MuninVersionInfo', 'latestVersion');
    }
    if (hasCriticalUpdate == null) {
      throw new BuiltValueNullFieldError(
          'MuninVersionInfo', 'hasCriticalUpdate');
    }
    if (downloadPageUrl == null) {
      throw new BuiltValueNullFieldError('MuninVersionInfo', 'downloadPageUrl');
    }
  }

  @override
  MuninVersionInfo rebuild(void Function(MuninVersionInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MuninVersionInfoBuilder toBuilder() =>
      new MuninVersionInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MuninVersionInfo &&
        latestVersion == other.latestVersion &&
        hasCriticalUpdate == other.hasCriticalUpdate &&
        downloadPageUrl == other.downloadPageUrl &&
        mutedUpdateVersion == other.mutedUpdateVersion;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, latestVersion.hashCode), hasCriticalUpdate.hashCode),
            downloadPageUrl.hashCode),
        mutedUpdateVersion.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MuninVersionInfo')
          ..add('latestVersion', latestVersion)
          ..add('hasCriticalUpdate', hasCriticalUpdate)
          ..add('downloadPageUrl', downloadPageUrl)
          ..add('mutedUpdateVersion', mutedUpdateVersion))
        .toString();
  }
}

class MuninVersionInfoBuilder
    implements Builder<MuninVersionInfo, MuninVersionInfoBuilder> {
  _$MuninVersionInfo _$v;

  String _latestVersion;
  String get latestVersion => _$this._latestVersion;
  set latestVersion(String latestVersion) =>
      _$this._latestVersion = latestVersion;

  bool _hasCriticalUpdate;
  bool get hasCriticalUpdate => _$this._hasCriticalUpdate;
  set hasCriticalUpdate(bool hasCriticalUpdate) =>
      _$this._hasCriticalUpdate = hasCriticalUpdate;

  String _downloadPageUrl;
  String get downloadPageUrl => _$this._downloadPageUrl;
  set downloadPageUrl(String downloadPageUrl) =>
      _$this._downloadPageUrl = downloadPageUrl;

  String _mutedUpdateVersion;
  String get mutedUpdateVersion => _$this._mutedUpdateVersion;
  set mutedUpdateVersion(String mutedUpdateVersion) =>
      _$this._mutedUpdateVersion = mutedUpdateVersion;

  MuninVersionInfoBuilder();

  MuninVersionInfoBuilder get _$this {
    if (_$v != null) {
      _latestVersion = _$v.latestVersion;
      _hasCriticalUpdate = _$v.hasCriticalUpdate;
      _downloadPageUrl = _$v.downloadPageUrl;
      _mutedUpdateVersion = _$v.mutedUpdateVersion;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MuninVersionInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MuninVersionInfo;
  }

  @override
  void update(void Function(MuninVersionInfoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$MuninVersionInfo build() {
    final _$result = _$v ??
        new _$MuninVersionInfo._(
            latestVersion: latestVersion,
            hasCriticalUpdate: hasCriticalUpdate,
            downloadPageUrl: downloadPageUrl,
            mutedUpdateVersion: mutedUpdateVersion);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
