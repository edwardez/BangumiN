// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FeedMetaInfo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FeedMetaInfo> _$feedMetaInfoSerializer =
    new _$FeedMetaInfoSerializer();

class _$FeedMetaInfoSerializer implements StructuredSerializer<FeedMetaInfo> {
  @override
  final Iterable<Type> types = const [FeedMetaInfo, _$FeedMetaInfo];
  @override
  final String wireName = 'FeedMetaInfo';

  @override
  Iterable serialize(Serializers serializers, FeedMetaInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'feedId',
      serializers.serialize(object.feedId, specifiedType: const FullType(int)),
      'updatedAt',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(int)),
      'nickName',
      serializers.serialize(object.nickName,
          specifiedType: const FullType(String)),
      'avatars',
      serializers.serialize(object.avatars,
          specifiedType: const FullType(Images)),
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
    ];
    if (object.actionName != null) {
      result
        ..add('actionName')
        ..add(serializers.serialize(object.actionName,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  FeedMetaInfo deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FeedMetaInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'feedId':
          result.feedId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'nickName':
          result.nickName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'avatars':
          result.avatars.replace(serializers.deserialize(value,
              specifiedType: const FullType(Images)) as Images);
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'actionName':
          result.actionName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$FeedMetaInfo extends FeedMetaInfo {
  @override
  final int feedId;
  @override
  final int updatedAt;
  @override
  final String nickName;
  @override
  final Images avatars;
  @override
  final String username;
  @override
  final String actionName;

  factory _$FeedMetaInfo([void Function(FeedMetaInfoBuilder) updates]) =>
      (new FeedMetaInfoBuilder()..update(updates)).build();

  _$FeedMetaInfo._(
      {this.feedId,
      this.updatedAt,
      this.nickName,
      this.avatars,
      this.username,
      this.actionName})
      : super._() {
    if (feedId == null) {
      throw new BuiltValueNullFieldError('FeedMetaInfo', 'feedId');
    }
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('FeedMetaInfo', 'updatedAt');
    }
    if (nickName == null) {
      throw new BuiltValueNullFieldError('FeedMetaInfo', 'nickName');
    }
    if (avatars == null) {
      throw new BuiltValueNullFieldError('FeedMetaInfo', 'avatars');
    }
    if (username == null) {
      throw new BuiltValueNullFieldError('FeedMetaInfo', 'username');
    }
  }

  @override
  FeedMetaInfo rebuild(void Function(FeedMetaInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FeedMetaInfoBuilder toBuilder() => new FeedMetaInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FeedMetaInfo &&
        feedId == other.feedId &&
        updatedAt == other.updatedAt &&
        nickName == other.nickName &&
        avatars == other.avatars &&
        username == other.username &&
        actionName == other.actionName;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, feedId.hashCode), updatedAt.hashCode),
                    nickName.hashCode),
                avatars.hashCode),
            username.hashCode),
        actionName.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FeedMetaInfo')
          ..add('feedId', feedId)
          ..add('updatedAt', updatedAt)
          ..add('nickName', nickName)
          ..add('avatars', avatars)
          ..add('username', username)
          ..add('actionName', actionName))
        .toString();
  }
}

class FeedMetaInfoBuilder
    implements Builder<FeedMetaInfo, FeedMetaInfoBuilder> {
  _$FeedMetaInfo _$v;

  int _feedId;
  int get feedId => _$this._feedId;
  set feedId(int feedId) => _$this._feedId = feedId;

  int _updatedAt;
  int get updatedAt => _$this._updatedAt;
  set updatedAt(int updatedAt) => _$this._updatedAt = updatedAt;

  String _nickName;
  String get nickName => _$this._nickName;
  set nickName(String nickName) => _$this._nickName = nickName;

  ImagesBuilder _avatars;
  ImagesBuilder get avatars => _$this._avatars ??= new ImagesBuilder();
  set avatars(ImagesBuilder avatars) => _$this._avatars = avatars;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  String _actionName;
  String get actionName => _$this._actionName;
  set actionName(String actionName) => _$this._actionName = actionName;

  FeedMetaInfoBuilder();

  FeedMetaInfoBuilder get _$this {
    if (_$v != null) {
      _feedId = _$v.feedId;
      _updatedAt = _$v.updatedAt;
      _nickName = _$v.nickName;
      _avatars = _$v.avatars?.toBuilder();
      _username = _$v.username;
      _actionName = _$v.actionName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FeedMetaInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FeedMetaInfo;
  }

  @override
  void update(void Function(FeedMetaInfoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FeedMetaInfo build() {
    _$FeedMetaInfo _$result;
    try {
      _$result = _$v ??
          new _$FeedMetaInfo._(
              feedId: feedId,
              updatedAt: updatedAt,
              nickName: nickName,
              avatars: avatars.build(),
              username: username,
              actionName: actionName);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'avatars';
        avatars.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'FeedMetaInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
