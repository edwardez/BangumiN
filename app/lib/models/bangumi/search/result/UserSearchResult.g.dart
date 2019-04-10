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
      'nickname',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(SearchType)),
    ];
    if (object.images != null) {
      result..add('avatar')
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
        case 'avatar':
          result.images.replace(serializers.deserialize(value,
              specifiedType: const FullType(Images)) as Images);
          break;
        case 'nickname':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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

class _$UserSearchResult extends UserSearchResult {
  @override
  final Images images;
  @override
  final String name;
  @override
  final int id;
  @override
  final String username;
  @override
  final SearchType type;

  factory _$UserSearchResult([void updates(UserSearchResultBuilder b)]) =>
      (new UserSearchResultBuilder()..update(updates)).build();

  _$UserSearchResult._(
      {this.images, this.name, this.id, this.username, this.type})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('UserSearchResult', 'name');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('UserSearchResult', 'id');
    }
    if (username == null) {
      throw new BuiltValueNullFieldError('UserSearchResult', 'username');
    }
    if (type == null) {
      throw new BuiltValueNullFieldError('UserSearchResult', 'type');
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
        images == other.images &&
        name == other.name &&
        id == other.id &&
        username == other.username &&
        type == other.type;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, images.hashCode), name.hashCode), id.hashCode),
            username.hashCode),
        type.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserSearchResult')
          ..add('images', images)
          ..add('name', name)..add('id', id)..add('username', username)..add(
          'type', type))
        .toString();
  }
}

class UserSearchResultBuilder
    implements
        Builder<UserSearchResult, UserSearchResultBuilder>,
        SearchResultBuilder {
  _$UserSearchResult _$v;

  ImagesBuilder _images;
  ImagesBuilder get images => _$this._images ??= new ImagesBuilder();
  set images(ImagesBuilder images) => _$this._images = images;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _username;

  String get username => _$this._username;

  set username(String username) => _$this._username = username;

  SearchType _type;

  SearchType get type => _$this._type;

  set type(SearchType type) => _$this._type = type;

  UserSearchResultBuilder();

  UserSearchResultBuilder get _$this {
    if (_$v != null) {
      _images = _$v.images?.toBuilder();
      _name = _$v.name;
      _id = _$v.id;
      _username = _$v.username;
      _type = _$v.type;
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
              images: _images?.build(),
              name: name,
              id: id,
              username: username,
              type: type);
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
