// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserSearchResultItem.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserSearchResultItem> _$userSearchResultItemSerializer =
    new _$UserSearchResultItemSerializer();

class _$UserSearchResultItemSerializer
    implements StructuredSerializer<UserSearchResultItem> {
  @override
  final Iterable<Type> types = const [
    UserSearchResultItem,
    _$UserSearchResultItem
  ];
  @override
  final String wireName = 'UserSearchResultItem';

  @override
  Iterable serialize(Serializers serializers, UserSearchResultItem object,
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
    if (object.image != null) {
      result
        ..add('avatar')
        ..add(serializers.serialize(object.image,
            specifiedType: const FullType(BangumiImage)));
    }
    return result;
  }

  @override
  UserSearchResultItem deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserSearchResultItemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'avatar':
          result.image.replace(serializers.deserialize(value,
              specifiedType: const FullType(BangumiImage)) as BangumiImage);
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

class _$UserSearchResultItem extends UserSearchResultItem {
  @override
  final BangumiImage image;
  @override
  final String name;
  @override
  final int id;
  @override
  final String username;
  @override
  final SearchType type;

  factory _$UserSearchResultItem(
          [void Function(UserSearchResultItemBuilder) updates]) =>
      (new UserSearchResultItemBuilder()..update(updates)).build();

  _$UserSearchResultItem._(
      {this.image, this.name, this.id, this.username, this.type})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('UserSearchResultItem', 'name');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('UserSearchResultItem', 'id');
    }
    if (username == null) {
      throw new BuiltValueNullFieldError('UserSearchResultItem', 'username');
    }
    if (type == null) {
      throw new BuiltValueNullFieldError('UserSearchResultItem', 'type');
    }
  }

  @override
  UserSearchResultItem rebuild(
          void Function(UserSearchResultItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserSearchResultItemBuilder toBuilder() =>
      new UserSearchResultItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserSearchResultItem &&
        image == other.image &&
        name == other.name &&
        id == other.id &&
        username == other.username &&
        type == other.type;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, image.hashCode), name.hashCode), id.hashCode),
            username.hashCode),
        type.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserSearchResultItem')
          ..add('image', image)
          ..add('name', name)
          ..add('id', id)
          ..add('username', username)
          ..add('type', type))
        .toString();
  }
}

class UserSearchResultItemBuilder
    implements
        Builder<UserSearchResultItem, UserSearchResultItemBuilder>,
        SearchResultItemBuilder {
  _$UserSearchResultItem _$v;

  BangumiImageBuilder _image;
  BangumiImageBuilder get image => _$this._image ??= new BangumiImageBuilder();
  set image(BangumiImageBuilder image) => _$this._image = image;

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

  UserSearchResultItemBuilder();

  UserSearchResultItemBuilder get _$this {
    if (_$v != null) {
      _image = _$v.image?.toBuilder();
      _name = _$v.name;
      _id = _$v.id;
      _username = _$v.username;
      _type = _$v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant UserSearchResultItem other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserSearchResultItem;
  }

  @override
  void update(void Function(UserSearchResultItemBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserSearchResultItem build() {
    _$UserSearchResultItem _$result;
    try {
      _$result = _$v ??
          new _$UserSearchResultItem._(
              image: _image?.build(),
              name: name,
              id: id,
              username: username,
              type: type);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'image';
        _image?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserSearchResultItem', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
