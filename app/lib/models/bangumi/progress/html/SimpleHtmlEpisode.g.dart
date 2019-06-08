// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SimpleHtmlEpisode.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SimpleHtmlEpisode> _$simpleHtmlEpisodeSerializer =
    new _$SimpleHtmlEpisodeSerializer();

class _$SimpleHtmlEpisodeSerializer
    implements StructuredSerializer<SimpleHtmlEpisode> {
  @override
  final Iterable<Type> types = const [SimpleHtmlEpisode, _$SimpleHtmlEpisode];
  @override
  final String wireName = 'SimpleHtmlEpisode';

  @override
  Iterable serialize(Serializers serializers, SimpleHtmlEpisode object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'episodeInfo',
      serializers.serialize(object.episodeInfo,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'name_cn',
      serializers.serialize(object.nameCn,
          specifiedType: const FullType(String)),
      'status',
      serializers.serialize(object.airStatus,
          specifiedType: const FullType(AirStatus)),
      'user_episode_status',
      serializers.serialize(object.userEpisodeStatus,
          specifiedType: const FullType(EpisodeStatus)),
      'episodeType',
      serializers.serialize(object.episodeType,
          specifiedType: const FullType(EpisodeType)),
    ];

    return result;
  }

  @override
  SimpleHtmlEpisode deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SimpleHtmlEpisodeBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'episodeInfo':
          result.episodeInfo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name_cn':
          result.nameCn = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'status':
          result.airStatus = serializers.deserialize(value,
              specifiedType: const FullType(AirStatus)) as AirStatus;
          break;
        case 'user_episode_status':
          result.userEpisodeStatus = serializers.deserialize(value,
              specifiedType: const FullType(EpisodeStatus)) as EpisodeStatus;
          break;
        case 'episodeType':
          result.episodeType = serializers.deserialize(value,
              specifiedType: const FullType(EpisodeType)) as EpisodeType;
          break;
      }
    }

    return result.build();
  }
}

class _$SimpleHtmlEpisode extends SimpleHtmlEpisode {
  @override
  final String episodeInfo;
  @override
  final int id;
  @override
  final String name;
  @override
  final String nameCn;
  @override
  final AirStatus airStatus;
  @override
  final EpisodeStatus userEpisodeStatus;
  @override
  final EpisodeType episodeType;

  factory _$SimpleHtmlEpisode(
          [void Function(SimpleHtmlEpisodeBuilder) updates]) =>
      (new SimpleHtmlEpisodeBuilder()..update(updates)).build();

  _$SimpleHtmlEpisode._(
      {this.episodeInfo,
      this.id,
      this.name,
      this.nameCn,
      this.airStatus,
      this.userEpisodeStatus,
      this.episodeType})
      : super._() {
    if (episodeInfo == null) {
      throw new BuiltValueNullFieldError('SimpleHtmlEpisode', 'episodeInfo');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('SimpleHtmlEpisode', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('SimpleHtmlEpisode', 'name');
    }
    if (nameCn == null) {
      throw new BuiltValueNullFieldError('SimpleHtmlEpisode', 'nameCn');
    }
    if (airStatus == null) {
      throw new BuiltValueNullFieldError('SimpleHtmlEpisode', 'airStatus');
    }
    if (userEpisodeStatus == null) {
      throw new BuiltValueNullFieldError(
          'SimpleHtmlEpisode', 'userEpisodeStatus');
    }
    if (episodeType == null) {
      throw new BuiltValueNullFieldError('SimpleHtmlEpisode', 'episodeType');
    }
  }

  @override
  SimpleHtmlEpisode rebuild(void Function(SimpleHtmlEpisodeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SimpleHtmlEpisodeBuilder toBuilder() =>
      new SimpleHtmlEpisodeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SimpleHtmlEpisode &&
        episodeInfo == other.episodeInfo &&
        id == other.id &&
        name == other.name &&
        nameCn == other.nameCn &&
        airStatus == other.airStatus &&
        userEpisodeStatus == other.userEpisodeStatus &&
        episodeType == other.episodeType;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, episodeInfo.hashCode), id.hashCode),
                        name.hashCode),
                    nameCn.hashCode),
                airStatus.hashCode),
            userEpisodeStatus.hashCode),
        episodeType.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SimpleHtmlEpisode')
          ..add('episodeInfo', episodeInfo)
          ..add('id', id)
          ..add('name', name)
          ..add('nameCn', nameCn)
          ..add('airStatus', airStatus)
          ..add('userEpisodeStatus', userEpisodeStatus)
          ..add('episodeType', episodeType))
        .toString();
  }
}

class SimpleHtmlEpisodeBuilder
    implements
        Builder<SimpleHtmlEpisode, SimpleHtmlEpisodeBuilder>,
        BaseEpisodeBuilder {
  _$SimpleHtmlEpisode _$v;

  String _episodeInfo;
  String get episodeInfo => _$this._episodeInfo;
  set episodeInfo(String episodeInfo) => _$this._episodeInfo = episodeInfo;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _nameCn;
  String get nameCn => _$this._nameCn;
  set nameCn(String nameCn) => _$this._nameCn = nameCn;

  AirStatus _airStatus;
  AirStatus get airStatus => _$this._airStatus;
  set airStatus(AirStatus airStatus) => _$this._airStatus = airStatus;

  EpisodeStatus _userEpisodeStatus;
  EpisodeStatus get userEpisodeStatus => _$this._userEpisodeStatus;
  set userEpisodeStatus(EpisodeStatus userEpisodeStatus) =>
      _$this._userEpisodeStatus = userEpisodeStatus;

  EpisodeType _episodeType;
  EpisodeType get episodeType => _$this._episodeType;
  set episodeType(EpisodeType episodeType) => _$this._episodeType = episodeType;

  SimpleHtmlEpisodeBuilder();

  SimpleHtmlEpisodeBuilder get _$this {
    if (_$v != null) {
      _episodeInfo = _$v.episodeInfo;
      _id = _$v.id;
      _name = _$v.name;
      _nameCn = _$v.nameCn;
      _airStatus = _$v.airStatus;
      _userEpisodeStatus = _$v.userEpisodeStatus;
      _episodeType = _$v.episodeType;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant SimpleHtmlEpisode other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SimpleHtmlEpisode;
  }

  @override
  void update(void Function(SimpleHtmlEpisodeBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SimpleHtmlEpisode build() {
    final _$result = _$v ??
        new _$SimpleHtmlEpisode._(
            episodeInfo: episodeInfo,
            id: id,
            name: name,
            nameCn: nameCn,
            airStatus: airStatus,
            userEpisodeStatus: userEpisodeStatus,
            episodeType: episodeType);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
