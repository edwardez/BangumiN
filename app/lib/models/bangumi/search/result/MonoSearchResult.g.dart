// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MonoSearchResult.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<MonoSearchResult> _$monoSearchResultSerializer =
    new _$MonoSearchResultSerializer();

class _$MonoSearchResultSerializer
    implements StructuredSerializer<MonoSearchResult> {
  @override
  final Iterable<Type> types = const [MonoSearchResult, _$MonoSearchResult];
  @override
  final String wireName = 'MonoSearchResult';

  @override
  Iterable serialize(Serializers serializers, MonoSearchResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'miscInfo',
      serializers.serialize(object.miscInfo,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'name_cn',
      serializers.serialize(object.nameCn,
          specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(SearchType)),
    ];
    if (object.images != null) {
      result
        ..add('images')
        ..add(serializers.serialize(object.images,
            specifiedType: const FullType(Images)));
    }

    return result;
  }

  @override
  MonoSearchResult deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MonoSearchResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'miscInfo':
          result.miscInfo.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList);
          break;
        case 'name_cn':
          result.nameCn = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'images':
          result.images.replace(serializers.deserialize(value,
              specifiedType: const FullType(Images)) as Images);
          break;
        case 'name':
          result.name = serializers.deserialize(value,
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

class _$MonoSearchResult extends MonoSearchResult {
  @override
  final BuiltList<String> miscInfo;
  @override
  final String nameCn;
  @override
  final Images images;
  @override
  final String name;
  @override
  final int id;
  @override
  final SearchType type;

  factory _$MonoSearchResult([void updates(MonoSearchResultBuilder b)]) =>
      (new MonoSearchResultBuilder()..update(updates)).build();

  _$MonoSearchResult._(
      {this.miscInfo, this.nameCn, this.images, this.name, this.id, this.type})
      : super._() {
    if (miscInfo == null) {
      throw new BuiltValueNullFieldError('MonoSearchResult', 'miscInfo');
    }
    if (nameCn == null) {
      throw new BuiltValueNullFieldError('MonoSearchResult', 'nameCn');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('MonoSearchResult', 'name');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('MonoSearchResult', 'id');
    }
    if (type == null) {
      throw new BuiltValueNullFieldError('MonoSearchResult', 'type');
    }
  }

  @override
  MonoSearchResult rebuild(void updates(MonoSearchResultBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  MonoSearchResultBuilder toBuilder() =>
      new MonoSearchResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MonoSearchResult &&
        miscInfo == other.miscInfo &&
        nameCn == other.nameCn &&
        images == other.images &&
        name == other.name &&
        id == other.id &&
        type == other.type;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, miscInfo.hashCode), nameCn.hashCode),
                    images.hashCode),
                name.hashCode),
            id.hashCode),
        type.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MonoSearchResult')
          ..add('miscInfo', miscInfo)..add('nameCn', nameCn)
          ..add('images', images)
          ..add('name', name)
          ..add('id', id)
          ..add('type', type))
        .toString();
  }
}

class MonoSearchResultBuilder
    implements
        Builder<MonoSearchResult, MonoSearchResultBuilder>,
        SearchResultBuilder {
  _$MonoSearchResult _$v;

  ListBuilder<String> _miscInfo;
  ListBuilder<String> get miscInfo =>
      _$this._miscInfo ??= new ListBuilder<String>();
  set miscInfo(ListBuilder<String> miscInfo) => _$this._miscInfo = miscInfo;

  String _nameCn;

  String get nameCn => _$this._nameCn;

  set nameCn(String nameCn) => _$this._nameCn = nameCn;

  ImagesBuilder _images;
  ImagesBuilder get images => _$this._images ??= new ImagesBuilder();
  set images(ImagesBuilder images) => _$this._images = images;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  SearchType _type;
  SearchType get type => _$this._type;
  set type(SearchType type) => _$this._type = type;

  MonoSearchResultBuilder();

  MonoSearchResultBuilder get _$this {
    if (_$v != null) {
      _miscInfo = _$v.miscInfo?.toBuilder();
      _nameCn = _$v.nameCn;
      _images = _$v.images?.toBuilder();
      _name = _$v.name;
      _id = _$v.id;
      _type = _$v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant MonoSearchResult other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MonoSearchResult;
  }

  @override
  void update(void updates(MonoSearchResultBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$MonoSearchResult build() {
    _$MonoSearchResult _$result;
    try {
      _$result = _$v ??
          new _$MonoSearchResult._(
              miscInfo: miscInfo.build(),
              nameCn: nameCn,
              images: _images?.build(),
              name: name,
              id: id,
              type: type);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'miscInfo';
        miscInfo.build();

        _$failedField = 'images';
        _images?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'MonoSearchResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
