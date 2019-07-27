// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MutedUser.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<MutedUser> _$mutedUserSerializer = new _$MutedUserSerializer();

class _$MutedUserSerializer implements StructuredSerializer<MutedUser> {
  @override
  final Iterable<Type> types = const [MutedUser, _$MutedUser];
  @override
  final String wireName = 'MutedUser';

  @override
  Iterable<Object> serialize(Serializers serializers, MutedUser object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
      'nickname',
      serializers.serialize(object.nickname,
          specifiedType: const FullType(String)),
      'isImportedFromBangumi',
      serializers.serialize(object.isImportedFromBangumi,
          specifiedType: const FullType(bool)),
    ];
    if (object.userId != null) {
      result
        ..add('userId')
        ..add(serializers.serialize(object.userId,
            specifiedType: const FullType(int)));
    }
    if (object.userAvatar != null) {
      result
        ..add('userAvatar')
        ..add(serializers.serialize(object.userAvatar,
            specifiedType: const FullType(BangumiImage)));
    }
    return result;
  }

  @override
  MutedUser deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MutedUserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'nickname':
          result.nickname = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'userAvatar':
          result.userAvatar.replace(serializers.deserialize(value,
              specifiedType: const FullType(BangumiImage)) as BangumiImage);
          break;
        case 'isImportedFromBangumi':
          result.isImportedFromBangumi = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$MutedUser extends MutedUser {
  @override
  final String username;
  @override
  final int userId;
  @override
  final String nickname;
  @override
  final BangumiImage userAvatar;
  @override
  final bool isImportedFromBangumi;

  factory _$MutedUser([void Function(MutedUserBuilder) updates]) =>
      (new MutedUserBuilder()..update(updates)).build();

  _$MutedUser._(
      {this.username,
      this.userId,
      this.nickname,
      this.userAvatar,
      this.isImportedFromBangumi})
      : super._() {
    if (username == null) {
      throw new BuiltValueNullFieldError('MutedUser', 'username');
    }
    if (nickname == null) {
      throw new BuiltValueNullFieldError('MutedUser', 'nickname');
    }
    if (isImportedFromBangumi == null) {
      throw new BuiltValueNullFieldError('MutedUser', 'isImportedFromBangumi');
    }
  }

  @override
  MutedUser rebuild(void Function(MutedUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MutedUserBuilder toBuilder() => new MutedUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MutedUser &&
        username == other.username &&
        userId == other.userId &&
        nickname == other.nickname &&
        userAvatar == other.userAvatar &&
        isImportedFromBangumi == other.isImportedFromBangumi;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, username.hashCode), userId.hashCode),
                nickname.hashCode),
            userAvatar.hashCode),
        isImportedFromBangumi.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MutedUser')
          ..add('username', username)
          ..add('userId', userId)
          ..add('nickname', nickname)
          ..add('userAvatar', userAvatar)
          ..add('isImportedFromBangumi', isImportedFromBangumi))
        .toString();
  }
}

class MutedUserBuilder implements Builder<MutedUser, MutedUserBuilder> {
  _$MutedUser _$v;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  int _userId;
  int get userId => _$this._userId;
  set userId(int userId) => _$this._userId = userId;

  String _nickname;
  String get nickname => _$this._nickname;
  set nickname(String nickname) => _$this._nickname = nickname;

  BangumiImageBuilder _userAvatar;
  BangumiImageBuilder get userAvatar =>
      _$this._userAvatar ??= new BangumiImageBuilder();
  set userAvatar(BangumiImageBuilder userAvatar) =>
      _$this._userAvatar = userAvatar;

  bool _isImportedFromBangumi;
  bool get isImportedFromBangumi => _$this._isImportedFromBangumi;
  set isImportedFromBangumi(bool isImportedFromBangumi) =>
      _$this._isImportedFromBangumi = isImportedFromBangumi;

  MutedUserBuilder();

  MutedUserBuilder get _$this {
    if (_$v != null) {
      _username = _$v.username;
      _userId = _$v.userId;
      _nickname = _$v.nickname;
      _userAvatar = _$v.userAvatar?.toBuilder();
      _isImportedFromBangumi = _$v.isImportedFromBangumi;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MutedUser other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MutedUser;
  }

  @override
  void update(void Function(MutedUserBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$MutedUser build() {
    _$MutedUser _$result;
    try {
      _$result = _$v ??
          new _$MutedUser._(
              username: username,
              userId: userId,
              nickname: nickname,
              userAvatar: _userAvatar?.build(),
              isImportedFromBangumi: isImportedFromBangumi);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'userAvatar';
        _userAvatar?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'MutedUser', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
