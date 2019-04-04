// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectCollectionInfo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SubjectCollectionInfo> _$subjectCollectionInfoSerializer =
    new _$SubjectCollectionInfoSerializer();

class _$SubjectCollectionInfoSerializer
    implements StructuredSerializer<SubjectCollectionInfo> {
  @override
  final Iterable<Type> types = const [
    SubjectCollectionInfo,
    _$SubjectCollectionInfo
  ];
  @override
  final String wireName = 'SubjectCollectionInfo';

  @override
  Iterable serialize(Serializers serializers, SubjectCollectionInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(CollectionStatusFromBangumi)),
      'comment',
      serializers.serialize(object.comment,
          specifiedType: const FullType(String)),
      'tag',
      serializers.serialize(object.tags,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'rating',
      serializers.serialize(object.rating, specifiedType: const FullType(int)),
      'private',
      serializers.serialize(object.private, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  SubjectCollectionInfo deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubjectCollectionInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'status':
          result.status.replace(serializers.deserialize(value,
                  specifiedType: const FullType(CollectionStatusFromBangumi))
              as CollectionStatusFromBangumi);
          break;
        case 'comment':
          result.comment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tag':
          result.tags.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList);
          break;
        case 'rating':
          result.rating = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'private':
          result.private = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$SubjectCollectionInfo extends SubjectCollectionInfo {
  @override
  final CollectionStatusFromBangumi status;
  @override
  final String comment;
  @override
  final BuiltList<String> tags;
  @override
  final int rating;
  @override
  final int private;

  factory _$SubjectCollectionInfo(
          [void updates(SubjectCollectionInfoBuilder b)]) =>
      (new SubjectCollectionInfoBuilder()..update(updates)).build();

  _$SubjectCollectionInfo._(
      {this.status, this.comment, this.tags, this.rating, this.private})
      : super._() {
    if (status == null) {
      throw new BuiltValueNullFieldError('SubjectCollectionInfo', 'status');
    }
    if (comment == null) {
      throw new BuiltValueNullFieldError('SubjectCollectionInfo', 'comment');
    }
    if (tags == null) {
      throw new BuiltValueNullFieldError('SubjectCollectionInfo', 'tags');
    }
    if (rating == null) {
      throw new BuiltValueNullFieldError('SubjectCollectionInfo', 'rating');
    }
    if (private == null) {
      throw new BuiltValueNullFieldError('SubjectCollectionInfo', 'private');
    }
  }

  @override
  SubjectCollectionInfo rebuild(void updates(SubjectCollectionInfoBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  SubjectCollectionInfoBuilder toBuilder() =>
      new SubjectCollectionInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubjectCollectionInfo &&
        status == other.status &&
        comment == other.comment &&
        tags == other.tags &&
        rating == other.rating &&
        private == other.private;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, status.hashCode), comment.hashCode), tags.hashCode),
            rating.hashCode),
        private.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubjectCollectionInfo')
          ..add('status', status)
          ..add('comment', comment)
          ..add('tags', tags)
          ..add('rating', rating)
          ..add('private', private))
        .toString();
  }
}

class SubjectCollectionInfoBuilder
    implements Builder<SubjectCollectionInfo, SubjectCollectionInfoBuilder> {
  _$SubjectCollectionInfo _$v;

  CollectionStatusFromBangumiBuilder _status;
  CollectionStatusFromBangumiBuilder get status =>
      _$this._status ??= new CollectionStatusFromBangumiBuilder();
  set status(CollectionStatusFromBangumiBuilder status) =>
      _$this._status = status;

  String _comment;
  String get comment => _$this._comment;
  set comment(String comment) => _$this._comment = comment;

  ListBuilder<String> _tags;
  ListBuilder<String> get tags => _$this._tags ??= new ListBuilder<String>();
  set tags(ListBuilder<String> tags) => _$this._tags = tags;

  int _rating;
  int get rating => _$this._rating;
  set rating(int rating) => _$this._rating = rating;

  int _private;
  int get private => _$this._private;
  set private(int private) => _$this._private = private;

  SubjectCollectionInfoBuilder();

  SubjectCollectionInfoBuilder get _$this {
    if (_$v != null) {
      _status = _$v.status?.toBuilder();
      _comment = _$v.comment;
      _tags = _$v.tags?.toBuilder();
      _rating = _$v.rating;
      _private = _$v.private;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubjectCollectionInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubjectCollectionInfo;
  }

  @override
  void update(void updates(SubjectCollectionInfoBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$SubjectCollectionInfo build() {
    _$SubjectCollectionInfo _$result;
    try {
      _$result = _$v ??
          new _$SubjectCollectionInfo._(
              status: status.build(),
              comment: comment,
              tags: tags.build(),
              rating: rating,
              private: private);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'status';
        status.build();

        _$failedField = 'tags';
        tags.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SubjectCollectionInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
