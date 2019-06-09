// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DiscussionState.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DiscussionState> _$discussionStateSerializer =
    new _$DiscussionStateSerializer();

class _$DiscussionStateSerializer
    implements StructuredSerializer<DiscussionState> {
  @override
  final Iterable<Type> types = const [DiscussionState, _$DiscussionState];
  @override
  final String wireName = 'DiscussionState';

  @override
  Iterable serialize(Serializers serializers, DiscussionState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'discussions',
      serializers.serialize(object.discussions,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(GetDiscussionRequest),
            const FullType(GetDiscussionResponse)
          ])),
      'groupThreads',
      serializers.serialize(object.groupThreads,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(int), const FullType(GroupThread)])),
      'episodeThreads',
      serializers.serialize(object.episodeThreads,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(int), const FullType(EpisodeThread)])),
      'subjectTopicThreads',
      serializers.serialize(object.subjectTopicThreads,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(int), const FullType(SubjectTopicThread)])),
      'blogThreads',
      serializers.serialize(object.blogThreads,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(int), const FullType(BlogThread)])),
    ];
    if (object.getThreadLoadingStatus != null) {
      result
        ..add('getThreadLoadingStatus')
        ..add(serializers.serialize(object.getThreadLoadingStatus,
            specifiedType: const FullType(BuiltMap, const [
              const FullType(GetThreadRequest),
              const FullType(LoadingStatus)
            ])));
    }
    return result;
  }

  @override
  DiscussionState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DiscussionStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'discussions':
          result.discussions.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(GetDiscussionRequest),
                const FullType(GetDiscussionResponse)
              ])) as BuiltMap);
          break;
        case 'groupThreads':
          result.groupThreads.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(GroupThread)
              ])) as BuiltMap);
          break;
        case 'episodeThreads':
          result.episodeThreads.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(EpisodeThread)
              ])) as BuiltMap);
          break;
        case 'subjectTopicThreads':
          result.subjectTopicThreads.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(SubjectTopicThread)
              ])) as BuiltMap);
          break;
        case 'blogThreads':
          result.blogThreads.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(BlogThread)
              ])) as BuiltMap);
          break;
        case 'getThreadLoadingStatus':
          result.getThreadLoadingStatus.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(GetThreadRequest),
                const FullType(LoadingStatus)
              ])) as BuiltMap);
          break;
      }
    }

    return result.build();
  }
}

class _$DiscussionState extends DiscussionState {
  @override
  final BuiltMap<GetDiscussionRequest, GetDiscussionResponse> discussions;
  @override
  final BuiltMap<int, GroupThread> groupThreads;
  @override
  final BuiltMap<int, EpisodeThread> episodeThreads;
  @override
  final BuiltMap<int, SubjectTopicThread> subjectTopicThreads;
  @override
  final BuiltMap<int, BlogThread> blogThreads;
  @override
  final BuiltMap<GetThreadRequest, LoadingStatus> getThreadLoadingStatus;

  factory _$DiscussionState([void Function(DiscussionStateBuilder) updates]) =>
      (new DiscussionStateBuilder()..update(updates)).build();

  _$DiscussionState._(
      {this.discussions,
      this.groupThreads,
      this.episodeThreads,
      this.subjectTopicThreads,
      this.blogThreads,
      this.getThreadLoadingStatus})
      : super._() {
    if (discussions == null) {
      throw new BuiltValueNullFieldError('DiscussionState', 'discussions');
    }
    if (groupThreads == null) {
      throw new BuiltValueNullFieldError('DiscussionState', 'groupThreads');
    }
    if (episodeThreads == null) {
      throw new BuiltValueNullFieldError('DiscussionState', 'episodeThreads');
    }
    if (subjectTopicThreads == null) {
      throw new BuiltValueNullFieldError(
          'DiscussionState', 'subjectTopicThreads');
    }
    if (blogThreads == null) {
      throw new BuiltValueNullFieldError('DiscussionState', 'blogThreads');
    }
  }

  @override
  DiscussionState rebuild(void Function(DiscussionStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DiscussionStateBuilder toBuilder() =>
      new DiscussionStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DiscussionState &&
        discussions == other.discussions &&
        groupThreads == other.groupThreads &&
        episodeThreads == other.episodeThreads &&
        subjectTopicThreads == other.subjectTopicThreads &&
        blogThreads == other.blogThreads &&
        getThreadLoadingStatus == other.getThreadLoadingStatus;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, discussions.hashCode), groupThreads.hashCode),
                    episodeThreads.hashCode),
                subjectTopicThreads.hashCode),
            blogThreads.hashCode),
        getThreadLoadingStatus.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DiscussionState')
          ..add('discussions', discussions)
          ..add('groupThreads', groupThreads)
          ..add('episodeThreads', episodeThreads)
          ..add('subjectTopicThreads', subjectTopicThreads)
          ..add('blogThreads', blogThreads)
          ..add('getThreadLoadingStatus', getThreadLoadingStatus))
        .toString();
  }
}

class DiscussionStateBuilder
    implements Builder<DiscussionState, DiscussionStateBuilder> {
  _$DiscussionState _$v;

  MapBuilder<GetDiscussionRequest, GetDiscussionResponse> _discussions;
  MapBuilder<GetDiscussionRequest, GetDiscussionResponse> get discussions =>
      _$this._discussions ??=
          new MapBuilder<GetDiscussionRequest, GetDiscussionResponse>();
  set discussions(
          MapBuilder<GetDiscussionRequest, GetDiscussionResponse>
              discussions) =>
      _$this._discussions = discussions;

  MapBuilder<int, GroupThread> _groupThreads;
  MapBuilder<int, GroupThread> get groupThreads =>
      _$this._groupThreads ??= new MapBuilder<int, GroupThread>();
  set groupThreads(MapBuilder<int, GroupThread> groupThreads) =>
      _$this._groupThreads = groupThreads;

  MapBuilder<int, EpisodeThread> _episodeThreads;
  MapBuilder<int, EpisodeThread> get episodeThreads =>
      _$this._episodeThreads ??= new MapBuilder<int, EpisodeThread>();
  set episodeThreads(MapBuilder<int, EpisodeThread> episodeThreads) =>
      _$this._episodeThreads = episodeThreads;

  MapBuilder<int, SubjectTopicThread> _subjectTopicThreads;
  MapBuilder<int, SubjectTopicThread> get subjectTopicThreads =>
      _$this._subjectTopicThreads ??= new MapBuilder<int, SubjectTopicThread>();
  set subjectTopicThreads(
          MapBuilder<int, SubjectTopicThread> subjectTopicThreads) =>
      _$this._subjectTopicThreads = subjectTopicThreads;

  MapBuilder<int, BlogThread> _blogThreads;
  MapBuilder<int, BlogThread> get blogThreads =>
      _$this._blogThreads ??= new MapBuilder<int, BlogThread>();
  set blogThreads(MapBuilder<int, BlogThread> blogThreads) =>
      _$this._blogThreads = blogThreads;

  MapBuilder<GetThreadRequest, LoadingStatus> _getThreadLoadingStatus;
  MapBuilder<GetThreadRequest, LoadingStatus> get getThreadLoadingStatus =>
      _$this._getThreadLoadingStatus ??=
          new MapBuilder<GetThreadRequest, LoadingStatus>();
  set getThreadLoadingStatus(
          MapBuilder<GetThreadRequest, LoadingStatus> getThreadLoadingStatus) =>
      _$this._getThreadLoadingStatus = getThreadLoadingStatus;

  DiscussionStateBuilder();

  DiscussionStateBuilder get _$this {
    if (_$v != null) {
      _discussions = _$v.discussions?.toBuilder();
      _groupThreads = _$v.groupThreads?.toBuilder();
      _episodeThreads = _$v.episodeThreads?.toBuilder();
      _subjectTopicThreads = _$v.subjectTopicThreads?.toBuilder();
      _blogThreads = _$v.blogThreads?.toBuilder();
      _getThreadLoadingStatus = _$v.getThreadLoadingStatus?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DiscussionState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DiscussionState;
  }

  @override
  void update(void Function(DiscussionStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DiscussionState build() {
    _$DiscussionState _$result;
    try {
      _$result = _$v ??
          new _$DiscussionState._(
              discussions: discussions.build(),
              groupThreads: groupThreads.build(),
              episodeThreads: episodeThreads.build(),
              subjectTopicThreads: subjectTopicThreads.build(),
              blogThreads: blogThreads.build(),
              getThreadLoadingStatus: _getThreadLoadingStatus?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'discussions';
        discussions.build();
        _$failedField = 'groupThreads';
        groupThreads.build();
        _$failedField = 'episodeThreads';
        episodeThreads.build();
        _$failedField = 'subjectTopicThreads';
        subjectTopicThreads.build();
        _$failedField = 'blogThreads';
        blogThreads.build();
        _$failedField = 'getThreadLoadingStatus';
        _getThreadLoadingStatus?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DiscussionState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
