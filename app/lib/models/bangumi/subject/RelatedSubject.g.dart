// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RelatedSubject.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<RelatedSubject> _$relatedSubjectSerializer =
    new _$RelatedSubjectSerializer();

class _$RelatedSubjectSerializer
    implements StructuredSerializer<RelatedSubject> {
  @override
  final Iterable<Type> types = const [RelatedSubject, _$RelatedSubject];
  @override
  final String wireName = 'RelatedSubject';

  @override
  Iterable serialize(Serializers serializers, RelatedSubject object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'subjectSubTypeName',
      serializers.serialize(object.subjectSubTypeName,
          specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];
    if (object.cover != null) {
      result
        ..add('cover')
        ..add(serializers.serialize(object.cover,
            specifiedType: const FullType(BangumiImage)));
    }
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    if (object.pageUrlFromApi != null) {
      result
        ..add('url')
        ..add(serializers.serialize(object.pageUrlFromApi,
            specifiedType: const FullType(String)));
    }
    if (object.nameCn != null) {
      result
        ..add('name_cn')
        ..add(serializers.serialize(object.nameCn,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  RelatedSubject deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RelatedSubjectBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'subjectSubTypeName':
          result.subjectSubTypeName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'cover':
          result.cover.replace(serializers.deserialize(value,
              specifiedType: const FullType(BangumiImage)) as BangumiImage);
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'url':
          result.pageUrlFromApi = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name_cn':
          result.nameCn = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$RelatedSubject extends RelatedSubject {
  @override
  final String subjectSubTypeName;
  @override
  final BangumiImage cover;
  @override
  final int id;
  @override
  final String pageUrlFromApi;
  @override
  final String name;
  @override
  final String nameCn;

  factory _$RelatedSubject([void Function(RelatedSubjectBuilder) updates]) =>
      (new RelatedSubjectBuilder()..update(updates)).build();

  _$RelatedSubject._(
      {this.subjectSubTypeName,
      this.cover,
      this.id,
      this.pageUrlFromApi,
      this.name,
      this.nameCn})
      : super._() {
    if (subjectSubTypeName == null) {
      throw new BuiltValueNullFieldError(
          'RelatedSubject', 'subjectSubTypeName');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('RelatedSubject', 'name');
    }
  }

  @override
  RelatedSubject rebuild(void Function(RelatedSubjectBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RelatedSubjectBuilder toBuilder() =>
      new RelatedSubjectBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RelatedSubject &&
        subjectSubTypeName == other.subjectSubTypeName &&
        cover == other.cover &&
        id == other.id &&
        pageUrlFromApi == other.pageUrlFromApi &&
        name == other.name &&
        nameCn == other.nameCn;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, subjectSubTypeName.hashCode), cover.hashCode),
                    id.hashCode),
                pageUrlFromApi.hashCode),
            name.hashCode),
        nameCn.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RelatedSubject')
          ..add('subjectSubTypeName', subjectSubTypeName)
          ..add('cover', cover)
          ..add('id', id)
          ..add('pageUrlFromApi', pageUrlFromApi)
          ..add('name', name)
          ..add('nameCn', nameCn))
        .toString();
  }
}

class RelatedSubjectBuilder
    implements
        Builder<RelatedSubject, RelatedSubjectBuilder>,
        SubjectBaseBuilder {
  _$RelatedSubject _$v;

  String _subjectSubTypeName;
  String get subjectSubTypeName => _$this._subjectSubTypeName;
  set subjectSubTypeName(String subjectSubTypeName) =>
      _$this._subjectSubTypeName = subjectSubTypeName;

  BangumiImageBuilder _cover;
  BangumiImageBuilder get cover => _$this._cover ??= new BangumiImageBuilder();
  set cover(BangumiImageBuilder cover) => _$this._cover = cover;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _pageUrlFromApi;
  String get pageUrlFromApi => _$this._pageUrlFromApi;
  set pageUrlFromApi(String pageUrlFromApi) =>
      _$this._pageUrlFromApi = pageUrlFromApi;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _nameCn;
  String get nameCn => _$this._nameCn;
  set nameCn(String nameCn) => _$this._nameCn = nameCn;

  RelatedSubjectBuilder();

  RelatedSubjectBuilder get _$this {
    if (_$v != null) {
      _subjectSubTypeName = _$v.subjectSubTypeName;
      _cover = _$v.cover?.toBuilder();
      _id = _$v.id;
      _pageUrlFromApi = _$v.pageUrlFromApi;
      _name = _$v.name;
      _nameCn = _$v.nameCn;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant RelatedSubject other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$RelatedSubject;
  }

  @override
  void update(void Function(RelatedSubjectBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$RelatedSubject build() {
    _$RelatedSubject _$result;
    try {
      _$result = _$v ??
          new _$RelatedSubject._(
              subjectSubTypeName: subjectSubTypeName,
              cover: _cover?.build(),
              id: id,
              pageUrlFromApi: pageUrlFromApi,
              name: name,
              nameCn: nameCn);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'cover';
        _cover?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'RelatedSubject', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
