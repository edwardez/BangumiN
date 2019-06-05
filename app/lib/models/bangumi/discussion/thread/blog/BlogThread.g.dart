// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BlogThread.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BlogThread> _$blogThreadSerializer = new _$BlogThreadSerializer();

class _$BlogThreadSerializer implements StructuredSerializer<BlogThread> {
  @override
  final Iterable<Type> types = const [BlogThread, _$BlogThread];
  @override
  final String wireName = 'BlogThread';

  @override
  Iterable serialize(Serializers serializers, BlogThread object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'blogContent',
      serializers.serialize(object.blogContent,
          specifiedType: const FullType(BlogContent)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'mainPostReplies',
      serializers.serialize(object.mainPostReplies,
          specifiedType:
              const FullType(BuiltList, const [const FullType(MainPostReply)])),
    ];

    return result;
  }

  @override
  BlogThread deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BlogThreadBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'blogContent':
          result.blogContent.replace(serializers.deserialize(value,
              specifiedType: const FullType(BlogContent)) as BlogContent);
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'mainPostReplies':
          result.mainPostReplies.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(MainPostReply)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$BlogThread extends BlogThread {
  @override
  final BlogContent blogContent;
  @override
  final int id;
  @override
  final String title;
  @override
  final BuiltList<MainPostReply> mainPostReplies;
  List<Post> __posts;

  factory _$BlogThread([void Function(BlogThreadBuilder) updates]) =>
      (new BlogThreadBuilder()..update(updates)).build();

  _$BlogThread._({this.blogContent, this.id, this.title, this.mainPostReplies})
      : super._() {
    if (blogContent == null) {
      throw new BuiltValueNullFieldError('BlogThread', 'blogContent');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('BlogThread', 'id');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('BlogThread', 'title');
    }
    if (mainPostReplies == null) {
      throw new BuiltValueNullFieldError('BlogThread', 'mainPostReplies');
    }
  }

  @override
  List<Post> get posts => __posts ??= super.posts;

  @override
  BlogThread rebuild(void Function(BlogThreadBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BlogThreadBuilder toBuilder() => new BlogThreadBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BlogThread &&
        blogContent == other.blogContent &&
        id == other.id &&
        title == other.title &&
        mainPostReplies == other.mainPostReplies;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, blogContent.hashCode), id.hashCode), title.hashCode),
        mainPostReplies.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BlogThread')
          ..add('blogContent', blogContent)
          ..add('id', id)
          ..add('title', title)
          ..add('mainPostReplies', mainPostReplies))
        .toString();
  }
}

class BlogThreadBuilder
    implements Builder<BlogThread, BlogThreadBuilder>, BangumiThreadBuilder {
  _$BlogThread _$v;

  BlogContentBuilder _blogContent;
  BlogContentBuilder get blogContent =>
      _$this._blogContent ??= new BlogContentBuilder();
  set blogContent(BlogContentBuilder blogContent) =>
      _$this._blogContent = blogContent;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  ListBuilder<MainPostReply> _mainPostReplies;
  ListBuilder<MainPostReply> get mainPostReplies =>
      _$this._mainPostReplies ??= new ListBuilder<MainPostReply>();
  set mainPostReplies(ListBuilder<MainPostReply> mainPostReplies) =>
      _$this._mainPostReplies = mainPostReplies;

  BlogThreadBuilder();

  BlogThreadBuilder get _$this {
    if (_$v != null) {
      _blogContent = _$v.blogContent?.toBuilder();
      _id = _$v.id;
      _title = _$v.title;
      _mainPostReplies = _$v.mainPostReplies?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant BlogThread other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BlogThread;
  }

  @override
  void update(void Function(BlogThreadBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BlogThread build() {
    _$BlogThread _$result;
    try {
      _$result = _$v ??
          new _$BlogThread._(
              blogContent: blogContent.build(),
              id: id,
              title: title,
              mainPostReplies: mainPostReplies.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'blogContent';
        blogContent.build();

        _$failedField = 'mainPostReplies';
        mainPostReplies.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'BlogThread', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
