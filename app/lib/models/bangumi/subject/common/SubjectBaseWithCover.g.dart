// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectBaseWithCover.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SubjectBaseWithCover> _$subjectBaseWithCoverSerializer =
    new _$SubjectBaseWithCoverSerializer();

class _$SubjectBaseWithCoverSerializer
    implements StructuredSerializer<SubjectBaseWithCover> {
  @override
  final Iterable<Type> types = const [
    SubjectBaseWithCover,
    _$SubjectBaseWithCover
  ];
  @override
  final String wireName = 'SubjectBaseWithCover';

  @override
  Iterable serialize(Serializers serializers, SubjectBaseWithCover object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
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
    if (object.chineseName != null) {
      result
        ..add('name_cn')
        ..add(serializers.serialize(object.chineseName,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  SubjectBaseWithCover deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubjectBaseWithCoverBuilder();

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
          result.chineseName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$SubjectBaseWithCover extends SubjectBaseWithCover {
  @override
  final BangumiImage cover;
  @override
  final int id;
  @override
  final String pageUrlFromApi;
  @override
  final String name;
  @override
  final String chineseName;

  factory _$SubjectBaseWithCover(
          [void Function(SubjectBaseWithCoverBuilder) updates]) =>
      (new SubjectBaseWithCoverBuilder()..update(updates)).build();

  _$SubjectBaseWithCover._(
      {this.cover, this.id, this.pageUrlFromApi, this.name, this.chineseName})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('SubjectBaseWithCover', 'name');
    }
  }

  @override
  SubjectBaseWithCover rebuild(
          void Function(SubjectBaseWithCoverBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubjectBaseWithCoverBuilder toBuilder() =>
      new SubjectBaseWithCoverBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubjectBaseWithCover &&
        cover == other.cover &&
        id == other.id &&
        pageUrlFromApi == other.pageUrlFromApi &&
        name == other.name &&
        chineseName == other.chineseName;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, cover.hashCode), id.hashCode),
                pageUrlFromApi.hashCode),
            name.hashCode),
        chineseName.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubjectBaseWithCover')
          ..add('cover', cover)
          ..add('id', id)
          ..add('pageUrlFromApi', pageUrlFromApi)
          ..add('name', name)
          ..add('chineseName', chineseName))
        .toString();
  }
}

class SubjectBaseWithCoverBuilder
    implements
        Builder<SubjectBaseWithCover, SubjectBaseWithCoverBuilder>,
        SubjectBaseBuilder {
  _$SubjectBaseWithCover _$v;

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

  String _chineseName;
  String get chineseName => _$this._chineseName;
  set chineseName(String chineseName) => _$this._chineseName = chineseName;

  SubjectBaseWithCoverBuilder();

  SubjectBaseWithCoverBuilder get _$this {
    if (_$v != null) {
      _cover = _$v.cover?.toBuilder();
      _id = _$v.id;
      _pageUrlFromApi = _$v.pageUrlFromApi;
      _name = _$v.name;
      _chineseName = _$v.chineseName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant SubjectBaseWithCover other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubjectBaseWithCover;
  }

  @override
  void update(void Function(SubjectBaseWithCoverBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubjectBaseWithCover build() {
    _$SubjectBaseWithCover _$result;
    try {
      _$result = _$v ??
          new _$SubjectBaseWithCover._(
              cover: _cover?.build(),
              id: id,
              pageUrlFromApi: pageUrlFromApi,
              name: name,
              chineseName: chineseName);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'cover';
        _cover?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SubjectBaseWithCover', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
