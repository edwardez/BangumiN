// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ThreadParentSubject.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ThreadParentSubject> _$threadParentSubjectSerializer =
    new _$ThreadParentSubjectSerializer();

class _$ThreadParentSubjectSerializer
    implements StructuredSerializer<ThreadParentSubject> {
  @override
  final Iterable<Type> types = const [
    ThreadParentSubject,
    _$ThreadParentSubject
  ];
  @override
  final String wireName = 'ThreadParentSubject';

  @override
  Iterable serialize(Serializers serializers, ThreadParentSubject object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'cover',
      serializers.serialize(object.cover,
          specifiedType: const FullType(BangumiImage)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];
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
  ThreadParentSubject deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ThreadParentSubjectBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
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

class _$ThreadParentSubject extends ThreadParentSubject {
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

  factory _$ThreadParentSubject(
          [void Function(ThreadParentSubjectBuilder) updates]) =>
      (new ThreadParentSubjectBuilder()..update(updates)).build();

  _$ThreadParentSubject._(
      {this.cover, this.id, this.pageUrlFromApi, this.name, this.nameCn})
      : super._() {
    if (cover == null) {
      throw new BuiltValueNullFieldError('ThreadParentSubject', 'cover');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('ThreadParentSubject', 'name');
    }
  }

  @override
  ThreadParentSubject rebuild(
          void Function(ThreadParentSubjectBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ThreadParentSubjectBuilder toBuilder() =>
      new ThreadParentSubjectBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ThreadParentSubject &&
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
            $jc($jc($jc(0, cover.hashCode), id.hashCode),
                pageUrlFromApi.hashCode),
            name.hashCode),
        nameCn.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ThreadParentSubject')
          ..add('cover', cover)
          ..add('id', id)
          ..add('pageUrlFromApi', pageUrlFromApi)
          ..add('name', name)
          ..add('nameCn', nameCn))
        .toString();
  }
}

class ThreadParentSubjectBuilder
    implements
        Builder<ThreadParentSubject, ThreadParentSubjectBuilder>,
        SubjectBaseBuilder {
  _$ThreadParentSubject _$v;

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

  ThreadParentSubjectBuilder();

  ThreadParentSubjectBuilder get _$this {
    if (_$v != null) {
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
  void replace(covariant ThreadParentSubject other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ThreadParentSubject;
  }

  @override
  void update(void Function(ThreadParentSubjectBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ThreadParentSubject build() {
    _$ThreadParentSubject _$result;
    try {
      _$result = _$v ??
          new _$ThreadParentSubject._(
              cover: cover.build(),
              id: id,
              pageUrlFromApi: pageUrlFromApi,
              name: name,
              nameCn: nameCn);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'cover';
        cover.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ThreadParentSubject', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
