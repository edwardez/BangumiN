// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BlogContent.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BlogContent> _$blogContentSerializer = new _$BlogContentSerializer();

class _$BlogContentSerializer implements StructuredSerializer<BlogContent> {
  @override
  final Iterable<Type> types = const [BlogContent, _$BlogContent];
  @override
  final String wireName = 'BlogContent';

  @override
  Iterable serialize(Serializers serializers, BlogContent object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'author',
      serializers.serialize(object.author,
          specifiedType: const FullType(BangumiUserBasic)),
      'html',
      serializers.serialize(object.html, specifiedType: const FullType(String)),
      'postTimeInMilliSeconds',
      serializers.serialize(object.postTimeInMilliSeconds,
          specifiedType: const FullType(int)),
      'associatedSubjects',
      serializers.serialize(object.associatedSubjects,
          specifiedType: const FullType(
              BuiltList, const [const FullType(ThreadParentSubject)])),
    ];

    return result;
  }

  @override
  BlogContent deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BlogContentBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'author':
          result.author.replace(serializers.deserialize(value,
                  specifiedType: const FullType(BangumiUserBasic))
              as BangumiUserBasic);
          break;
        case 'html':
          result.html = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'postTimeInMilliSeconds':
          result.postTimeInMilliSeconds = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'associatedSubjects':
          result.associatedSubjects.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ThreadParentSubject)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$BlogContent extends BlogContent {
  @override
  final BangumiUserBasic author;
  @override
  final String html;
  @override
  final int postTimeInMilliSeconds;
  @override
  final BuiltList<ThreadParentSubject> associatedSubjects;

  factory _$BlogContent([void Function(BlogContentBuilder) updates]) =>
      (new BlogContentBuilder()..update(updates)).build();

  _$BlogContent._(
      {this.author,
      this.html,
      this.postTimeInMilliSeconds,
      this.associatedSubjects})
      : super._() {
    if (author == null) {
      throw new BuiltValueNullFieldError('BlogContent', 'author');
    }
    if (html == null) {
      throw new BuiltValueNullFieldError('BlogContent', 'html');
    }
    if (postTimeInMilliSeconds == null) {
      throw new BuiltValueNullFieldError(
          'BlogContent', 'postTimeInMilliSeconds');
    }
    if (associatedSubjects == null) {
      throw new BuiltValueNullFieldError('BlogContent', 'associatedSubjects');
    }
  }

  @override
  BlogContent rebuild(void Function(BlogContentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BlogContentBuilder toBuilder() => new BlogContentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BlogContent &&
        author == other.author &&
        html == other.html &&
        postTimeInMilliSeconds == other.postTimeInMilliSeconds &&
        associatedSubjects == other.associatedSubjects;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, author.hashCode), html.hashCode),
            postTimeInMilliSeconds.hashCode),
        associatedSubjects.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BlogContent')
          ..add('author', author)
          ..add('html', html)
          ..add('postTimeInMilliSeconds', postTimeInMilliSeconds)
          ..add('associatedSubjects', associatedSubjects))
        .toString();
  }
}

class BlogContentBuilder implements Builder<BlogContent, BlogContentBuilder> {
  _$BlogContent _$v;

  BangumiUserBasicBuilder _author;

  BangumiUserBasicBuilder get author =>
      _$this._author ??= new BangumiUserBasicBuilder();

  set author(BangumiUserBasicBuilder author) => _$this._author = author;

  String _html;

  String get html => _$this._html;

  set html(String html) => _$this._html = html;

  int _postTimeInMilliSeconds;

  int get postTimeInMilliSeconds => _$this._postTimeInMilliSeconds;

  set postTimeInMilliSeconds(int postTimeInMilliSeconds) =>
      _$this._postTimeInMilliSeconds = postTimeInMilliSeconds;

  ListBuilder<ThreadParentSubject> _associatedSubjects;

  ListBuilder<ThreadParentSubject> get associatedSubjects =>
      _$this._associatedSubjects ??= new ListBuilder<ThreadParentSubject>();

  set associatedSubjects(ListBuilder<ThreadParentSubject> associatedSubjects) =>
      _$this._associatedSubjects = associatedSubjects;

  BlogContentBuilder();

  BlogContentBuilder get _$this {
    if (_$v != null) {
      _author = _$v.author?.toBuilder();
      _html = _$v.html;
      _postTimeInMilliSeconds = _$v.postTimeInMilliSeconds;
      _associatedSubjects = _$v.associatedSubjects?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BlogContent other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BlogContent;
  }

  @override
  void update(void Function(BlogContentBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BlogContent build() {
    _$BlogContent _$result;
    try {
      _$result = _$v ??
          new _$BlogContent._(
              author: author.build(),
              html: html,
              postTimeInMilliSeconds: postTimeInMilliSeconds,
              associatedSubjects: associatedSubjects.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'author';
        author.build();

        _$failedField = 'associatedSubjects';
        associatedSubjects.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'BlogContent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
