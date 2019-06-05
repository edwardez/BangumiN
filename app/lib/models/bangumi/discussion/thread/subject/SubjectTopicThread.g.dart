// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectTopicThread.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SubjectTopicThread> _$subjectTopicThreadSerializer =
    new _$SubjectTopicThreadSerializer();

class _$SubjectTopicThreadSerializer
    implements StructuredSerializer<SubjectTopicThread> {
  @override
  final Iterable<Type> types = const [SubjectTopicThread, _$SubjectTopicThread];
  @override
  final String wireName = 'SubjectTopicThread';

  @override
  Iterable serialize(Serializers serializers, SubjectTopicThread object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'originalPost',
      serializers.serialize(object.originalPost,
          specifiedType: const FullType(OriginalPost)),
      'parentSubject',
      serializers.serialize(object.parentSubject,
          specifiedType: const FullType(ThreadParentSubject)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'mainPostReplies',
      serializers.serialize(object.mainPostReplies,
          specifiedType:
              const FullType(BuiltList, const [const FullType(MainPostReply)])),
    ];

    return result;
  }

  @override
  SubjectTopicThread deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubjectTopicThreadBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'originalPost':
          result.originalPost.replace(serializers.deserialize(value,
              specifiedType: const FullType(OriginalPost)) as OriginalPost);
          break;
        case 'parentSubject':
          result.parentSubject.replace(serializers.deserialize(value,
                  specifiedType: const FullType(ThreadParentSubject))
              as ThreadParentSubject);
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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

class _$SubjectTopicThread extends SubjectTopicThread {
  @override
  final String title;
  @override
  final OriginalPost originalPost;
  @override
  final ThreadParentSubject parentSubject;
  @override
  final int id;
  @override
  final BuiltList<MainPostReply> mainPostReplies;
  List<Post> __posts;

  factory _$SubjectTopicThread(
          [void Function(SubjectTopicThreadBuilder) updates]) =>
      (new SubjectTopicThreadBuilder()..update(updates)).build();

  _$SubjectTopicThread._(
      {this.title,
      this.originalPost,
      this.parentSubject,
      this.id,
      this.mainPostReplies})
      : super._() {
    if (title == null) {
      throw new BuiltValueNullFieldError('SubjectTopicThread', 'title');
    }
    if (originalPost == null) {
      throw new BuiltValueNullFieldError('SubjectTopicThread', 'originalPost');
    }
    if (parentSubject == null) {
      throw new BuiltValueNullFieldError('SubjectTopicThread', 'parentSubject');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('SubjectTopicThread', 'id');
    }
    if (mainPostReplies == null) {
      throw new BuiltValueNullFieldError(
          'SubjectTopicThread', 'mainPostReplies');
    }
  }

  @override
  List<Post> get posts => __posts ??= super.posts;

  @override
  SubjectTopicThread rebuild(
          void Function(SubjectTopicThreadBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubjectTopicThreadBuilder toBuilder() =>
      new SubjectTopicThreadBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubjectTopicThread &&
        title == other.title &&
        originalPost == other.originalPost &&
        parentSubject == other.parentSubject &&
        id == other.id &&
        mainPostReplies == other.mainPostReplies;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, title.hashCode), originalPost.hashCode),
                parentSubject.hashCode),
            id.hashCode),
        mainPostReplies.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubjectTopicThread')
          ..add('title', title)
          ..add('originalPost', originalPost)
          ..add('parentSubject', parentSubject)
          ..add('id', id)
          ..add('mainPostReplies', mainPostReplies))
        .toString();
  }
}

class SubjectTopicThreadBuilder
    implements
        Builder<SubjectTopicThread, SubjectTopicThreadBuilder>,
        BangumiThreadBuilder {
  _$SubjectTopicThread _$v;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  OriginalPostBuilder _originalPost;
  OriginalPostBuilder get originalPost =>
      _$this._originalPost ??= new OriginalPostBuilder();
  set originalPost(OriginalPostBuilder originalPost) =>
      _$this._originalPost = originalPost;

  ThreadParentSubjectBuilder _parentSubject;
  ThreadParentSubjectBuilder get parentSubject =>
      _$this._parentSubject ??= new ThreadParentSubjectBuilder();
  set parentSubject(ThreadParentSubjectBuilder parentSubject) =>
      _$this._parentSubject = parentSubject;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  ListBuilder<MainPostReply> _mainPostReplies;
  ListBuilder<MainPostReply> get mainPostReplies =>
      _$this._mainPostReplies ??= new ListBuilder<MainPostReply>();
  set mainPostReplies(ListBuilder<MainPostReply> mainPostReplies) =>
      _$this._mainPostReplies = mainPostReplies;

  SubjectTopicThreadBuilder();

  SubjectTopicThreadBuilder get _$this {
    if (_$v != null) {
      _title = _$v.title;
      _originalPost = _$v.originalPost?.toBuilder();
      _parentSubject = _$v.parentSubject?.toBuilder();
      _id = _$v.id;
      _mainPostReplies = _$v.mainPostReplies?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant SubjectTopicThread other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubjectTopicThread;
  }

  @override
  void update(void Function(SubjectTopicThreadBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubjectTopicThread build() {
    _$SubjectTopicThread _$result;
    try {
      _$result = _$v ??
          new _$SubjectTopicThread._(
              title: title,
              originalPost: originalPost.build(),
              parentSubject: parentSubject.build(),
              id: id,
              mainPostReplies: mainPostReplies.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'originalPost';
        originalPost.build();
        _$failedField = 'parentSubject';
        parentSubject.build();

        _$failedField = 'mainPostReplies';
        mainPostReplies.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SubjectTopicThread', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
