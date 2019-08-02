// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EpisodeThread.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<EpisodeThread> _$episodeThreadSerializer =
    new _$EpisodeThreadSerializer();

class _$EpisodeThreadSerializer implements StructuredSerializer<EpisodeThread> {
  @override
  final Iterable<Type> types = const [EpisodeThread, _$EpisodeThread];
  @override
  final String wireName = 'EpisodeThread';

  @override
  Iterable<Object> serialize(Serializers serializers, EpisodeThread object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'descriptionHtml',
      serializers.serialize(object.descriptionHtml,
          specifiedType: const FullType(String)),
      'relatedEpisodes',
      serializers.serialize(object.relatedEpisodes,
          specifiedType: const FullType(
              BuiltList, const [const FullType(ThreadRelatedEpisode)])),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'mainPostReplies',
      serializers.serialize(object.mainPostReplies,
          specifiedType:
              const FullType(BuiltList, const [const FullType(MainPostReply)])),
    ];
    if (object.parentSubject != null) {
      result
        ..add('parentSubject')
        ..add(serializers.serialize(object.parentSubject,
            specifiedType: const FullType(ParentSubject)));
    }
    return result;
  }

  @override
  EpisodeThread deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EpisodeThreadBuilder();

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
        case 'descriptionHtml':
          result.descriptionHtml = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'relatedEpisodes':
          result.relatedEpisodes.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ThreadRelatedEpisode)]))
              as BuiltList<dynamic>);
          break;
        case 'parentSubject':
          result.parentSubject.replace(serializers.deserialize(value,
              specifiedType: const FullType(ParentSubject)) as ParentSubject);
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'mainPostReplies':
          result.mainPostReplies.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(MainPostReply)]))
              as BuiltList<dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$EpisodeThread extends EpisodeThread {
  @override
  final String title;
  @override
  final String descriptionHtml;
  @override
  final BuiltList<ThreadRelatedEpisode> relatedEpisodes;
  @override
  final ParentSubject parentSubject;
  @override
  final int id;
  @override
  final BuiltList<MainPostReply> mainPostReplies;
  List<Post> __normalModePosts;
  List<Post> __hasNewestReplyFirstNestedPosts;
  List<Post> __newestFirstFlattenedPosts;

  factory _$EpisodeThread([void Function(EpisodeThreadBuilder) updates]) =>
      (new EpisodeThreadBuilder()..update(updates)).build();

  _$EpisodeThread._(
      {this.title,
      this.descriptionHtml,
      this.relatedEpisodes,
      this.parentSubject,
      this.id,
      this.mainPostReplies})
      : super._() {
    if (title == null) {
      throw new BuiltValueNullFieldError('EpisodeThread', 'title');
    }
    if (descriptionHtml == null) {
      throw new BuiltValueNullFieldError('EpisodeThread', 'descriptionHtml');
    }
    if (relatedEpisodes == null) {
      throw new BuiltValueNullFieldError('EpisodeThread', 'relatedEpisodes');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('EpisodeThread', 'id');
    }
    if (mainPostReplies == null) {
      throw new BuiltValueNullFieldError('EpisodeThread', 'mainPostReplies');
    }
  }

  @override
  List<Post> get normalModePosts => __normalModePosts ??= super.normalModePosts;

  @override
  List<Post> get hasNewestReplyFirstNestedPosts =>
      __hasNewestReplyFirstNestedPosts ??= super.hasNewestReplyFirstNestedPosts;

  @override
  List<Post> get newestFirstFlattenedPosts =>
      __newestFirstFlattenedPosts ??= super.newestFirstFlattenedPosts;

  @override
  EpisodeThread rebuild(void Function(EpisodeThreadBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EpisodeThreadBuilder toBuilder() => new EpisodeThreadBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EpisodeThread &&
        title == other.title &&
        descriptionHtml == other.descriptionHtml &&
        relatedEpisodes == other.relatedEpisodes &&
        parentSubject == other.parentSubject &&
        id == other.id &&
        mainPostReplies == other.mainPostReplies;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, title.hashCode), descriptionHtml.hashCode),
                    relatedEpisodes.hashCode),
                parentSubject.hashCode),
            id.hashCode),
        mainPostReplies.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('EpisodeThread')
          ..add('title', title)
          ..add('descriptionHtml', descriptionHtml)
          ..add('relatedEpisodes', relatedEpisodes)
          ..add('parentSubject', parentSubject)
          ..add('id', id)
          ..add('mainPostReplies', mainPostReplies))
        .toString();
  }
}

class EpisodeThreadBuilder
    implements
        Builder<EpisodeThread, EpisodeThreadBuilder>,
        BangumiThreadBuilder {
  _$EpisodeThread _$v;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _descriptionHtml;
  String get descriptionHtml => _$this._descriptionHtml;
  set descriptionHtml(String descriptionHtml) =>
      _$this._descriptionHtml = descriptionHtml;

  ListBuilder<ThreadRelatedEpisode> _relatedEpisodes;
  ListBuilder<ThreadRelatedEpisode> get relatedEpisodes =>
      _$this._relatedEpisodes ??= new ListBuilder<ThreadRelatedEpisode>();
  set relatedEpisodes(ListBuilder<ThreadRelatedEpisode> relatedEpisodes) =>
      _$this._relatedEpisodes = relatedEpisodes;

  ParentSubjectBuilder _parentSubject;
  ParentSubjectBuilder get parentSubject =>
      _$this._parentSubject ??= new ParentSubjectBuilder();
  set parentSubject(ParentSubjectBuilder parentSubject) =>
      _$this._parentSubject = parentSubject;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  ListBuilder<MainPostReply> _mainPostReplies;
  ListBuilder<MainPostReply> get mainPostReplies =>
      _$this._mainPostReplies ??= new ListBuilder<MainPostReply>();
  set mainPostReplies(ListBuilder<MainPostReply> mainPostReplies) =>
      _$this._mainPostReplies = mainPostReplies;

  EpisodeThreadBuilder();

  EpisodeThreadBuilder get _$this {
    if (_$v != null) {
      _title = _$v.title;
      _descriptionHtml = _$v.descriptionHtml;
      _relatedEpisodes = _$v.relatedEpisodes?.toBuilder();
      _parentSubject = _$v.parentSubject?.toBuilder();
      _id = _$v.id;
      _mainPostReplies = _$v.mainPostReplies?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant EpisodeThread other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$EpisodeThread;
  }

  @override
  void update(void Function(EpisodeThreadBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$EpisodeThread build() {
    _$EpisodeThread _$result;
    try {
      _$result = _$v ??
          new _$EpisodeThread._(
              title: title,
              descriptionHtml: descriptionHtml,
              relatedEpisodes: relatedEpisodes.build(),
              parentSubject: _parentSubject?.build(),
              id: id,
              mainPostReplies: mainPostReplies.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'relatedEpisodes';
        relatedEpisodes.build();
        _$failedField = 'parentSubject';
        _parentSubject?.build();

        _$failedField = 'mainPostReplies';
        mainPostReplies.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'EpisodeThread', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
