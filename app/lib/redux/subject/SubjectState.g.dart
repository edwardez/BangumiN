// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectState.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SubjectState> _$subjectStateSerializer =
    new _$SubjectStateSerializer();

class _$SubjectStateSerializer implements StructuredSerializer<SubjectState> {
  @override
  final Iterable<Type> types = const [SubjectState, _$SubjectState];
  @override
  final String wireName = 'SubjectState';

  @override
  Iterable<Object> serialize(Serializers serializers, SubjectState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'collections',
      serializers.serialize(object.collections,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(int),
            const FullType(SubjectCollectionInfo)
          ])),
      'subjectsReviews',
      serializers.serialize(object.subjectsReviews,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(GetSubjectReviewRequest),
            const FullType(SubjectReviewResponse)
          ])),
    ];
    if (object.subjects != null) {
      result
        ..add('subjects')
        ..add(serializers.serialize(object.subjects,
            specifiedType: const FullType(BuiltMap,
                const [const FullType(int), const FullType(BangumiSubject)])));
    }
    return result;
  }

  @override
  SubjectState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubjectStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'subjects':
          result.subjects.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(BangumiSubject)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
        case 'collections':
          result.collections.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(SubjectCollectionInfo)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
        case 'subjectsReviews':
          result.subjectsReviews.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(GetSubjectReviewRequest),
                const FullType(SubjectReviewResponse)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$SubjectState extends SubjectState {
  @override
  final BuiltMap<int, BangumiSubject> subjects;
  @override
  final BuiltMap<int, SubjectCollectionInfo> collections;
  @override
  final BuiltMap<GetSubjectReviewRequest, SubjectReviewResponse>
      subjectsReviews;

  factory _$SubjectState([void Function(SubjectStateBuilder) updates]) =>
      (new SubjectStateBuilder()..update(updates)).build();

  _$SubjectState._({this.subjects, this.collections, this.subjectsReviews})
      : super._() {
    if (collections == null) {
      throw new BuiltValueNullFieldError('SubjectState', 'collections');
    }
    if (subjectsReviews == null) {
      throw new BuiltValueNullFieldError('SubjectState', 'subjectsReviews');
    }
  }

  @override
  SubjectState rebuild(void Function(SubjectStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubjectStateBuilder toBuilder() => new SubjectStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubjectState &&
        subjects == other.subjects &&
        collections == other.collections &&
        subjectsReviews == other.subjectsReviews;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, subjects.hashCode), collections.hashCode),
        subjectsReviews.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubjectState')
          ..add('subjects', subjects)
          ..add('collections', collections)
          ..add('subjectsReviews', subjectsReviews))
        .toString();
  }
}

class SubjectStateBuilder
    implements Builder<SubjectState, SubjectStateBuilder> {
  _$SubjectState _$v;

  MapBuilder<int, BangumiSubject> _subjects;
  MapBuilder<int, BangumiSubject> get subjects =>
      _$this._subjects ??= new MapBuilder<int, BangumiSubject>();
  set subjects(MapBuilder<int, BangumiSubject> subjects) =>
      _$this._subjects = subjects;

  MapBuilder<int, SubjectCollectionInfo> _collections;
  MapBuilder<int, SubjectCollectionInfo> get collections =>
      _$this._collections ??= new MapBuilder<int, SubjectCollectionInfo>();
  set collections(MapBuilder<int, SubjectCollectionInfo> collections) =>
      _$this._collections = collections;

  MapBuilder<GetSubjectReviewRequest, SubjectReviewResponse> _subjectsReviews;
  MapBuilder<GetSubjectReviewRequest, SubjectReviewResponse>
      get subjectsReviews => _$this._subjectsReviews ??=
          new MapBuilder<GetSubjectReviewRequest, SubjectReviewResponse>();
  set subjectsReviews(
          MapBuilder<GetSubjectReviewRequest, SubjectReviewResponse>
              subjectsReviews) =>
      _$this._subjectsReviews = subjectsReviews;

  SubjectStateBuilder();

  SubjectStateBuilder get _$this {
    if (_$v != null) {
      _subjects = _$v.subjects?.toBuilder();
      _collections = _$v.collections?.toBuilder();
      _subjectsReviews = _$v.subjectsReviews?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubjectState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubjectState;
  }

  @override
  void update(void Function(SubjectStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubjectState build() {
    _$SubjectState _$result;
    try {
      _$result = _$v ??
          new _$SubjectState._(
              subjects: _subjects?.build(),
              collections: collections.build(),
              subjectsReviews: subjectsReviews.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'subjects';
        _subjects?.build();
        _$failedField = 'collections';
        collections.build();
        _$failedField = 'subjectsReviews';
        subjectsReviews.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SubjectState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
