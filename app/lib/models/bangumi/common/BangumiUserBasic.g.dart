// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BangumiUserBasic.dart';

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
  Iterable<Object> serialize(Serializers serializers, BangumiUserBasic object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
      'nickname',
      serializers.serialize(object.nickname,
          specifiedType: const FullType(String)),
    ];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    if (object.avatar != null) {
      result
        ..add('avatar')
        ..add(serializers.serialize(object.avatar,
            specifiedType: const FullType(BangumiImage)));
    }
    return result;
  }

  @override
  BangumiUserBasic deserialize(
      Serializers serializers, Iterable<Object> serialized,
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
              specifiedType: const FullType(BangumiImage)) as BangumiImage);
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
  final String username;
  @override
  final String nickname;
  @override
  final BangumiImage avatar;

  factory _$BangumiUserBasic(
          [void Function(BangumiUserBasicBuilder) updates]) =>
      (new BangumiUserBasicBuilder()..update(updates)).build();

  _$BangumiUserBasic._({this.id, this.username, this.nickname, this.avatar})
      : super._() {
    if (username == null) {
      throw new BuiltValueNullFieldError('BangumiUserBasic', 'username');
    }
    if (nickname == null) {
      throw new BuiltValueNullFieldError('BangumiUserBasic', 'nickname');
    }
  }

  @override
  BangumiUserBasic rebuild(void Function(BangumiUserBasicBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BangumiUserBasicBuilder toBuilder() =>
      new BangumiUserBasicBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BangumiUserBasic &&
        id == other.id &&
        username == other.username &&
        nickname == other.nickname &&
        avatar == other.avatar;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, id.hashCode), username.hashCode), nickname.hashCode),
        avatar.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BangumiUserBasic')
          ..add('id', id)
          ..add('username', username)
          ..add('nickname', nickname)
          ..add('avatar', avatar))
        .toString();
  }
}

class BangumiUserBasicBuilder
    implements Builder<BangumiUserBasic, BangumiUserBasicBuilder> {
  _$BangumiUserBasic _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  String _nickname;
  String get nickname => _$this._nickname;
  set nickname(String nickname) => _$this._nickname = nickname;

  BangumiImageBuilder _avatar;
  BangumiImageBuilder get avatar =>
      _$this._avatar ??= new BangumiImageBuilder();
  set avatar(BangumiImageBuilder avatar) => _$this._avatar = avatar;

  BangumiUserBasicBuilder();

  BangumiUserBasicBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _username = _$v.username;
      _nickname = _$v.nickname;
      _avatar = _$v.avatar?.toBuilder();
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
  void update(void Function(BangumiUserBasicBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BangumiUserBasic build() {
    _$BangumiUserBasic _$result;
    try {
      _$result = _$v ??
          new _$BangumiUserBasic._(
              id: id,
              username: username,
              nickname: nickname,
              avatar: _avatar?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'avatar';
        _avatar?.build();
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
