// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MuteSetting.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<MuteSetting> _$muteSettingSerializer = new _$MuteSettingSerializer();

class _$MuteSettingSerializer implements StructuredSerializer<MuteSetting> {
  @override
  final Iterable<Type> types = const [MuteSetting, _$MuteSetting];
  @override
  final String wireName = 'MuteSetting';

  @override
  Iterable<Object> serialize(Serializers serializers, MuteSetting object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'mutedUsers',
      serializers.serialize(object.mutedUsers,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(MutedUser)])),
      'mutedGroups',
      serializers.serialize(object.mutedGroups,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(MutedGroup)])),
      'muteOriginalPosterWithDefaultIcon',
      serializers.serialize(object.muteOriginalPosterWithDefaultIcon,
          specifiedType: const FullType(bool)),
    ];
    if (object.importedBangumiBlockedUsers != null) {
      result
        ..add('importedBangumiBlockedUsers')
        ..add(serializers.serialize(object.importedBangumiBlockedUsers,
            specifiedType: const FullType(BuiltMap,
                const [const FullType(String), const FullType(MutedUser)])));
    }
    return result;
  }

  @override
  MuteSetting deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MuteSettingBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'mutedUsers':
          result.mutedUsers.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(MutedUser)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
        case 'mutedGroups':
          result.mutedGroups.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(MutedGroup)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
        case 'muteOriginalPosterWithDefaultIcon':
          result.muteOriginalPosterWithDefaultIcon = serializers
              .deserialize(value, specifiedType: const FullType(bool)) as bool;
          break;
        case 'importedBangumiBlockedUsers':
          result.importedBangumiBlockedUsers.replace(serializers.deserialize(
              value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(MutedUser)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$MuteSetting extends MuteSetting {
  @override
  final BuiltMap<String, MutedUser> mutedUsers;
  @override
  final BuiltMap<String, MutedGroup> mutedGroups;
  @override
  final bool muteOriginalPosterWithDefaultIcon;
  @override
  final BuiltMap<String, MutedUser> importedBangumiBlockedUsers;

  factory _$MuteSetting([void Function(MuteSettingBuilder) updates]) =>
      (new MuteSettingBuilder()..update(updates)).build();

  _$MuteSetting._(
      {this.mutedUsers,
      this.mutedGroups,
      this.muteOriginalPosterWithDefaultIcon,
      this.importedBangumiBlockedUsers})
      : super._() {
    if (mutedUsers == null) {
      throw new BuiltValueNullFieldError('MuteSetting', 'mutedUsers');
    }
    if (mutedGroups == null) {
      throw new BuiltValueNullFieldError('MuteSetting', 'mutedGroups');
    }
    if (muteOriginalPosterWithDefaultIcon == null) {
      throw new BuiltValueNullFieldError(
          'MuteSetting', 'muteOriginalPosterWithDefaultIcon');
    }
  }

  @override
  MuteSetting rebuild(void Function(MuteSettingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MuteSettingBuilder toBuilder() => new MuteSettingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MuteSetting &&
        mutedUsers == other.mutedUsers &&
        mutedGroups == other.mutedGroups &&
        muteOriginalPosterWithDefaultIcon ==
            other.muteOriginalPosterWithDefaultIcon &&
        importedBangumiBlockedUsers == other.importedBangumiBlockedUsers;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, mutedUsers.hashCode), mutedGroups.hashCode),
            muteOriginalPosterWithDefaultIcon.hashCode),
        importedBangumiBlockedUsers.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MuteSetting')
          ..add('mutedUsers', mutedUsers)
          ..add('mutedGroups', mutedGroups)
          ..add('muteOriginalPosterWithDefaultIcon',
              muteOriginalPosterWithDefaultIcon)
          ..add('importedBangumiBlockedUsers', importedBangumiBlockedUsers))
        .toString();
  }
}

class MuteSettingBuilder implements Builder<MuteSetting, MuteSettingBuilder> {
  _$MuteSetting _$v;

  MapBuilder<String, MutedUser> _mutedUsers;
  MapBuilder<String, MutedUser> get mutedUsers =>
      _$this._mutedUsers ??= new MapBuilder<String, MutedUser>();
  set mutedUsers(MapBuilder<String, MutedUser> mutedUsers) =>
      _$this._mutedUsers = mutedUsers;

  MapBuilder<String, MutedGroup> _mutedGroups;
  MapBuilder<String, MutedGroup> get mutedGroups =>
      _$this._mutedGroups ??= new MapBuilder<String, MutedGroup>();
  set mutedGroups(MapBuilder<String, MutedGroup> mutedGroups) =>
      _$this._mutedGroups = mutedGroups;

  bool _muteOriginalPosterWithDefaultIcon;
  bool get muteOriginalPosterWithDefaultIcon =>
      _$this._muteOriginalPosterWithDefaultIcon;
  set muteOriginalPosterWithDefaultIcon(
          bool muteOriginalPosterWithDefaultIcon) =>
      _$this._muteOriginalPosterWithDefaultIcon =
          muteOriginalPosterWithDefaultIcon;

  MapBuilder<String, MutedUser> _importedBangumiBlockedUsers;
  MapBuilder<String, MutedUser> get importedBangumiBlockedUsers =>
      _$this._importedBangumiBlockedUsers ??=
          new MapBuilder<String, MutedUser>();
  set importedBangumiBlockedUsers(
          MapBuilder<String, MutedUser> importedBangumiBlockedUsers) =>
      _$this._importedBangumiBlockedUsers = importedBangumiBlockedUsers;

  MuteSettingBuilder();

  MuteSettingBuilder get _$this {
    if (_$v != null) {
      _mutedUsers = _$v.mutedUsers?.toBuilder();
      _mutedGroups = _$v.mutedGroups?.toBuilder();
      _muteOriginalPosterWithDefaultIcon =
          _$v.muteOriginalPosterWithDefaultIcon;
      _importedBangumiBlockedUsers =
          _$v.importedBangumiBlockedUsers?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MuteSetting other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MuteSetting;
  }

  @override
  void update(void Function(MuteSettingBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$MuteSetting build() {
    _$MuteSetting _$result;
    try {
      _$result = _$v ??
          new _$MuteSetting._(
              mutedUsers: mutedUsers.build(),
              mutedGroups: mutedGroups.build(),
              muteOriginalPosterWithDefaultIcon:
                  muteOriginalPosterWithDefaultIcon,
              importedBangumiBlockedUsers:
                  _importedBangumiBlockedUsers?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'mutedUsers';
        mutedUsers.build();
        _$failedField = 'mutedGroups';
        mutedGroups.build();

        _$failedField = 'importedBangumiBlockedUsers';
        _importedBangumiBlockedUsers?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'MuteSetting', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
