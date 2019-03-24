// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FriendshipCreationSingle.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FriendshipCreationSingle> _$friendshipCreationSingleSerializer =
    new _$FriendshipCreationSingleSerializer();

class _$FriendshipCreationSingleSerializer
    implements StructuredSerializer<FriendshipCreationSingle> {
  @override
  final Iterable<Type> types = const [
    FriendshipCreationSingle,
    _$FriendshipCreationSingle
  ];
  @override
  final String wireName = 'FriendshipCreationSingle';

  @override
  Iterable serialize(Serializers serializers, FriendshipCreationSingle object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'user',
      serializers.serialize(object.user,
          specifiedType: const FullType(FeedMetaInfo)),
      'friendNickName',
      serializers.serialize(object.friendNickName,
          specifiedType: const FullType(String)),
      'friendAvatarImageUrl',
      serializers.serialize(object.friendAvatarImageUrl,
          specifiedType: const FullType(String)),
      'friendId',
      serializers.serialize(object.friendId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  FriendshipCreationSingle deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FriendshipCreationSingleBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'user':
          result.user.replace(serializers.deserialize(value,
              specifiedType: const FullType(FeedMetaInfo)) as FeedMetaInfo);
          break;
        case 'friendNickName':
          result.friendNickName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'friendAvatarImageUrl':
          result.friendAvatarImageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'friendId':
          result.friendId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$FriendshipCreationSingle extends FriendshipCreationSingle {
  @override
  final FeedMetaInfo user;
  @override
  final String friendNickName;
  @override
  final String friendAvatarImageUrl;
  @override
  final String friendId;

  factory _$FriendshipCreationSingle(
          [void updates(FriendshipCreationSingleBuilder b)]) =>
      (new FriendshipCreationSingleBuilder()..update(updates)).build();

  _$FriendshipCreationSingle._(
      {this.user,
      this.friendNickName,
      this.friendAvatarImageUrl,
      this.friendId})
      : super._() {
    if (user == null) {
      throw new BuiltValueNullFieldError('FriendshipCreationSingle', 'user');
    }
    if (friendNickName == null) {
      throw new BuiltValueNullFieldError(
          'FriendshipCreationSingle', 'friendNickName');
    }
    if (friendAvatarImageUrl == null) {
      throw new BuiltValueNullFieldError(
          'FriendshipCreationSingle', 'friendAvatarImageUrl');
    }
    if (friendId == null) {
      throw new BuiltValueNullFieldError(
          'FriendshipCreationSingle', 'friendId');
    }
  }

  @override
  FriendshipCreationSingle rebuild(
          void updates(FriendshipCreationSingleBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  FriendshipCreationSingleBuilder toBuilder() =>
      new FriendshipCreationSingleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FriendshipCreationSingle &&
        user == other.user &&
        friendNickName == other.friendNickName &&
        friendAvatarImageUrl == other.friendAvatarImageUrl &&
        friendId == other.friendId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, user.hashCode), friendNickName.hashCode),
            friendAvatarImageUrl.hashCode),
        friendId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FriendshipCreationSingle')
          ..add('user', user)
          ..add('friendNickName', friendNickName)
          ..add('friendAvatarImageUrl', friendAvatarImageUrl)
          ..add('friendId', friendId))
        .toString();
  }
}

class FriendshipCreationSingleBuilder
    implements
        Builder<FriendshipCreationSingle, FriendshipCreationSingleBuilder> {
  _$FriendshipCreationSingle _$v;

  FeedMetaInfoBuilder _user;
  FeedMetaInfoBuilder get user => _$this._user ??= new FeedMetaInfoBuilder();
  set user(FeedMetaInfoBuilder user) => _$this._user = user;

  String _friendNickName;
  String get friendNickName => _$this._friendNickName;
  set friendNickName(String friendNickName) =>
      _$this._friendNickName = friendNickName;

  String _friendAvatarImageUrl;
  String get friendAvatarImageUrl => _$this._friendAvatarImageUrl;
  set friendAvatarImageUrl(String friendAvatarImageUrl) =>
      _$this._friendAvatarImageUrl = friendAvatarImageUrl;

  String _friendId;
  String get friendId => _$this._friendId;
  set friendId(String friendId) => _$this._friendId = friendId;

  FriendshipCreationSingleBuilder();

  FriendshipCreationSingleBuilder get _$this {
    if (_$v != null) {
      _user = _$v.user?.toBuilder();
      _friendNickName = _$v.friendNickName;
      _friendAvatarImageUrl = _$v.friendAvatarImageUrl;
      _friendId = _$v.friendId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FriendshipCreationSingle other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FriendshipCreationSingle;
  }

  @override
  void update(void updates(FriendshipCreationSingleBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$FriendshipCreationSingle build() {
    _$FriendshipCreationSingle _$result;
    try {
      _$result = _$v ??
          new _$FriendshipCreationSingle._(
              user: user.build(),
              friendNickName: friendNickName,
              friendAvatarImageUrl: friendAvatarImageUrl,
              friendId: friendId);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'FriendshipCreationSingle', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
