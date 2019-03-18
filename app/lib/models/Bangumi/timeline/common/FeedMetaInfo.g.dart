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
      'updatedAt',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(String)),
      'nickName',
      serializers.serialize(object.nickName,
          specifiedType: const FullType(String)),
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'feedId',
      serializers.serialize(object.feedId, specifiedType: const FullType(int)),
      'actionName',
      serializers.serialize(object.actionName,
          specifiedType: const FullType(String)),
    ];
    if (object.avatarImageUrl != null) {
      result
        ..add('avatarImageUrl')
        ..add(serializers.serialize(object.avatarImageUrl,
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
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'nickName':
          result.nickName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'avatarImageUrl':
          result.avatarImageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'feedId':
          result.feedId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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
  final String updatedAt;
  @override
  final String nickName;
  @override
  final String avatarImageUrl;
  @override
  final String userId;
  @override
  final int feedId;
  @override
  final String actionName;

  factory _$FeedMetaInfo([void updates(FeedMetaInfoBuilder b)]) =>
      (new FeedMetaInfoBuilder()..update(updates)).build();

  _$FeedMetaInfo._(
      {this.updatedAt,
      this.nickName,
      this.avatarImageUrl,
      this.userId,
      this.feedId,
      this.actionName})
      : super._() {
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('FeedMetaInfo', 'updatedAt');
    }
    if (nickName == null) {
      throw new BuiltValueNullFieldError('FeedMetaInfo', 'nickName');
    }
    if (userId == null) {
      throw new BuiltValueNullFieldError('FeedMetaInfo', 'userId');
    }
    if (feedId == null) {
      throw new BuiltValueNullFieldError('FeedMetaInfo', 'feedId');
    }
    if (actionName == null) {
      throw new BuiltValueNullFieldError('FeedMetaInfo', 'actionName');
    }
  }

  @override
  FeedMetaInfo rebuild(void updates(FeedMetaInfoBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  FeedMetaInfoBuilder toBuilder() => new FeedMetaInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FeedMetaInfo &&
        updatedAt == other.updatedAt &&
        nickName == other.nickName &&
        avatarImageUrl == other.avatarImageUrl &&
        userId == other.userId &&
        feedId == other.feedId &&
        actionName == other.actionName;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, updatedAt.hashCode), nickName.hashCode),
                    avatarImageUrl.hashCode),
                userId.hashCode),
            feedId.hashCode),
        actionName.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FeedMetaInfo')
          ..add('updatedAt', updatedAt)
          ..add('nickName', nickName)
          ..add('avatarImageUrl', avatarImageUrl)
          ..add('userId', userId)
          ..add('feedId', feedId)
          ..add('actionName', actionName))
        .toString();
  }
}

class FeedMetaInfoBuilder
    implements Builder<FeedMetaInfo, FeedMetaInfoBuilder> {
  _$FeedMetaInfo _$v;

  String _updatedAt;

  String get updatedAt => _$this._updatedAt;

  set updatedAt(String updatedAt) => _$this._updatedAt = updatedAt;

  String _nickName;

  String get nickName => _$this._nickName;

  set nickName(String nickName) => _$this._nickName = nickName;

  String _avatarImageUrl;

  String get avatarImageUrl => _$this._avatarImageUrl;

  set avatarImageUrl(String avatarImageUrl) =>
      _$this._avatarImageUrl = avatarImageUrl;

  String _userId;

  String get userId => _$this._userId;

  set userId(String userId) => _$this._userId = userId;

  int _feedId;

  int get feedId => _$this._feedId;

  set feedId(int feedId) => _$this._feedId = feedId;

  String _actionName;

  String get actionName => _$this._actionName;

  set actionName(String actionName) => _$this._actionName = actionName;

  FeedMetaInfoBuilder();

  FeedMetaInfoBuilder get _$this {
    if (_$v != null) {
      _updatedAt = _$v.updatedAt;
      _nickName = _$v.nickName;
      _avatarImageUrl = _$v.avatarImageUrl;
      _userId = _$v.userId;
      _feedId = _$v.feedId;
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
  void update(void updates(FeedMetaInfoBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$FeedMetaInfo build() {
    final _$result = _$v ??
        new _$FeedMetaInfo._(
            updatedAt: updatedAt,
            nickName: nickName,
            avatarImageUrl: avatarImageUrl,
            userId: userId,
            feedId: feedId,
            actionName: actionName);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
