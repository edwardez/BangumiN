// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectSearchResult.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SubjectSearchResult> _$subjectSearchResultSerializer =
    new _$SubjectSearchResultSerializer();

class _$SubjectSearchResultSerializer
    implements StructuredSerializer<SubjectSearchResult> {
  @override
  final Iterable<Type> types = const [
    SubjectSearchResult,
    _$SubjectSearchResult
  ];
  @override
  final String wireName = 'SubjectSearchResult';

  @override
  Iterable serialize(Serializers serializers, SubjectSearchResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'air_date',
      serializers.serialize(object.startDate,
          specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'name_cn',
      serializers.serialize(object.nameCn,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(SearchType)),
    ];
    if (object.rating != null) {
      result
        ..add('rating')
        ..add(serializers.serialize(object.rating,
            specifiedType: const FullType(Rating)));
    }
    if (object.images != null) {
      result
        ..add('images')
        ..add(serializers.serialize(object.images,
            specifiedType: const FullType(Images)));
    }

    return result;
  }

  @override
  SubjectSearchResult deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubjectSearchResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'air_date':
          result.startDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'rating':
          result.rating.replace(serializers.deserialize(value,
              specifiedType: const FullType(Rating)) as Rating);
          break;
        case 'images':
          result.images.replace(serializers.deserialize(value,
              specifiedType: const FullType(Images)) as Images);
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name_cn':
          result.nameCn = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(SearchType)) as SearchType;
          break;
      }
    }

    return result.build();
  }
}

class _$SubjectSearchResult extends SubjectSearchResult {
  @override
  final String startDate;
  @override
  final Rating rating;
  @override
  final Images images;
  @override
  final String name;
  @override
  final String nameCn;
  @override
  final int id;
  @override
  final SearchType type;
  bool __isStartDateValid;

  factory _$SubjectSearchResult([void updates(SubjectSearchResultBuilder b)]) =>
      (new SubjectSearchResultBuilder()..update(updates)).build();

  _$SubjectSearchResult._(
      {this.startDate,
      this.rating,
      this.images,
      this.name,
      this.nameCn,
      this.id,
      this.type})
      : super._() {
    if (startDate == null) {
      throw new BuiltValueNullFieldError('SubjectSearchResult', 'startDate');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('SubjectSearchResult', 'name');
    }
    if (nameCn == null) {
      throw new BuiltValueNullFieldError('SubjectSearchResult', 'nameCn');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('SubjectSearchResult', 'id');
    }
    if (type == null) {
      throw new BuiltValueNullFieldError('SubjectSearchResult', 'type');
    }
  }

  @override
  bool get isStartDateValid => __isStartDateValid ??= super.isStartDateValid;

  @override
  SubjectSearchResult rebuild(void updates(SubjectSearchResultBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  SubjectSearchResultBuilder toBuilder() =>
      new SubjectSearchResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubjectSearchResult &&
        startDate == other.startDate &&
        rating == other.rating &&
        images == other.images &&
        name == other.name &&
        nameCn == other.nameCn &&
        id == other.id &&
        type == other.type;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, startDate.hashCode), rating.hashCode),
                        images.hashCode),
                    name.hashCode),
                nameCn.hashCode),
            id.hashCode),
        type.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubjectSearchResult')
          ..add('startDate', startDate)
          ..add('rating', rating)
          ..add('images', images)
          ..add('name', name)
          ..add('nameCn', nameCn)
          ..add('id', id)
          ..add('type', type))
        .toString();
  }
}

class SubjectSearchResultBuilder
    implements
        Builder<SubjectSearchResult, SubjectSearchResultBuilder>,
        SearchResultBuilder {
  _$SubjectSearchResult _$v;

  String _startDate;
  String get startDate => _$this._startDate;
  set startDate(String startDate) => _$this._startDate = startDate;

  RatingBuilder _rating;
  RatingBuilder get rating => _$this._rating ??= new RatingBuilder();
  set rating(RatingBuilder rating) => _$this._rating = rating;

  ImagesBuilder _images;
  ImagesBuilder get images => _$this._images ??= new ImagesBuilder();
  set images(ImagesBuilder images) => _$this._images = images;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _nameCn;
  String get nameCn => _$this._nameCn;
  set nameCn(String nameCn) => _$this._nameCn = nameCn;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  SearchType _type;
  SearchType get type => _$this._type;
  set type(SearchType type) => _$this._type = type;

  SubjectSearchResultBuilder();

  SubjectSearchResultBuilder get _$this {
    if (_$v != null) {
      _startDate = _$v.startDate;
      _rating = _$v.rating?.toBuilder();
      _images = _$v.images?.toBuilder();
      _name = _$v.name;
      _nameCn = _$v.nameCn;
      _id = _$v.id;
      _type = _$v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant SubjectSearchResult other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubjectSearchResult;
  }

  @override
  void update(void updates(SubjectSearchResultBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$SubjectSearchResult build() {
    _$SubjectSearchResult _$result;
    try {
      _$result = _$v ??
          new _$SubjectSearchResult._(
              startDate: startDate,
              rating: _rating?.build(),
              images: _images?.build(),
              name: name,
              nameCn: nameCn,
              id: id,
              type: type);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'rating';
        _rating?.build();
        _$failedField = 'images';
        _images?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SubjectSearchResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
