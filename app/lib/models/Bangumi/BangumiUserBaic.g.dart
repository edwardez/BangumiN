// GENERATED CODE - DO NOT MODIFY BY HAND

part of bangumi_user_basic;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BangumiUserBasic> _$bangumiUserBasicSerializer =
    new _$BangumiUserBasicSerializer();

class _$BangumiUserBasicSerializer
    implements StructuredSerializer<BangumiUserBasic> {
  @override
  final Iterable<Type> types = const [BangumiUserBasic, _$BangumiUserBasic];
  @override
  final String wireName = 'BangumiUserBasic';

  @override
  Iterable serialize(Serializers serializers, BangumiUserBasic object,
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
  BangumiUserBasic deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BangumiUserBasicBuilder();

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

class _$BangumiUserBasic extends BangumiUserBasic {
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

  factory _$BangumiUserBasic([void updates(BangumiUserBasicBuilder b)]) =>
      (new BangumiUserBasicBuilder()..update(updates)).build();

  _$BangumiUserBasic._(
      {this.id,
      this.url,
      this.username,
      this.nickname,
      this.avatar,
      this.sign,
      this.userGroup})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('BangumiUserBasic', 'id');
    }
    if (url == null) {
      throw new BuiltValueNullFieldError('BangumiUserBasic', 'url');
    }
    if (username == null) {
      throw new BuiltValueNullFieldError('BangumiUserBasic', 'username');
    }
    if (nickname == null) {
      throw new BuiltValueNullFieldError('BangumiUserBasic', 'nickname');
    }
    if (avatar == null) {
      throw new BuiltValueNullFieldError('BangumiUserBasic', 'avatar');
    }
    if (sign == null) {
      throw new BuiltValueNullFieldError('BangumiUserBasic', 'sign');
    }
    if (userGroup == null) {
      throw new BuiltValueNullFieldError('BangumiUserBasic', 'userGroup');
    }
  }

  @override
  BangumiUserBasic rebuild(void updates(BangumiUserBasicBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  BangumiUserBasicBuilder toBuilder() =>
      new BangumiUserBasicBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BangumiUserBasic &&
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
    return (newBuiltValueToStringHelper('BangumiUserBasic')
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

class BangumiUserBasicBuilder
    implements Builder<BangumiUserBasic, BangumiUserBasicBuilder> {
  _$BangumiUserBasic _$v;

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

  BangumiUserBasicBuilder();

  BangumiUserBasicBuilder get _$this {
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
  void replace(BangumiUserBasic other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BangumiUserBasic;
  }

  @override
  void update(void updates(BangumiUserBasicBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$BangumiUserBasic build() {
    _$BangumiUserBasic _$result;
    try {
      _$result = _$v ??
          new _$BangumiUserBasic._(
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
            'BangumiUserBasic', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
