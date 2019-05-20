// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PublicMessageNormal.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PublicMessageNormal> _$publicMessageNormalSerializer =
    new _$PublicMessageNormalSerializer();

class _$PublicMessageNormalSerializer
    implements StructuredSerializer<PublicMessageNormal> {
  @override
  final Iterable<Type> types = const [
    PublicMessageNormal,
    _$PublicMessageNormal
  ];
  @override
  final String wireName = 'PublicMessageNormal';

  @override
  Iterable serialize(Serializers serializers, PublicMessageNormal object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'user',
      serializers.serialize(object.user,
          specifiedType: const FullType(FeedMetaInfo)),
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
      'replyCount',
      serializers.serialize(object.replyCount,
          specifiedType: const FullType(int)),
    ];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
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
  PublicMessageNormal deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PublicMessageNormalBuilder();

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
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'replyCount':
          result.replyCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
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

class _$PublicMessageNormal extends PublicMessageNormal {
  @override
  final FeedMetaInfo user;
  @override
  final String content;
  @override
  final int replyCount;
  @override
  final String id;
  @override
  final bool isFromMutedUser;

  factory _$PublicMessageNormal(
          [void Function(PublicMessageNormalBuilder) updates]) =>
      (new PublicMessageNormalBuilder()..update(updates)).build();

  _$PublicMessageNormal._(
      {this.user, this.content, this.replyCount, this.id, this.isFromMutedUser})
      : super._() {
    if (user == null) {
      throw new BuiltValueNullFieldError('PublicMessageNormal', 'user');
    }
    if (content == null) {
      throw new BuiltValueNullFieldError('PublicMessageNormal', 'content');
    }
    if (replyCount == null) {
      throw new BuiltValueNullFieldError('PublicMessageNormal', 'replyCount');
    }
  }

  @override
  PublicMessageNormal rebuild(
          void Function(PublicMessageNormalBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PublicMessageNormalBuilder toBuilder() =>
      new PublicMessageNormalBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PublicMessageNormal &&
        user == other.user &&
        content == other.content &&
        replyCount == other.replyCount &&
        id == other.id &&
        isFromMutedUser == other.isFromMutedUser;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, user.hashCode), content.hashCode),
                replyCount.hashCode),
            id.hashCode),
        isFromMutedUser.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PublicMessageNormal')
          ..add('user', user)
          ..add('content', content)
          ..add('replyCount', replyCount)
          ..add('id', id)
          ..add('isFromMutedUser', isFromMutedUser))
        .toString();
  }
}

class PublicMessageNormalBuilder
    implements
        Builder<PublicMessageNormal, PublicMessageNormalBuilder>,
        TimelineFeedBuilder {
  _$PublicMessageNormal _$v;

  FeedMetaInfoBuilder _user;
  FeedMetaInfoBuilder get user => _$this._user ??= new FeedMetaInfoBuilder();
  set user(FeedMetaInfoBuilder user) => _$this._user = user;

  String _content;
  String get content => _$this._content;
  set content(String content) => _$this._content = content;

  int _replyCount;
  int get replyCount => _$this._replyCount;
  set replyCount(int replyCount) => _$this._replyCount = replyCount;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  bool _isFromMutedUser;
  bool get isFromMutedUser => _$this._isFromMutedUser;
  set isFromMutedUser(bool isFromMutedUser) =>
      _$this._isFromMutedUser = isFromMutedUser;

  PublicMessageNormalBuilder();

  PublicMessageNormalBuilder get _$this {
    if (_$v != null) {
      _user = _$v.user?.toBuilder();
      _content = _$v.content;
      _replyCount = _$v.replyCount;
      _id = _$v.id;
      _isFromMutedUser = _$v.isFromMutedUser;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant PublicMessageNormal other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PublicMessageNormal;
  }

  @override
  void update(void Function(PublicMessageNormalBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PublicMessageNormal build() {
    _$PublicMessageNormal _$result;
    try {
      _$result = _$v ??
          new _$PublicMessageNormal._(
              user: user.build(),
              content: content,
              replyCount: replyCount,
              id: id,
              isFromMutedUser: isFromMutedUser);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PublicMessageNormal', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
