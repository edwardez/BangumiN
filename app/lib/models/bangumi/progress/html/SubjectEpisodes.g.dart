// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectEpisodes.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SubjectEpisodes> _$subjectEpisodesSerializer =
    new _$SubjectEpisodesSerializer();

class _$SubjectEpisodesSerializer
    implements StructuredSerializer<SubjectEpisodes> {
  @override
  final Iterable<Type> types = const [SubjectEpisodes, _$SubjectEpisodes];
  @override
  final String wireName = 'SubjectEpisodes';

  @override
  Iterable<Object> serialize(Serializers serializers, SubjectEpisodes object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'episodes',
      serializers.serialize(object.episodes,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(int),
            const FullType(SimpleHtmlBasedEpisode)
          ])),
    ];
    if (object.subject != null) {
      result
        ..add('subject')
        ..add(serializers.serialize(object.subject,
            specifiedType: const FullType(ParentSubject)));
    }
    return result;
  }

  @override
  SubjectEpisodes deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubjectEpisodesBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'subject':
          result.subject.replace(serializers.deserialize(value,
              specifiedType: const FullType(ParentSubject)) as ParentSubject);
          break;
        case 'episodes':
          result.episodes.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(SimpleHtmlBasedEpisode)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$SubjectEpisodes extends SubjectEpisodes {
  @override
  final ParentSubject subject;
  @override
  final BuiltMap<int, SimpleHtmlBasedEpisode> episodes;

  factory _$SubjectEpisodes([void Function(SubjectEpisodesBuilder) updates]) =>
      (new SubjectEpisodesBuilder()..update(updates)).build();

  _$SubjectEpisodes._({this.subject, this.episodes}) : super._() {
    if (episodes == null) {
      throw new BuiltValueNullFieldError('SubjectEpisodes', 'episodes');
    }
  }

  @override
  SubjectEpisodes rebuild(void Function(SubjectEpisodesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubjectEpisodesBuilder toBuilder() =>
      new SubjectEpisodesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubjectEpisodes &&
        subject == other.subject &&
        episodes == other.episodes;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, subject.hashCode), episodes.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubjectEpisodes')
          ..add('subject', subject)
          ..add('episodes', episodes))
        .toString();
  }
}

class SubjectEpisodesBuilder
    implements Builder<SubjectEpisodes, SubjectEpisodesBuilder> {
  _$SubjectEpisodes _$v;

  ParentSubjectBuilder _subject;
  ParentSubjectBuilder get subject =>
      _$this._subject ??= new ParentSubjectBuilder();
  set subject(ParentSubjectBuilder subject) => _$this._subject = subject;

  MapBuilder<int, SimpleHtmlBasedEpisode> _episodes;
  MapBuilder<int, SimpleHtmlBasedEpisode> get episodes =>
      _$this._episodes ??= new MapBuilder<int, SimpleHtmlBasedEpisode>();
  set episodes(MapBuilder<int, SimpleHtmlBasedEpisode> episodes) =>
      _$this._episodes = episodes;

  SubjectEpisodesBuilder();

  SubjectEpisodesBuilder get _$this {
    if (_$v != null) {
      _subject = _$v.subject?.toBuilder();
      _episodes = _$v.episodes?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubjectEpisodes other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubjectEpisodes;
  }

  @override
  void update(void Function(SubjectEpisodesBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubjectEpisodes build() {
    _$SubjectEpisodes _$result;
    try {
      _$result = _$v ??
          new _$SubjectEpisodes._(
              subject: _subject?.build(), episodes: episodes.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'subject';
        _subject?.build();
        _$failedField = 'episodes';
        episodes.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SubjectEpisodes', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
