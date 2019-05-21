// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GroupJoinSingle.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GroupJoinSingle> _$groupJoinSingleSerializer =
    new _$GroupJoinSingleSerializer();

class _$GroupJoinSingleSerializer
    implements StructuredSerializer<GroupJoinSingle> {
  @override
  final Iterable<Type> types = const [GroupJoinSingle, _$GroupJoinSingle];
  @override
  final String wireName = 'GroupJoinSingle';

  @override
  Iterable serialize(Serializers serializers, GroupJoinSingle object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'user',
      serializers.serialize(object.user,
          specifiedType: const FullType(FeedMetaInfo)),
      'groupCoverImageUrl',
      serializers.serialize(object.groupCoverImageUrl,
          specifiedType: const FullType(String)),
      'groupName',
      serializers.serialize(object.groupName,
          specifiedType: const FullType(String)),
      'groupId',
      serializers.serialize(object.groupId,
          specifiedType: const FullType(String)),
    ];
    if (object.groupDescription != null) {
      result
        ..add('groupDescription')
        ..add(serializers.serialize(object.groupDescription,
            specifiedType: const FullType(String)));
    }
    if (object.isFromMutedUser != null) {
      result
        ..add('isFromMutedUser')
        ..add(serializers.serialize(object.isFromMutedUser,
            specifiedType: const FullType(bool)));
    }

    return result;
  }

  @override
  GroupJoinSingle deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GroupJoinSingleBuilder();

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
        case 'groupCoverImageUrl':
          result.groupCoverImageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'groupName':
          result.groupName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'groupDescription':
          result.groupDescription = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'groupId':
          result.groupId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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

class _$GroupJoinSingle extends GroupJoinSingle {
  @override
  final FeedMetaInfo user;
  @override
  final String groupCoverImageUrl;
  @override
  final String groupName;
  @override
  final String groupDescription;
  @override
  final String groupId;
  @override
  final bool isFromMutedUser;

  factory _$GroupJoinSingle([void Function(GroupJoinSingleBuilder) updates]) =>
      (new GroupJoinSingleBuilder()..update(updates)).build();

  _$GroupJoinSingle._(
      {this.user,
      this.groupCoverImageUrl,
      this.groupName,
      this.groupDescription,
      this.groupId,
      this.isFromMutedUser})
      : super._() {
    if (user == null) {
      throw new BuiltValueNullFieldError('GroupJoinSingle', 'user');
    }
    if (groupCoverImageUrl == null) {
      throw new BuiltValueNullFieldError(
          'GroupJoinSingle', 'groupCoverImageUrl');
    }
    if (groupName == null) {
      throw new BuiltValueNullFieldError('GroupJoinSingle', 'groupName');
    }
    if (groupId == null) {
      throw new BuiltValueNullFieldError('GroupJoinSingle', 'groupId');
    }
  }

  @override
  GroupJoinSingle rebuild(void Function(GroupJoinSingleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GroupJoinSingleBuilder toBuilder() =>
      new GroupJoinSingleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GroupJoinSingle &&
        user == other.user &&
        groupCoverImageUrl == other.groupCoverImageUrl &&
        groupName == other.groupName &&
        groupDescription == other.groupDescription &&
        groupId == other.groupId &&
        isFromMutedUser == other.isFromMutedUser;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, user.hashCode), groupCoverImageUrl.hashCode),
                    groupName.hashCode),
                groupDescription.hashCode),
            groupId.hashCode),
        isFromMutedUser.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GroupJoinSingle')
          ..add('user', user)
          ..add('groupCoverImageUrl', groupCoverImageUrl)
          ..add('groupName', groupName)
          ..add('groupDescription', groupDescription)
          ..add('groupId', groupId)
          ..add('isFromMutedUser', isFromMutedUser))
        .toString();
  }
}

class GroupJoinSingleBuilder
    implements
        Builder<GroupJoinSingle, GroupJoinSingleBuilder>,
        TimelineFeedBuilder {
  _$GroupJoinSingle _$v;

  FeedMetaInfoBuilder _user;
  FeedMetaInfoBuilder get user => _$this._user ??= new FeedMetaInfoBuilder();
  set user(FeedMetaInfoBuilder user) => _$this._user = user;

  String _groupCoverImageUrl;
  String get groupCoverImageUrl => _$this._groupCoverImageUrl;
  set groupCoverImageUrl(String groupCoverImageUrl) =>
      _$this._groupCoverImageUrl = groupCoverImageUrl;

  String _groupName;
  String get groupName => _$this._groupName;
  set groupName(String groupName) => _$this._groupName = groupName;

  String _groupDescription;
  String get groupDescription => _$this._groupDescription;
  set groupDescription(String groupDescription) =>
      _$this._groupDescription = groupDescription;

  String _groupId;
  String get groupId => _$this._groupId;
  set groupId(String groupId) => _$this._groupId = groupId;

  bool _isFromMutedUser;
  bool get isFromMutedUser => _$this._isFromMutedUser;
  set isFromMutedUser(bool isFromMutedUser) =>
      _$this._isFromMutedUser = isFromMutedUser;

  GroupJoinSingleBuilder();

  GroupJoinSingleBuilder get _$this {
    if (_$v != null) {
      _user = _$v.user?.toBuilder();
      _groupCoverImageUrl = _$v.groupCoverImageUrl;
      _groupName = _$v.groupName;
      _groupDescription = _$v.groupDescription;
      _groupId = _$v.groupId;
      _isFromMutedUser = _$v.isFromMutedUser;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant GroupJoinSingle other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$GroupJoinSingle;
  }

  @override
  void update(void Function(GroupJoinSingleBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GroupJoinSingle build() {
    _$GroupJoinSingle _$result;
    try {
      _$result = _$v ??
          new _$GroupJoinSingle._(
              user: user.build(),
              groupCoverImageUrl: groupCoverImageUrl,
              groupName: groupName,
              groupDescription: groupDescription,
              groupId: groupId,
              isFromMutedUser: isFromMutedUser);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GroupJoinSingle', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
