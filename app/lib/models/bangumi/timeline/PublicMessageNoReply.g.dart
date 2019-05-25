// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PublicMessageNoReply.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PublicMessageNoReply> _$publicMessageNoReplySerializer =
    new _$PublicMessageNoReplySerializer();

class _$PublicMessageNoReplySerializer
    implements StructuredSerializer<PublicMessageNoReply> {
  @override
  final Iterable<Type> types = const [
    PublicMessageNoReply,
    _$PublicMessageNoReply
  ];
  @override
  final String wireName = 'PublicMessageNoReply';

  @override
  Iterable serialize(Serializers serializers, PublicMessageNoReply object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'user',
      serializers.serialize(object.user,
          specifiedType: const FullType(FeedMetaInfo)),
      'content',
      serializers.serialize(object.content,
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
  PublicMessageNoReply deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PublicMessageNoReplyBuilder();

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

class _$PublicMessageNoReply extends PublicMessageNoReply {
  @override
  final FeedMetaInfo user;
  @override
  final String content;
  @override
  final BangumiContent bangumiContent;
  @override
  final bool isFromMutedUser;

  factory _$PublicMessageNoReply(
          [void Function(PublicMessageNoReplyBuilder) updates]) =>
      (new PublicMessageNoReplyBuilder()..update(updates)).build();

  _$PublicMessageNoReply._(
      {this.user, this.content, this.bangumiContent, this.isFromMutedUser})
      : super._() {
    if (user == null) {
      throw new BuiltValueNullFieldError('PublicMessageNoReply', 'user');
    }
    if (content == null) {
      throw new BuiltValueNullFieldError('PublicMessageNoReply', 'content');
    }
    if (bangumiContent == null) {
      throw new BuiltValueNullFieldError(
          'PublicMessageNoReply', 'bangumiContent');
    }
  }

  @override
  PublicMessageNoReply rebuild(
          void Function(PublicMessageNoReplyBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PublicMessageNoReplyBuilder toBuilder() =>
      new PublicMessageNoReplyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PublicMessageNoReply &&
        user == other.user &&
        content == other.content &&
        bangumiContent == other.bangumiContent &&
        isFromMutedUser == other.isFromMutedUser;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, user.hashCode), content.hashCode),
            bangumiContent.hashCode),
        isFromMutedUser.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PublicMessageNoReply')
          ..add('user', user)
          ..add('content', content)
          ..add('bangumiContent', bangumiContent)
          ..add('isFromMutedUser', isFromMutedUser))
        .toString();
  }
}

class PublicMessageNoReplyBuilder
    implements
        Builder<PublicMessageNoReply, PublicMessageNoReplyBuilder>,
        TimelineFeedBuilder {
  _$PublicMessageNoReply _$v;

  FeedMetaInfoBuilder _user;
  FeedMetaInfoBuilder get user => _$this._user ??= new FeedMetaInfoBuilder();
  set user(FeedMetaInfoBuilder user) => _$this._user = user;

  String _content;
  String get content => _$this._content;
  set content(String content) => _$this._content = content;

  BangumiContent _bangumiContent;
  BangumiContent get bangumiContent => _$this._bangumiContent;
  set bangumiContent(BangumiContent bangumiContent) =>
      _$this._bangumiContent = bangumiContent;

  bool _isFromMutedUser;
  bool get isFromMutedUser => _$this._isFromMutedUser;
  set isFromMutedUser(bool isFromMutedUser) =>
      _$this._isFromMutedUser = isFromMutedUser;

  PublicMessageNoReplyBuilder();

  PublicMessageNoReplyBuilder get _$this {
    if (_$v != null) {
      _user = _$v.user?.toBuilder();
      _content = _$v.content;
      _bangumiContent = _$v.bangumiContent;
      _isFromMutedUser = _$v.isFromMutedUser;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant PublicMessageNoReply other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PublicMessageNoReply;
  }

  @override
  void update(void Function(PublicMessageNoReplyBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PublicMessageNoReply build() {
    _$PublicMessageNoReply _$result;
    try {
      _$result = _$v ??
          new _$PublicMessageNoReply._(
              user: user.build(),
              content: content,
              bangumiContent: bangumiContent,
              isFromMutedUser: isFromMutedUser);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PublicMessageNoReply', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
