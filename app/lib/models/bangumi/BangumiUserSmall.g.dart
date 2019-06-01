// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BangumiUserSmall.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BangumiUserSmall> _$bangumiUserSmallSerializer =
new _$BangumiUserSmallSerializer();

class _$BangumiUserSmallSerializer
    implements StructuredSerializer<BangumiUserSmall> {
  @override
  final Iterable<Type> types = const [BangumiUserSmall, _$BangumiUserSmall];
  @override
  final String wireName = 'BangumiUserSmall';

  @override
  Iterable serialize(Serializers serializers, BangumiUserSmall object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'url',
      serializers.serialize(object.url, specifiedType: const FullType(String)),
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
      'nickname',
      serializers.serialize(object.nickname,
          specifiedType: const FullType(String)),
      'avatar',
      serializers.serialize(object.avatar,
          specifiedType: const FullType(BangumiUserAvatar)),
      'sign',
      serializers.serialize(object.sign, specifiedType: const FullType(String)),
      'usergroup',
      serializers.serialize(object.userGroup,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  BangumiUserSmall deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BangumiUserSmallBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'url':
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'nickname':
          result.nickname = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'avatar':
          result.avatar.replace(serializers.deserialize(value,
                  specifiedType: const FullType(BangumiUserAvatar))
              as BangumiUserAvatar);
          break;
        case 'sign':
          result.sign = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'usergroup':
          result.userGroup = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$BangumiUserSmall extends BangumiUserSmall {
  @override
  final int id;
  @override
  final String url;
  @override
  final String username;
  @override
  final String nickname;
  @override
  final BangumiUserAvatar avatar;
  @override
  final String sign;
  @override
  final int userGroup;

  factory _$BangumiUserSmall(
      [void Function(BangumiUserSmallBuilder) updates]) =>
      (new BangumiUserSmallBuilder()
        ..update(updates)).build();

  _$BangumiUserSmall._(
      {this.id,
      this.url,
      this.username,
      this.nickname,
      this.avatar,
      this.sign,
      this.userGroup})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('BangumiUserSmall', 'id');
    }
    if (url == null) {
      throw new BuiltValueNullFieldError('BangumiUserSmall', 'url');
    }
    if (username == null) {
      throw new BuiltValueNullFieldError('BangumiUserSmall', 'username');
    }
    if (nickname == null) {
      throw new BuiltValueNullFieldError('BangumiUserSmall', 'nickname');
    }
    if (avatar == null) {
      throw new BuiltValueNullFieldError('BangumiUserSmall', 'avatar');
    }
    if (sign == null) {
      throw new BuiltValueNullFieldError('BangumiUserSmall', 'sign');
    }
    if (userGroup == null) {
      throw new BuiltValueNullFieldError('BangumiUserSmall', 'userGroup');
    }
  }

  @override
  BangumiUserSmall rebuild(void Function(BangumiUserSmallBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BangumiUserSmallBuilder toBuilder() =>
      new BangumiUserSmallBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BangumiUserSmall &&
        id == other.id &&
        url == other.url &&
        username == other.username &&
        nickname == other.nickname &&
        avatar == other.avatar &&
        sign == other.sign &&
        userGroup == other.userGroup;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, id.hashCode), url.hashCode),
                        username.hashCode),
                    nickname.hashCode),
                avatar.hashCode),
            sign.hashCode),
        userGroup.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BangumiUserSmall')
          ..add('id', id)
          ..add('url', url)
          ..add('username', username)
          ..add('nickname', nickname)
          ..add('avatar', avatar)
          ..add('sign', sign)
          ..add('userGroup', userGroup))
        .toString();
  }
}

class BangumiUserSmallBuilder
    implements Builder<BangumiUserSmall, BangumiUserSmallBuilder> {
  _$BangumiUserSmall _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _url;
  String get url => _$this._url;
  set url(String url) => _$this._url = url;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  String _nickname;
  String get nickname => _$this._nickname;
  set nickname(String nickname) => _$this._nickname = nickname;

  BangumiUserAvatarBuilder _avatar;
  BangumiUserAvatarBuilder get avatar =>
      _$this._avatar ??= new BangumiUserAvatarBuilder();
  set avatar(BangumiUserAvatarBuilder avatar) => _$this._avatar = avatar;

  String _sign;
  String get sign => _$this._sign;
  set sign(String sign) => _$this._sign = sign;

  int _userGroup;
  int get userGroup => _$this._userGroup;
  set userGroup(int userGroup) => _$this._userGroup = userGroup;

  BangumiUserSmallBuilder();

  BangumiUserSmallBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _url = _$v.url;
      _username = _$v.username;
      _nickname = _$v.nickname;
      _avatar = _$v.avatar?.toBuilder();
      _sign = _$v.sign;
      _userGroup = _$v.userGroup;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BangumiUserSmall other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BangumiUserSmall;
  }

  @override
  void update(void Function(BangumiUserSmallBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BangumiUserSmall build() {
    _$BangumiUserSmall _$result;
    try {
      _$result = _$v ??
          new _$BangumiUserSmall._(
              id: id,
              url: url,
              username: username,
              nickname: nickname,
              avatar: avatar.build(),
              sign: sign,
              userGroup: userGroup);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'avatar';
        avatar.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'BangumiUserSmall', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
