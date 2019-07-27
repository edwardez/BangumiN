// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserCollectionTag.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserCollectionTag> _$userCollectionTagSerializer =
    new _$UserCollectionTagSerializer();

class _$UserCollectionTagSerializer
    implements StructuredSerializer<UserCollectionTag> {
  @override
  final Iterable<Type> types = const [UserCollectionTag, _$UserCollectionTag];
  @override
  final String wireName = 'UserCollectionTag';

  @override
  Iterable<Object> serialize(Serializers serializers, UserCollectionTag object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'taggedSubjectsCount',
      serializers.serialize(object.taggedSubjectsCount,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  UserCollectionTag deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserCollectionTagBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'taggedSubjectsCount':
          result.taggedSubjectsCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$UserCollectionTag extends UserCollectionTag {
  @override
  final String name;
  @override
  final int taggedSubjectsCount;

  factory _$UserCollectionTag(
          [void Function(UserCollectionTagBuilder) updates]) =>
      (new UserCollectionTagBuilder()..update(updates)).build();

  _$UserCollectionTag._({this.name, this.taggedSubjectsCount}) : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('UserCollectionTag', 'name');
    }
    if (taggedSubjectsCount == null) {
      throw new BuiltValueNullFieldError(
          'UserCollectionTag', 'taggedSubjectsCount');
    }
  }

  @override
  UserCollectionTag rebuild(void Function(UserCollectionTagBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserCollectionTagBuilder toBuilder() =>
      new UserCollectionTagBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserCollectionTag &&
        name == other.name &&
        taggedSubjectsCount == other.taggedSubjectsCount;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, name.hashCode), taggedSubjectsCount.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserCollectionTag')
          ..add('name', name)
          ..add('taggedSubjectsCount', taggedSubjectsCount))
        .toString();
  }
}

class UserCollectionTagBuilder
    implements Builder<UserCollectionTag, UserCollectionTagBuilder> {
  _$UserCollectionTag _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  int _taggedSubjectsCount;
  int get taggedSubjectsCount => _$this._taggedSubjectsCount;
  set taggedSubjectsCount(int taggedSubjectsCount) =>
      _$this._taggedSubjectsCount = taggedSubjectsCount;

  UserCollectionTagBuilder();

  UserCollectionTagBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _taggedSubjectsCount = _$v.taggedSubjectsCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserCollectionTag other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserCollectionTag;
  }

  @override
  void update(void Function(UserCollectionTagBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserCollectionTag build() {
    final _$result = _$v ??
        new _$UserCollectionTag._(
            name: name, taggedSubjectsCount: taggedSubjectsCount);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
