// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserSearchResult.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserSearchResult> _$userSearchResultSerializer =
    new _$UserSearchResultSerializer();

class _$UserSearchResultSerializer
    implements StructuredSerializer<UserSearchResult> {
  @override
  final Iterable<Type> types = const [UserSearchResult, _$UserSearchResult];
  @override
  final String wireName = 'UserSearchResult';

  @override
  Iterable serialize(Serializers serializers, UserSearchResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(SearchType)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'name_cn',
      serializers.serialize(object.nameCn,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
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
  UserSearchResult deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserSearchResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(SearchType)) as SearchType;
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
      }
    }

    return result.build();
  }
}

class _$UserSearchResult extends UserSearchResult {
  @override
  final SearchType type;
  @override
  final Images images;
  @override
  final String name;
  @override
  final String nameCn;
  @override
  final int id;

  factory _$UserSearchResult([void updates(UserSearchResultBuilder b)]) =>
      (new UserSearchResultBuilder()..update(updates)).build();

  _$UserSearchResult._(
      {this.type, this.images, this.name, this.nameCn, this.id})
      : super._() {
    if (type == null) {
      throw new BuiltValueNullFieldError('UserSearchResult', 'type');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('UserSearchResult', 'name');
    }
    if (nameCn == null) {
      throw new BuiltValueNullFieldError('UserSearchResult', 'nameCn');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('UserSearchResult', 'id');
    }
  }

  @override
  UserSearchResult rebuild(void updates(UserSearchResultBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  UserSearchResultBuilder toBuilder() =>
      new UserSearchResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserSearchResult &&
        type == other.type &&
        images == other.images &&
        name == other.name &&
        nameCn == other.nameCn &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, type.hashCode), images.hashCode), name.hashCode),
            nameCn.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserSearchResult')
          ..add('type', type)
          ..add('images', images)
          ..add('name', name)
          ..add('nameCn', nameCn)
          ..add('id', id))
        .toString();
  }
}

class UserSearchResultBuilder
    implements
        Builder<UserSearchResult, UserSearchResultBuilder>,
        SearchResultBuilder {
  _$UserSearchResult _$v;

  SearchType _type;

  SearchType get type => _$this._type;

  set type(SearchType type) => _$this._type = type;

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

  UserSearchResultBuilder();

  UserSearchResultBuilder get _$this {
    if (_$v != null) {
      _type = _$v.type;
      _images = _$v.images?.toBuilder();
      _name = _$v.name;
      _nameCn = _$v.nameCn;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant UserSearchResult other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserSearchResult;
  }

  @override
  void update(void updates(UserSearchResultBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$UserSearchResult build() {
    _$UserSearchResult _$result;
    try {
      _$result = _$v ??
          new _$UserSearchResult._(
              type: type,
              images: _images?.build(),
              name: name,
              nameCn: nameCn,
              id: id);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'images';
        _images?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserSearchResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
