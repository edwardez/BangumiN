// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Actor.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Actor> _$actorSerializer = new _$ActorSerializer();

class _$ActorSerializer implements StructuredSerializer<Actor> {
  @override
  final Iterable<Type> types = const [Actor, _$Actor];
  @override
  final String wireName = 'Actor';

  @override
  Iterable<Object> serialize(Serializers serializers, Actor object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];
    if (object.pageUrl != null) {
      result
        ..add('url')
        ..add(serializers.serialize(object.pageUrl,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Actor deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ActorBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'url':
          result.pageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Actor extends Actor {
  @override
  final int id;
  @override
  final String pageUrl;
  @override
  final String name;

  factory _$Actor([void Function(ActorBuilder) updates]) =>
      (new ActorBuilder()..update(updates)).build();

  _$Actor._({this.id, this.pageUrl, this.name}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Actor', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('Actor', 'name');
    }
  }

  @override
  Actor rebuild(void Function(ActorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ActorBuilder toBuilder() => new ActorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Actor &&
        id == other.id &&
        pageUrl == other.pageUrl &&
        name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, id.hashCode), pageUrl.hashCode), name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Actor')
          ..add('id', id)
          ..add('pageUrl', pageUrl)
          ..add('name', name))
        .toString();
  }
}

class ActorBuilder implements Builder<Actor, ActorBuilder>, MonoBaseBuilder {
  _$Actor _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _pageUrl;
  String get pageUrl => _$this._pageUrl;
  set pageUrl(String pageUrl) => _$this._pageUrl = pageUrl;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  ActorBuilder();

  ActorBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _pageUrl = _$v.pageUrl;
      _name = _$v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant Actor other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Actor;
  }

  @override
  void update(void Function(ActorBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Actor build() {
    final _$result = _$v ?? new _$Actor._(id: id, pageUrl: pageUrl, name: name);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
