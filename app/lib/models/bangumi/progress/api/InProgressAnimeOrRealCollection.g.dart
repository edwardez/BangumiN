// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'InProgressAnimeOrRealCollection.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<InProgressAnimeOrRealCollection>
    _$inProgressAnimeOrRealCollectionSerializer =
    new _$InProgressAnimeOrRealCollectionSerializer();

class _$InProgressAnimeOrRealCollectionSerializer
    implements StructuredSerializer<InProgressAnimeOrRealCollection> {
  @override
  final Iterable<Type> types = const [
    InProgressAnimeOrRealCollection,
    _$InProgressAnimeOrRealCollection
  ];
  @override
  final String wireName = 'InProgressAnimeOrRealCollection';

  @override
  Iterable serialize(
      Serializers serializers, InProgressAnimeOrRealCollection object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'ep_status',
      serializers.serialize(object.completedEpisodesCount,
          specifiedType: const FullType(int)),
      'lasttouch',
      serializers.serialize(object.userUpdatedAt,
          specifiedType: const FullType(int)),
      'subject',
      serializers.serialize(object.subject,
          specifiedType: const FullType(InProgressSubjectInfo)),
    ];
    if (object.episodes != null) {
      result
        ..add('episodes')
        ..add(serializers.serialize(object.episodes,
            specifiedType: const FullType(BuiltMap,
                const [const FullType(int), const FullType(EpisodeProgress)])));
    }
    return result;
  }

  @override
  InProgressAnimeOrRealCollection deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InProgressAnimeOrRealCollectionBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'ep_status':
          result.completedEpisodesCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'episodes':
          result.episodes.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(EpisodeProgress)
              ])) as BuiltMap);
          break;
        case 'lasttouch':
          result.userUpdatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'subject':
          result.subject.replace(serializers.deserialize(value,
                  specifiedType: const FullType(InProgressSubjectInfo))
              as InProgressSubjectInfo);
          break;
      }
    }

    return result.build();
  }
}

class _$InProgressAnimeOrRealCollection
    extends InProgressAnimeOrRealCollection {
  @override
  final int completedEpisodesCount;
  @override
  final BuiltMap<int, EpisodeProgress> episodes;
  @override
  final int userUpdatedAt;
  @override
  final InProgressSubjectInfo subject;

  factory _$InProgressAnimeOrRealCollection(
          [void Function(InProgressAnimeOrRealCollectionBuilder) updates]) =>
      (new InProgressAnimeOrRealCollectionBuilder()..update(updates)).build();

  _$InProgressAnimeOrRealCollection._(
      {this.completedEpisodesCount,
      this.episodes,
      this.userUpdatedAt,
      this.subject})
      : super._() {
    if (completedEpisodesCount == null) {
      throw new BuiltValueNullFieldError(
          'InProgressAnimeOrRealCollection', 'completedEpisodesCount');
    }
    if (userUpdatedAt == null) {
      throw new BuiltValueNullFieldError(
          'InProgressAnimeOrRealCollection', 'userUpdatedAt');
    }
    if (subject == null) {
      throw new BuiltValueNullFieldError(
          'InProgressAnimeOrRealCollection', 'subject');
    }
  }

  @override
  InProgressAnimeOrRealCollection rebuild(
          void Function(InProgressAnimeOrRealCollectionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InProgressAnimeOrRealCollectionBuilder toBuilder() =>
      new InProgressAnimeOrRealCollectionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InProgressAnimeOrRealCollection &&
        completedEpisodesCount == other.completedEpisodesCount &&
        episodes == other.episodes &&
        userUpdatedAt == other.userUpdatedAt &&
        subject == other.subject;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, completedEpisodesCount.hashCode), episodes.hashCode),
            userUpdatedAt.hashCode),
        subject.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InProgressAnimeOrRealCollection')
          ..add('completedEpisodesCount', completedEpisodesCount)
          ..add('episodes', episodes)
          ..add('userUpdatedAt', userUpdatedAt)
          ..add('subject', subject))
        .toString();
  }
}

class InProgressAnimeOrRealCollectionBuilder
    implements
        Builder<InProgressAnimeOrRealCollection,
            InProgressAnimeOrRealCollectionBuilder>,
        InProgressCollectionBuilder {
  _$InProgressAnimeOrRealCollection _$v;

  int _completedEpisodesCount;
  int get completedEpisodesCount => _$this._completedEpisodesCount;
  set completedEpisodesCount(int completedEpisodesCount) =>
      _$this._completedEpisodesCount = completedEpisodesCount;

  MapBuilder<int, EpisodeProgress> _episodes;
  MapBuilder<int, EpisodeProgress> get episodes =>
      _$this._episodes ??= new MapBuilder<int, EpisodeProgress>();
  set episodes(MapBuilder<int, EpisodeProgress> episodes) =>
      _$this._episodes = episodes;

  int _userUpdatedAt;
  int get userUpdatedAt => _$this._userUpdatedAt;
  set userUpdatedAt(int userUpdatedAt) => _$this._userUpdatedAt = userUpdatedAt;

  InProgressSubjectInfoBuilder _subject;
  InProgressSubjectInfoBuilder get subject =>
      _$this._subject ??= new InProgressSubjectInfoBuilder();
  set subject(InProgressSubjectInfoBuilder subject) =>
      _$this._subject = subject;

  InProgressAnimeOrRealCollectionBuilder();

  InProgressAnimeOrRealCollectionBuilder get _$this {
    if (_$v != null) {
      _completedEpisodesCount = _$v.completedEpisodesCount;
      _episodes = _$v.episodes?.toBuilder();
      _userUpdatedAt = _$v.userUpdatedAt;
      _subject = _$v.subject?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant InProgressAnimeOrRealCollection other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InProgressAnimeOrRealCollection;
  }

  @override
  void update(void Function(InProgressAnimeOrRealCollectionBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InProgressAnimeOrRealCollection build() {
    _$InProgressAnimeOrRealCollection _$result;
    try {
      _$result = _$v ??
          new _$InProgressAnimeOrRealCollection._(
              completedEpisodesCount: completedEpisodesCount,
              episodes: _episodes?.build(),
              userUpdatedAt: userUpdatedAt,
              subject: subject.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'episodes';
        _episodes?.build();

        _$failedField = 'subject';
        subject.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'InProgressAnimeOrRealCollection', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
