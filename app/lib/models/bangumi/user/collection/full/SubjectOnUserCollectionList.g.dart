// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectOnUserCollectionList.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SubjectOnUserCollectionList>
    _$subjectOnUserCollectionListSerializer =
    new _$SubjectOnUserCollectionListSerializer();

class _$SubjectOnUserCollectionListSerializer
    implements StructuredSerializer<SubjectOnUserCollectionList> {
  @override
  final Iterable<Type> types = const [
    SubjectOnUserCollectionList,
    _$SubjectOnUserCollectionList
  ];
  @override
  final String wireName = 'SubjectOnUserCollectionList';

  @override
  Iterable serialize(
      Serializers serializers, SubjectOnUserCollectionList object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'additionalInfo',
      serializers.serialize(object.additionalInfo,
          specifiedType: const FullType(String)),
      'cover',
      serializers.serialize(object.cover,
          specifiedType: const FullType(BangumiImage)),
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(SubjectType)),
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
    if (object.chineseName != null) {
      result
        ..add('name_cn')
        ..add(serializers.serialize(object.chineseName,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  SubjectOnUserCollectionList deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubjectOnUserCollectionListBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'additionalInfo':
          result.additionalInfo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'cover':
          result.cover.replace(serializers.deserialize(value,
              specifiedType: const FullType(BangumiImage)) as BangumiImage);
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(SubjectType)) as SubjectType;
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

class _$SubjectOnUserCollectionList extends SubjectOnUserCollectionList {
  @override
  final String additionalInfo;
  @override
  final BangumiImage cover;
  @override
  final SubjectType type;
  @override
  final int id;
  @override
  final String pageUrlFromApi;
  @override
  final String name;
  @override
  final String chineseName;

  factory _$SubjectOnUserCollectionList(
          [void Function(SubjectOnUserCollectionListBuilder) updates]) =>
      (new SubjectOnUserCollectionListBuilder()..update(updates)).build();

  _$SubjectOnUserCollectionList._(
      {this.additionalInfo,
      this.cover,
      this.type,
      this.id,
      this.pageUrlFromApi,
      this.name,
      this.chineseName})
      : super._() {
    if (additionalInfo == null) {
      throw new BuiltValueNullFieldError(
          'SubjectOnUserCollectionList', 'additionalInfo');
    }
    if (cover == null) {
      throw new BuiltValueNullFieldError(
          'SubjectOnUserCollectionList', 'cover');
    }
    if (type == null) {
      throw new BuiltValueNullFieldError('SubjectOnUserCollectionList', 'type');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('SubjectOnUserCollectionList', 'name');
    }
  }

  @override
  SubjectOnUserCollectionList rebuild(
          void Function(SubjectOnUserCollectionListBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubjectOnUserCollectionListBuilder toBuilder() =>
      new SubjectOnUserCollectionListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubjectOnUserCollectionList &&
        additionalInfo == other.additionalInfo &&
        cover == other.cover &&
        type == other.type &&
        id == other.id &&
        pageUrlFromApi == other.pageUrlFromApi &&
        name == other.name &&
        chineseName == other.chineseName;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, additionalInfo.hashCode), cover.hashCode),
                        type.hashCode),
                    id.hashCode),
                pageUrlFromApi.hashCode),
            name.hashCode),
        chineseName.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubjectOnUserCollectionList')
          ..add('additionalInfo', additionalInfo)
          ..add('cover', cover)
          ..add('type', type)
          ..add('id', id)
          ..add('pageUrlFromApi', pageUrlFromApi)
          ..add('name', name)
          ..add('chineseName', chineseName))
        .toString();
  }
}

class SubjectOnUserCollectionListBuilder
    implements
        Builder<SubjectOnUserCollectionList,
            SubjectOnUserCollectionListBuilder>,
        SubjectBaseBuilder {
  _$SubjectOnUserCollectionList _$v;

  String _additionalInfo;
  String get additionalInfo => _$this._additionalInfo;
  set additionalInfo(String additionalInfo) =>
      _$this._additionalInfo = additionalInfo;

  BangumiImageBuilder _cover;
  BangumiImageBuilder get cover => _$this._cover ??= new BangumiImageBuilder();
  set cover(BangumiImageBuilder cover) => _$this._cover = cover;

  SubjectType _type;
  SubjectType get type => _$this._type;
  set type(SubjectType type) => _$this._type = type;

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

  SubjectOnUserCollectionListBuilder();

  SubjectOnUserCollectionListBuilder get _$this {
    if (_$v != null) {
      _additionalInfo = _$v.additionalInfo;
      _cover = _$v.cover?.toBuilder();
      _type = _$v.type;
      _id = _$v.id;
      _pageUrlFromApi = _$v.pageUrlFromApi;
      _name = _$v.name;
      _chineseName = _$v.chineseName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant SubjectOnUserCollectionList other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubjectOnUserCollectionList;
  }

  @override
  void update(void Function(SubjectOnUserCollectionListBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubjectOnUserCollectionList build() {
    _$SubjectOnUserCollectionList _$result;
    try {
      _$result = _$v ??
          new _$SubjectOnUserCollectionList._(
              additionalInfo: additionalInfo,
              cover: cover.build(),
              type: type,
              id: id,
              pageUrlFromApi: pageUrlFromApi,
              name: name,
              chineseName: chineseName);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'cover';
        cover.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SubjectOnUserCollectionList', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
