// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BlogCreationSingle.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BlogCreationSingle> _$blogCreationSingleSerializer =
    new _$BlogCreationSingleSerializer();

class _$BlogCreationSingleSerializer
    implements StructuredSerializer<BlogCreationSingle> {
  @override
  final Iterable<Type> types = const [BlogCreationSingle, _$BlogCreationSingle];
  @override
  final String wireName = 'BlogCreationSingle';

  @override
  Iterable serialize(Serializers serializers, BlogCreationSingle object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'user',
      serializers.serialize(object.user,
          specifiedType: const FullType(FeedMetaInfo)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'bangumiContent',
      serializers.serialize(object.bangumiContent,
          specifiedType: const FullType(BangumiContent)),
    ];
    if (object.summary != null) {
      result
        ..add('summary')
        ..add(serializers.serialize(object.summary,
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
  BlogCreationSingle deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BlogCreationSingleBuilder();

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
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'summary':
          result.summary = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
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

class _$BlogCreationSingle extends BlogCreationSingle {
  @override
  final FeedMetaInfo user;
  @override
  final String title;
  @override
  final String summary;
  @override
  final String id;
  @override
  final BangumiContent bangumiContent;
  @override
  final bool isFromMutedUser;

  factory _$BlogCreationSingle(
          [void Function(BlogCreationSingleBuilder) updates]) =>
      (new BlogCreationSingleBuilder()..update(updates)).build();

  _$BlogCreationSingle._(
      {this.user,
      this.title,
      this.summary,
      this.id,
      this.bangumiContent,
      this.isFromMutedUser})
      : super._() {
    if (user == null) {
      throw new BuiltValueNullFieldError('BlogCreationSingle', 'user');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('BlogCreationSingle', 'title');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('BlogCreationSingle', 'id');
    }
    if (bangumiContent == null) {
      throw new BuiltValueNullFieldError(
          'BlogCreationSingle', 'bangumiContent');
    }
  }

  @override
  BlogCreationSingle rebuild(
          void Function(BlogCreationSingleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BlogCreationSingleBuilder toBuilder() =>
      new BlogCreationSingleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BlogCreationSingle &&
        user == other.user &&
        title == other.title &&
        summary == other.summary &&
        id == other.id &&
        bangumiContent == other.bangumiContent &&
        isFromMutedUser == other.isFromMutedUser;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, user.hashCode), title.hashCode),
                    summary.hashCode),
                id.hashCode),
            bangumiContent.hashCode),
        isFromMutedUser.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BlogCreationSingle')
          ..add('user', user)
          ..add('title', title)
          ..add('summary', summary)
          ..add('id', id)
          ..add('bangumiContent', bangumiContent)
          ..add('isFromMutedUser', isFromMutedUser))
        .toString();
  }
}

class BlogCreationSingleBuilder
    implements
        Builder<BlogCreationSingle, BlogCreationSingleBuilder>,
        TimelineFeedBuilder {
  _$BlogCreationSingle _$v;

  FeedMetaInfoBuilder _user;
  FeedMetaInfoBuilder get user => _$this._user ??= new FeedMetaInfoBuilder();
  set user(FeedMetaInfoBuilder user) => _$this._user = user;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _summary;
  String get summary => _$this._summary;
  set summary(String summary) => _$this._summary = summary;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  BangumiContent _bangumiContent;
  BangumiContent get bangumiContent => _$this._bangumiContent;
  set bangumiContent(BangumiContent bangumiContent) =>
      _$this._bangumiContent = bangumiContent;

  bool _isFromMutedUser;
  bool get isFromMutedUser => _$this._isFromMutedUser;
  set isFromMutedUser(bool isFromMutedUser) =>
      _$this._isFromMutedUser = isFromMutedUser;

  BlogCreationSingleBuilder();

  BlogCreationSingleBuilder get _$this {
    if (_$v != null) {
      _user = _$v.user?.toBuilder();
      _title = _$v.title;
      _summary = _$v.summary;
      _id = _$v.id;
      _bangumiContent = _$v.bangumiContent;
      _isFromMutedUser = _$v.isFromMutedUser;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant BlogCreationSingle other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BlogCreationSingle;
  }

  @override
  void update(void Function(BlogCreationSingleBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BlogCreationSingle build() {
    _$BlogCreationSingle _$result;
    try {
      _$result = _$v ??
          new _$BlogCreationSingle._(
              user: user.build(),
              title: title,
              summary: summary,
              id: id,
              bangumiContent: bangumiContent,
              isFromMutedUser: isFromMutedUser);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'BlogCreationSingle', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
