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
      'collections',
      serializers.serialize(object.collections,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(ListUserCollectionsRequest),
            const FullType(ListUserCollectionsResponse)
          ])),
      'notificationState',
      serializers.serialize(object.notificationState,
          specifiedType: const FullType(NotificationState)),
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
        case 'collections':
          result.collections.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(ListUserCollectionsRequest),
                const FullType(ListUserCollectionsResponse)
              ])) as BuiltMap);
          break;
        case 'notificationState':
          result.notificationState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(NotificationState))
              as NotificationState);
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
  final BuiltMap<ListUserCollectionsRequest, ListUserCollectionsResponse>
      collections;
  @override
  final NotificationState notificationState;

  factory _$UserState([void Function(UserStateBuilder) updates]) =>
      (new UserStateBuilder()..update(updates)).build();

  _$UserState._({this.profiles, this.collections, this.notificationState})
      : super._() {
    if (profiles == null) {
      throw new BuiltValueNullFieldError('UserState', 'profiles');
    }
    if (collections == null) {
      throw new BuiltValueNullFieldError('UserState', 'collections');
    }
    if (notificationState == null) {
      throw new BuiltValueNullFieldError('UserState', 'notificationState');
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
        collections == other.collections &&
        notificationState == other.notificationState;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, profiles.hashCode), collections.hashCode),
        notificationState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserState')
          ..add('profiles', profiles)
          ..add('collections', collections)
          ..add('notificationState', notificationState))
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

  MapBuilder<ListUserCollectionsRequest, ListUserCollectionsResponse>
      _collections;
  MapBuilder<ListUserCollectionsRequest,
      ListUserCollectionsResponse> get collections => _$this
          ._collections ??=
      new MapBuilder<ListUserCollectionsRequest, ListUserCollectionsResponse>();
  set collections(
          MapBuilder<ListUserCollectionsRequest, ListUserCollectionsResponse>
              collections) =>
      _$this._collections = collections;

  NotificationStateBuilder _notificationState;
  NotificationStateBuilder get notificationState =>
      _$this._notificationState ??= new NotificationStateBuilder();
  set notificationState(NotificationStateBuilder notificationState) =>
      _$this._notificationState = notificationState;

  UserStateBuilder();

  UserStateBuilder get _$this {
    if (_$v != null) {
      _profiles = _$v.profiles?.toBuilder();
      _collections = _$v.collections?.toBuilder();
      _notificationState = _$v.notificationState?.toBuilder();
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
              collections: collections.build(),
              notificationState: notificationState.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'profiles';
        profiles.build();
        _$failedField = 'collections';
        collections.build();
        _$failedField = 'notificationState';
        notificationState.build();
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
