// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BangumiUserIdentity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BangumiUserIdentity> _$bangumiUserIdentitySerializer =
    new _$BangumiUserIdentitySerializer();

class _$BangumiUserIdentitySerializer
    implements StructuredSerializer<BangumiUserIdentity> {
  @override
  final Iterable<Type> types = const [
    BangumiUserIdentity,
    _$BangumiUserIdentity
  ];
  @override
  final String wireName = 'BangumiUserIdentity';

  @override
  Iterable serialize(Serializers serializers, BangumiUserIdentity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'access_token',
      serializers.serialize(object.accessToken,
          specifiedType: const FullType(String)),
      'client_id',
      serializers.serialize(object.clientId,
          specifiedType: const FullType(String)),
      'expires',
      serializers.serialize(object.expires, specifiedType: const FullType(int)),
      'user_id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];
    if (object.scope != null) {
      result
        ..add('scope')
        ..add(serializers.serialize(object.scope,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  BangumiUserIdentity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BangumiUserIdentityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'access_token':
          result.accessToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_id':
          result.clientId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'expires':
          result.expires = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'scope':
          result.scope = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'user_id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$BangumiUserIdentity extends BangumiUserIdentity {
  @override
  final String accessToken;
  @override
  final String clientId;
  @override
  final int expires;
  @override
  final String scope;
  @override
  final int id;

  factory _$BangumiUserIdentity([void updates(BangumiUserIdentityBuilder b)]) =>
      (new BangumiUserIdentityBuilder()..update(updates)).build();

  _$BangumiUserIdentity._(
      {this.accessToken, this.clientId, this.expires, this.scope, this.id})
      : super._() {
    if (accessToken == null) {
      throw new BuiltValueNullFieldError('BangumiUserIdentity', 'accessToken');
    }
    if (clientId == null) {
      throw new BuiltValueNullFieldError('BangumiUserIdentity', 'clientId');
    }
    if (expires == null) {
      throw new BuiltValueNullFieldError('BangumiUserIdentity', 'expires');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('BangumiUserIdentity', 'id');
    }
  }

  @override
  BangumiUserIdentity rebuild(void updates(BangumiUserIdentityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  BangumiUserIdentityBuilder toBuilder() =>
      new BangumiUserIdentityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BangumiUserIdentity &&
        accessToken == other.accessToken &&
        clientId == other.clientId &&
        expires == other.expires &&
        scope == other.scope &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, accessToken.hashCode), clientId.hashCode),
                expires.hashCode),
            scope.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BangumiUserIdentity')
          ..add('accessToken', accessToken)
          ..add('clientId', clientId)
          ..add('expires', expires)
          ..add('scope', scope)
          ..add('id', id))
        .toString();
  }
}

class BangumiUserIdentityBuilder
    implements Builder<BangumiUserIdentity, BangumiUserIdentityBuilder> {
  _$BangumiUserIdentity _$v;

  String _accessToken;

  String get accessToken => _$this._accessToken;

  set accessToken(String accessToken) => _$this._accessToken = accessToken;

  String _clientId;

  String get clientId => _$this._clientId;

  set clientId(String clientId) => _$this._clientId = clientId;

  int _expires;

  int get expires => _$this._expires;

  set expires(int expires) => _$this._expires = expires;

  String _scope;

  String get scope => _$this._scope;

  set scope(String scope) => _$this._scope = scope;

  int _id;

  int get id => _$this._id;

  set id(int id) => _$this._id = id;

  BangumiUserIdentityBuilder();

  BangumiUserIdentityBuilder get _$this {
    if (_$v != null) {
      _accessToken = _$v.accessToken;
      _clientId = _$v.clientId;
      _expires = _$v.expires;
      _scope = _$v.scope;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BangumiUserIdentity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BangumiUserIdentity;
  }

  @override
  void update(void updates(BangumiUserIdentityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$BangumiUserIdentity build() {
    final _$result = _$v ??
        new _$BangumiUserIdentity._(
            accessToken: accessToken,
            clientId: clientId,
            expires: expires,
            scope: scope,
            id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
