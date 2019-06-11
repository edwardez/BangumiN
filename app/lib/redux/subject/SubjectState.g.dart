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
  Iterable serialize(Serializers serializers, SubjectState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'subjectsLoadingStatus',
      serializers.serialize(object.subjectsLoadingStatus,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(int), const FullType(LoadingStatus)])),
      'collections',
      serializers.serialize(object.collections,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(int),
            const FullType(SubjectCollectionInfo)
          ])),
      'collectionsLoadingStatus',
      serializers.serialize(object.collectionsLoadingStatus,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(int), const FullType(LoadingStatus)])),
      'collectionsSubmissionStatus',
      serializers.serialize(object.collectionsSubmissionStatus,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(int), const FullType(LoadingStatus)])),
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
  SubjectState deserialize(Serializers serializers, Iterable serialized,
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
              ])) as BuiltMap);
          break;
        case 'subjectsLoadingStatus':
          result.subjectsLoadingStatus.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(LoadingStatus)
              ])) as BuiltMap);
          break;
        case 'collections':
          result.collections.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(SubjectCollectionInfo)
              ])) as BuiltMap);
          break;
        case 'collectionsLoadingStatus':
          result.collectionsLoadingStatus.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(LoadingStatus)
              ])) as BuiltMap);
          break;
        case 'collectionsSubmissionStatus':
          result.collectionsSubmissionStatus.replace(serializers.deserialize(
              value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(LoadingStatus)
              ])) as BuiltMap);
          break;
        case 'subjectsReviews':
          result.subjectsReviews.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(GetSubjectReviewRequest),
                const FullType(SubjectReviewResponse)
              ])) as BuiltMap);
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
  final BuiltMap<int, LoadingStatus> subjectsLoadingStatus;
  @override
  final BuiltMap<int, SubjectCollectionInfo> collections;
  @override
  final BuiltMap<int, LoadingStatus> collectionsLoadingStatus;
  @override
  final BuiltMap<int, LoadingStatus> collectionsSubmissionStatus;
  @override
  final BuiltMap<GetSubjectReviewRequest, SubjectReviewResponse>
      subjectsReviews;

  factory _$SubjectState([void Function(SubjectStateBuilder) updates]) =>
      (new SubjectStateBuilder()..update(updates)).build();

  _$SubjectState._(
      {this.subjects,
      this.subjectsLoadingStatus,
      this.collections,
      this.collectionsLoadingStatus,
      this.collectionsSubmissionStatus,
      this.subjectsReviews})
      : super._() {
    if (subjectsLoadingStatus == null) {
      throw new BuiltValueNullFieldError(
          'SubjectState', 'subjectsLoadingStatus');
    }
    if (collections == null) {
      throw new BuiltValueNullFieldError('SubjectState', 'collections');
    }
    if (collectionsLoadingStatus == null) {
      throw new BuiltValueNullFieldError(
          'SubjectState', 'collectionsLoadingStatus');
    }
    if (collectionsSubmissionStatus == null) {
      throw new BuiltValueNullFieldError(
          'SubjectState', 'collectionsSubmissionStatus');
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
        subjectsLoadingStatus == other.subjectsLoadingStatus &&
        collections == other.collections &&
        collectionsLoadingStatus == other.collectionsLoadingStatus &&
        collectionsSubmissionStatus == other.collectionsSubmissionStatus &&
        subjectsReviews == other.subjectsReviews;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc(0, subjects.hashCode),
                        subjectsLoadingStatus.hashCode),
                    collections.hashCode),
                collectionsLoadingStatus.hashCode),
            collectionsSubmissionStatus.hashCode),
        subjectsReviews.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubjectState')
          ..add('subjects', subjects)
          ..add('subjectsLoadingStatus', subjectsLoadingStatus)
          ..add('collections', collections)
          ..add('collectionsLoadingStatus', collectionsLoadingStatus)
          ..add('collectionsSubmissionStatus', collectionsSubmissionStatus)
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

  MapBuilder<int, LoadingStatus> _subjectsLoadingStatus;
  MapBuilder<int, LoadingStatus> get subjectsLoadingStatus =>
      _$this._subjectsLoadingStatus ??= new MapBuilder<int, LoadingStatus>();
  set subjectsLoadingStatus(
          MapBuilder<int, LoadingStatus> subjectsLoadingStatus) =>
      _$this._subjectsLoadingStatus = subjectsLoadingStatus;

  MapBuilder<int, SubjectCollectionInfo> _collections;
  MapBuilder<int, SubjectCollectionInfo> get collections =>
      _$this._collections ??= new MapBuilder<int, SubjectCollectionInfo>();
  set collections(MapBuilder<int, SubjectCollectionInfo> collections) =>
      _$this._collections = collections;

  MapBuilder<int, LoadingStatus> _collectionsLoadingStatus;
  MapBuilder<int, LoadingStatus> get collectionsLoadingStatus =>
      _$this._collectionsLoadingStatus ??= new MapBuilder<int, LoadingStatus>();
  set collectionsLoadingStatus(
          MapBuilder<int, LoadingStatus> collectionsLoadingStatus) =>
      _$this._collectionsLoadingStatus = collectionsLoadingStatus;

  MapBuilder<int, LoadingStatus> _collectionsSubmissionStatus;
  MapBuilder<int, LoadingStatus> get collectionsSubmissionStatus =>
      _$this._collectionsSubmissionStatus ??=
          new MapBuilder<int, LoadingStatus>();
  set collectionsSubmissionStatus(
          MapBuilder<int, LoadingStatus> collectionsSubmissionStatus) =>
      _$this._collectionsSubmissionStatus = collectionsSubmissionStatus;

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
      _subjectsLoadingStatus = _$v.subjectsLoadingStatus?.toBuilder();
      _collections = _$v.collections?.toBuilder();
      _collectionsLoadingStatus = _$v.collectionsLoadingStatus?.toBuilder();
      _collectionsSubmissionStatus =
          _$v.collectionsSubmissionStatus?.toBuilder();
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
              subjectsLoadingStatus: subjectsLoadingStatus.build(),
              collections: collections.build(),
              collectionsLoadingStatus: collectionsLoadingStatus.build(),
              collectionsSubmissionStatus: collectionsSubmissionStatus.build(),
              subjectsReviews: subjectsReviews.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'subjects';
        _subjects?.build();
        _$failedField = 'subjectsLoadingStatus';
        subjectsLoadingStatus.build();
        _$failedField = 'collections';
        collections.build();
        _$failedField = 'collectionsLoadingStatus';
        collectionsLoadingStatus.build();
        _$failedField = 'collectionsSubmissionStatus';
        collectionsSubmissionStatus.build();
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
