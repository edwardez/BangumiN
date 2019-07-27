// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectCollectionInfoPreview.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SubjectCollectionInfoPreview>
    _$subjectCollectionInfoPreviewSerializer =
    new _$SubjectCollectionInfoPreviewSerializer();

class _$SubjectCollectionInfoPreviewSerializer
    implements StructuredSerializer<SubjectCollectionInfoPreview> {
  @override
  final Iterable<Type> types = const [
    SubjectCollectionInfoPreview,
    _$SubjectCollectionInfoPreview
  ];
  @override
  final String wireName = 'SubjectCollectionInfoPreview';

  @override
  Iterable<Object> serialize(
      Serializers serializers, SubjectCollectionInfoPreview object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(CollectionStatus)),
      'score',
      serializers.serialize(object.score, specifiedType: const FullType(int)),
      'comment',
      serializers.serialize(object.comment,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  SubjectCollectionInfoPreview deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubjectCollectionInfoPreviewBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'status':
          result.status = serializers.deserialize(value,
                  specifiedType: const FullType(CollectionStatus))
              as CollectionStatus;
          break;
        case 'score':
          result.score = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'comment':
          result.comment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$SubjectCollectionInfoPreview extends SubjectCollectionInfoPreview {
  @override
  final CollectionStatus status;
  @override
  final int score;
  @override
  final String comment;

  factory _$SubjectCollectionInfoPreview(
          [void Function(SubjectCollectionInfoPreviewBuilder) updates]) =>
      (new SubjectCollectionInfoPreviewBuilder()..update(updates)).build();

  _$SubjectCollectionInfoPreview._({this.status, this.score, this.comment})
      : super._() {
    if (status == null) {
      throw new BuiltValueNullFieldError(
          'SubjectCollectionInfoPreview', 'status');
    }
    if (score == null) {
      throw new BuiltValueNullFieldError(
          'SubjectCollectionInfoPreview', 'score');
    }
    if (comment == null) {
      throw new BuiltValueNullFieldError(
          'SubjectCollectionInfoPreview', 'comment');
    }
  }

  @override
  SubjectCollectionInfoPreview rebuild(
          void Function(SubjectCollectionInfoPreviewBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubjectCollectionInfoPreviewBuilder toBuilder() =>
      new SubjectCollectionInfoPreviewBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubjectCollectionInfoPreview &&
        status == other.status &&
        score == other.score &&
        comment == other.comment;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, status.hashCode), score.hashCode), comment.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubjectCollectionInfoPreview')
          ..add('status', status)
          ..add('score', score)
          ..add('comment', comment))
        .toString();
  }
}

class SubjectCollectionInfoPreviewBuilder
    implements
        Builder<SubjectCollectionInfoPreview,
            SubjectCollectionInfoPreviewBuilder> {
  _$SubjectCollectionInfoPreview _$v;

  CollectionStatus _status;
  CollectionStatus get status => _$this._status;
  set status(CollectionStatus status) => _$this._status = status;

  int _score;
  int get score => _$this._score;
  set score(int score) => _$this._score = score;

  String _comment;
  String get comment => _$this._comment;
  set comment(String comment) => _$this._comment = comment;

  SubjectCollectionInfoPreviewBuilder();

  SubjectCollectionInfoPreviewBuilder get _$this {
    if (_$v != null) {
      _status = _$v.status;
      _score = _$v.score;
      _comment = _$v.comment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubjectCollectionInfoPreview other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubjectCollectionInfoPreview;
  }

  @override
  void update(void Function(SubjectCollectionInfoPreviewBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubjectCollectionInfoPreview build() {
    final _$result = _$v ??
        new _$SubjectCollectionInfoPreview._(
            status: status, score: score, comment: comment);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
