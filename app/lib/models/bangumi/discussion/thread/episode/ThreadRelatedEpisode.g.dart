// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ThreadRelatedEpisode.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ThreadRelatedEpisode> _$threadRelatedEpisodeSerializer =
    new _$ThreadRelatedEpisodeSerializer();

class _$ThreadRelatedEpisodeSerializer
    implements StructuredSerializer<ThreadRelatedEpisode> {
  @override
  final Iterable<Type> types = const [
    ThreadRelatedEpisode,
    _$ThreadRelatedEpisode
  ];
  @override
  final String wireName = 'ThreadRelatedEpisode';

  @override
  Iterable<Object> serialize(
      Serializers serializers, ThreadRelatedEpisode object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'airStatus',
      serializers.serialize(object.airStatus,
          specifiedType: const FullType(AirStatus)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'currentEpisode',
      serializers.serialize(object.currentEpisode,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  ThreadRelatedEpisode deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ThreadRelatedEpisodeBuilder();

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
        case 'airStatus':
          result.airStatus = serializers.deserialize(value,
              specifiedType: const FullType(AirStatus)) as AirStatus;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'currentEpisode':
          result.currentEpisode = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$ThreadRelatedEpisode extends ThreadRelatedEpisode {
  @override
  final int id;
  @override
  final AirStatus airStatus;
  @override
  final String name;
  @override
  final bool currentEpisode;

  factory _$ThreadRelatedEpisode(
          [void Function(ThreadRelatedEpisodeBuilder) updates]) =>
      (new ThreadRelatedEpisodeBuilder()..update(updates)).build();

  _$ThreadRelatedEpisode._(
      {this.id, this.airStatus, this.name, this.currentEpisode})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('ThreadRelatedEpisode', 'id');
    }
    if (airStatus == null) {
      throw new BuiltValueNullFieldError('ThreadRelatedEpisode', 'airStatus');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('ThreadRelatedEpisode', 'name');
    }
    if (currentEpisode == null) {
      throw new BuiltValueNullFieldError(
          'ThreadRelatedEpisode', 'currentEpisode');
    }
  }

  @override
  ThreadRelatedEpisode rebuild(
          void Function(ThreadRelatedEpisodeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ThreadRelatedEpisodeBuilder toBuilder() =>
      new ThreadRelatedEpisodeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ThreadRelatedEpisode &&
        id == other.id &&
        airStatus == other.airStatus &&
        name == other.name &&
        currentEpisode == other.currentEpisode;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, id.hashCode), airStatus.hashCode), name.hashCode),
        currentEpisode.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ThreadRelatedEpisode')
          ..add('id', id)
          ..add('airStatus', airStatus)
          ..add('name', name)
          ..add('currentEpisode', currentEpisode))
        .toString();
  }
}

class ThreadRelatedEpisodeBuilder
    implements Builder<ThreadRelatedEpisode, ThreadRelatedEpisodeBuilder> {
  _$ThreadRelatedEpisode _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  AirStatus _airStatus;
  AirStatus get airStatus => _$this._airStatus;
  set airStatus(AirStatus airStatus) => _$this._airStatus = airStatus;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  bool _currentEpisode;
  bool get currentEpisode => _$this._currentEpisode;
  set currentEpisode(bool currentEpisode) =>
      _$this._currentEpisode = currentEpisode;

  ThreadRelatedEpisodeBuilder();

  ThreadRelatedEpisodeBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _airStatus = _$v.airStatus;
      _name = _$v.name;
      _currentEpisode = _$v.currentEpisode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ThreadRelatedEpisode other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ThreadRelatedEpisode;
  }

  @override
  void update(void Function(ThreadRelatedEpisodeBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ThreadRelatedEpisode build() {
    final _$result = _$v ??
        new _$ThreadRelatedEpisode._(
            id: id,
            airStatus: airStatus,
            name: name,
            currentEpisode: currentEpisode);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
