// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GroupThread.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GroupThread> _$groupThreadSerializer = new _$GroupThreadSerializer();

class _$GroupThreadSerializer implements StructuredSerializer<GroupThread> {
  @override
  final Iterable<Type> types = const [GroupThread, _$GroupThread];
  @override
  final String wireName = 'GroupThread';

  @override
  Iterable serialize(Serializers serializers, GroupThread object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'groupName',
      serializers.serialize(object.groupName,
          specifiedType: const FullType(String)),
      'initialPost',
      serializers.serialize(object.initialPost,
          specifiedType: const FullType(OriginalPost)),
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
  GroupThread deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GroupThreadBuilder();

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
        case 'groupName':
          result.groupName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'initialPost':
          result.initialPost.replace(serializers.deserialize(value,
              specifiedType: const FullType(OriginalPost)) as OriginalPost);
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

class _$GroupThread extends GroupThread {
  @override
  final String title;
  @override
  final String groupName;
  @override
  final OriginalPost initialPost;
  @override
  final int id;
  @override
  final BuiltList<MainPostReply> mainPostReplies;
  List<Post> __posts;

  factory _$GroupThread([void Function(GroupThreadBuilder) updates]) =>
      (new GroupThreadBuilder()..update(updates)).build();

  _$GroupThread._(
      {this.title,
      this.groupName,
      this.initialPost,
      this.id,
      this.mainPostReplies})
      : super._() {
    if (title == null) {
      throw new BuiltValueNullFieldError('GroupThread', 'title');
    }
    if (groupName == null) {
      throw new BuiltValueNullFieldError('GroupThread', 'groupName');
    }
    if (initialPost == null) {
      throw new BuiltValueNullFieldError('GroupThread', 'initialPost');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('GroupThread', 'id');
    }
    if (mainPostReplies == null) {
      throw new BuiltValueNullFieldError('GroupThread', 'mainPostReplies');
    }
  }

  @override
  List<Post> get posts => __posts ??= super.posts;

  @override
  GroupThread rebuild(void Function(GroupThreadBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GroupThreadBuilder toBuilder() => new GroupThreadBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GroupThread &&
        title == other.title &&
        groupName == other.groupName &&
        initialPost == other.initialPost &&
        id == other.id &&
        mainPostReplies == other.mainPostReplies;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, title.hashCode), groupName.hashCode),
                initialPost.hashCode),
            id.hashCode),
        mainPostReplies.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GroupThread')
          ..add('title', title)
          ..add('groupName', groupName)
          ..add('initialPost', initialPost)
          ..add('id', id)
          ..add('mainPostReplies', mainPostReplies))
        .toString();
  }
}

class GroupThreadBuilder
    implements Builder<GroupThread, GroupThreadBuilder>, BangumiThreadBuilder {
  _$GroupThread _$v;

  String _title;

  String get title => _$this._title;

  set title(String title) => _$this._title = title;

  String _groupName;

  String get groupName => _$this._groupName;

  set groupName(String groupName) => _$this._groupName = groupName;

  OriginalPostBuilder _initialPost;

  OriginalPostBuilder get initialPost =>
      _$this._initialPost ??= new OriginalPostBuilder();

  set initialPost(OriginalPostBuilder initialPost) =>
      _$this._initialPost = initialPost;

  int _id;

  int get id => _$this._id;

  set id(int id) => _$this._id = id;

  ListBuilder<MainPostReply> _mainPostReplies;

  ListBuilder<MainPostReply> get mainPostReplies =>
      _$this._mainPostReplies ??= new ListBuilder<MainPostReply>();

  set mainPostReplies(ListBuilder<MainPostReply> mainPostReplies) =>
      _$this._mainPostReplies = mainPostReplies;

  GroupThreadBuilder();

  GroupThreadBuilder get _$this {
    if (_$v != null) {
      _title = _$v.title;
      _groupName = _$v.groupName;
      _initialPost = _$v.initialPost?.toBuilder();
      _id = _$v.id;
      _mainPostReplies = _$v.mainPostReplies?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant GroupThread other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$GroupThread;
  }

  @override
  void update(void Function(GroupThreadBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GroupThread build() {
    _$GroupThread _$result;
    try {
      _$result = _$v ??
          new _$GroupThread._(
              title: title,
              groupName: groupName,
              initialPost: initialPost.build(),
              id: id,
              mainPostReplies: mainPostReplies.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'initialPost';
        initialPost.build();

        _$failedField = 'mainPostReplies';
        mainPostReplies.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GroupThread', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
