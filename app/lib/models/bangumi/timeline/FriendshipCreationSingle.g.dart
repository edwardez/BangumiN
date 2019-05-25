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
      'friendAvatar',
      serializers.serialize(object.friendAvatar,
          specifiedType: const FullType(BangumiImage)),
      'friendId',
      serializers.serialize(object.friendId,
          specifiedType: const FullType(String)),
      'bangumiContent',
      serializers.serialize(object.bangumiContent,
          specifiedType: const FullType(BangumiContent)),
    ];
    if (object.isFromMutedUser != null) {
      result
        ..add('isFromMutedUser')
        ..add(serializers.serialize(object.isFromMutedUser,
            specifiedType: const FullType(bool)));
    }

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
        case 'friendAvatar':
          result.friendAvatar.replace(serializers.deserialize(value,
              specifiedType: const FullType(BangumiImage)) as BangumiImage);
          break;
        case 'friendId':
          result.friendId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'bangumiContent':
          result.bangumiContent = serializers.deserialize(value,
              specifiedType: const FullType(BangumiContent)) as BangumiContent;
          break;
        case 'isFromMutedUser':
          result.isFromMutedUser = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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
  final BangumiImage friendAvatar;
  @override
  final String friendId;
  @override
  final BangumiContent bangumiContent;
  @override
  final bool isFromMutedUser;

  factory _$FriendshipCreationSingle(
          [void Function(FriendshipCreationSingleBuilder) updates]) =>
      (new FriendshipCreationSingleBuilder()..update(updates)).build();

  _$FriendshipCreationSingle._(
      {this.user,
      this.friendNickName,
      this.friendAvatar,
      this.friendId,
      this.bangumiContent,
      this.isFromMutedUser})
      : super._() {
    if (user == null) {
      throw new BuiltValueNullFieldError('FriendshipCreationSingle', 'user');
    }
    if (friendNickName == null) {
      throw new BuiltValueNullFieldError(
          'FriendshipCreationSingle', 'friendNickName');
    }
    if (friendAvatar == null) {
      throw new BuiltValueNullFieldError(
          'FriendshipCreationSingle', 'friendAvatar');
    }
    if (friendId == null) {
      throw new BuiltValueNullFieldError(
          'FriendshipCreationSingle', 'friendId');
    }
    if (bangumiContent == null) {
      throw new BuiltValueNullFieldError(
          'FriendshipCreationSingle', 'bangumiContent');
    }
  }

  @override
  FriendshipCreationSingle rebuild(
          void Function(FriendshipCreationSingleBuilder) updates) =>
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
        friendAvatar == other.friendAvatar &&
        friendId == other.friendId &&
        bangumiContent == other.bangumiContent &&
        isFromMutedUser == other.isFromMutedUser;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, user.hashCode), friendNickName.hashCode),
                    friendAvatar.hashCode),
                friendId.hashCode),
            bangumiContent.hashCode),
        isFromMutedUser.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FriendshipCreationSingle')
          ..add('user', user)
          ..add('friendNickName', friendNickName)
          ..add('friendAvatar', friendAvatar)
          ..add('friendId', friendId)
          ..add('bangumiContent', bangumiContent)
          ..add('isFromMutedUser', isFromMutedUser))
        .toString();
  }
}

class FriendshipCreationSingleBuilder
    implements
        Builder<FriendshipCreationSingle, FriendshipCreationSingleBuilder>,
        TimelineFeedBuilder {
  _$FriendshipCreationSingle _$v;

  FeedMetaInfoBuilder _user;
  FeedMetaInfoBuilder get user => _$this._user ??= new FeedMetaInfoBuilder();
  set user(FeedMetaInfoBuilder user) => _$this._user = user;

  String _friendNickName;
  String get friendNickName => _$this._friendNickName;
  set friendNickName(String friendNickName) =>
      _$this._friendNickName = friendNickName;

  BangumiImageBuilder _friendAvatar;
  BangumiImageBuilder get friendAvatar =>
      _$this._friendAvatar ??= new BangumiImageBuilder();
  set friendAvatar(BangumiImageBuilder friendAvatar) =>
      _$this._friendAvatar = friendAvatar;

  String _friendId;
  String get friendId => _$this._friendId;
  set friendId(String friendId) => _$this._friendId = friendId;

  BangumiContent _bangumiContent;
  BangumiContent get bangumiContent => _$this._bangumiContent;
  set bangumiContent(BangumiContent bangumiContent) =>
      _$this._bangumiContent = bangumiContent;

  bool _isFromMutedUser;
  bool get isFromMutedUser => _$this._isFromMutedUser;
  set isFromMutedUser(bool isFromMutedUser) =>
      _$this._isFromMutedUser = isFromMutedUser;

  FriendshipCreationSingleBuilder();

  FriendshipCreationSingleBuilder get _$this {
    if (_$v != null) {
      _user = _$v.user?.toBuilder();
      _friendNickName = _$v.friendNickName;
      _friendAvatar = _$v.friendAvatar?.toBuilder();
      _friendId = _$v.friendId;
      _bangumiContent = _$v.bangumiContent;
      _isFromMutedUser = _$v.isFromMutedUser;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant FriendshipCreationSingle other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FriendshipCreationSingle;
  }

  @override
  void update(void Function(FriendshipCreationSingleBuilder) updates) {
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
              friendAvatar: friendAvatar.build(),
              friendId: friendId,
              bangumiContent: bangumiContent,
              isFromMutedUser: isFromMutedUser);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        user.build();

        _$failedField = 'friendAvatar';
        friendAvatar.build();
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
