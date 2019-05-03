// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserState.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserState> _$userStateSerializer = new _$UserStateSerializer();

class _$UserStateSerializer implements StructuredSerializer<UserState> {
  @override
  final Iterable<Type> types = const [UserState, _$UserState];
  @override
  final String wireName = 'UserState';

  @override
  Iterable serialize(Serializers serializers, UserState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'profiles',
      serializers.serialize(object.profiles,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(UserProfile)])),
      'profilesLoadingStatus',
      serializers.serialize(object.profilesLoadingStatus,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(LoadingStatus)])),
    ];

    return result;
  }

  @override
  UserState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'profiles':
          result.profiles.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(UserProfile)
              ])) as BuiltMap);
          break;
        case 'profilesLoadingStatus':
          result.profilesLoadingStatus.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(LoadingStatus)
              ])) as BuiltMap);
          break;
      }
    }

    return result.build();
  }
}

class _$UserState extends UserState {
  @override
  final BuiltMap<String, UserProfile> profiles;
  @override
  final BuiltMap<String, LoadingStatus> profilesLoadingStatus;

  factory _$UserState([void Function(UserStateBuilder) updates]) =>
      (new UserStateBuilder()..update(updates)).build();

  _$UserState._({this.profiles, this.profilesLoadingStatus}) : super._() {
    if (profiles == null) {
      throw new BuiltValueNullFieldError('UserState', 'profiles');
    }
    if (profilesLoadingStatus == null) {
      throw new BuiltValueNullFieldError('UserState', 'profilesLoadingStatus');
    }
  }

  @override
  UserState rebuild(void Function(UserStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserStateBuilder toBuilder() => new UserStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserState &&
        profiles == other.profiles &&
        profilesLoadingStatus == other.profilesLoadingStatus;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, profiles.hashCode), profilesLoadingStatus.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserState')
          ..add('profiles', profiles)
          ..add('profilesLoadingStatus', profilesLoadingStatus))
        .toString();
  }
}

class UserStateBuilder implements Builder<UserState, UserStateBuilder> {
  _$UserState _$v;

  MapBuilder<String, UserProfile> _profiles;
  MapBuilder<String, UserProfile> get profiles =>
      _$this._profiles ??= new MapBuilder<String, UserProfile>();
  set profiles(MapBuilder<String, UserProfile> profiles) =>
      _$this._profiles = profiles;

  MapBuilder<String, LoadingStatus> _profilesLoadingStatus;
  MapBuilder<String, LoadingStatus> get profilesLoadingStatus =>
      _$this._profilesLoadingStatus ??= new MapBuilder<String, LoadingStatus>();
  set profilesLoadingStatus(
          MapBuilder<String, LoadingStatus> profilesLoadingStatus) =>
      _$this._profilesLoadingStatus = profilesLoadingStatus;

  UserStateBuilder();

  UserStateBuilder get _$this {
    if (_$v != null) {
      _profiles = _$v.profiles?.toBuilder();
      _profilesLoadingStatus = _$v.profilesLoadingStatus?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserState;
  }

  @override
  void update(void Function(UserStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserState build() {
    _$UserState _$result;
    try {
      _$result = _$v ??
          new _$UserState._(
              profiles: profiles.build(),
              profilesLoadingStatus: profilesLoadingStatus.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'profiles';
        profiles.build();
        _$failedField = 'profilesLoadingStatus';
        profilesLoadingStatus.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
