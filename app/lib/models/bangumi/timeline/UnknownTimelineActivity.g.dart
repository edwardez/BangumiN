// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UnknownTimelineActivity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UnknownTimelineActivity> _$unknownTimelineActivitySerializer =
    new _$UnknownTimelineActivitySerializer();

class _$UnknownTimelineActivitySerializer
    implements StructuredSerializer<UnknownTimelineActivity> {
  @override
  final Iterable<Type> types = const [
    UnknownTimelineActivity,
    _$UnknownTimelineActivity
  ];
  @override
  final String wireName = 'UnknownTimelineActivity';

  @override
  Iterable serialize(Serializers serializers, UnknownTimelineActivity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
    ];
    if (object.user != null) {
      result
        ..add('user')
        ..add(serializers.serialize(object.user,
            specifiedType: const FullType(FeedMetaInfo)));
    }
    if (object.bangumiContent != null) {
      result
        ..add('bangumiContent')
        ..add(serializers.serialize(object.bangumiContent,
            specifiedType: const FullType(BangumiContent)));
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
  UnknownTimelineActivity deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UnknownTimelineActivityBuilder();

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

class _$UnknownTimelineActivity extends UnknownTimelineActivity {
  @override
  final FeedMetaInfo user;
  @override
  final String content;
  @override
  final BangumiContent bangumiContent;
  @override
  final bool isFromMutedUser;

  factory _$UnknownTimelineActivity(
          [void Function(UnknownTimelineActivityBuilder) updates]) =>
      (new UnknownTimelineActivityBuilder()..update(updates)).build();

  _$UnknownTimelineActivity._(
      {this.user, this.content, this.bangumiContent, this.isFromMutedUser})
      : super._() {
    if (content == null) {
      throw new BuiltValueNullFieldError('UnknownTimelineActivity', 'content');
    }
  }

  @override
  UnknownTimelineActivity rebuild(
          void Function(UnknownTimelineActivityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UnknownTimelineActivityBuilder toBuilder() =>
      new UnknownTimelineActivityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UnknownTimelineActivity &&
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
    return (newBuiltValueToStringHelper('UnknownTimelineActivity')
          ..add('user', user)
          ..add('content', content)
          ..add('bangumiContent', bangumiContent)
          ..add('isFromMutedUser', isFromMutedUser))
        .toString();
  }
}

class UnknownTimelineActivityBuilder
    implements
        Builder<UnknownTimelineActivity, UnknownTimelineActivityBuilder>,
        TimelineFeedBuilder {
  _$UnknownTimelineActivity _$v;

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

  UnknownTimelineActivityBuilder();

  UnknownTimelineActivityBuilder get _$this {
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
  void replace(covariant UnknownTimelineActivity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UnknownTimelineActivity;
  }

  @override
  void update(void Function(UnknownTimelineActivityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UnknownTimelineActivity build() {
    _$UnknownTimelineActivity _$result;
    try {
      _$result = _$v ??
          new _$UnknownTimelineActivity._(
              user: _user?.build(),
              content: content,
              bangumiContent: bangumiContent,
              isFromMutedUser: isFromMutedUser);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UnknownTimelineActivity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
