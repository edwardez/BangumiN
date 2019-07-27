// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SimpleHtmlBasedEpisode.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SimpleHtmlBasedEpisode> _$simpleHtmlBasedEpisodeSerializer =
    new _$SimpleHtmlBasedEpisodeSerializer();

class _$SimpleHtmlBasedEpisodeSerializer
    implements StructuredSerializer<SimpleHtmlBasedEpisode> {
  @override
  final Iterable<Type> types = const [
    SimpleHtmlBasedEpisode,
    _$SimpleHtmlBasedEpisode
  ];
  @override
  final String wireName = 'SimpleHtmlBasedEpisode';

  @override
  Iterable<Object> serialize(
      Serializers serializers, SimpleHtmlBasedEpisode object,
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
      serializers.serialize(object.chineseName,
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
  SimpleHtmlBasedEpisode deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SimpleHtmlBasedEpisodeBuilder();

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
          result.chineseName = serializers.deserialize(value,
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

class _$SimpleHtmlBasedEpisode extends SimpleHtmlBasedEpisode {
  @override
  final String episodeInfo;
  @override
  final int id;
  @override
  final String name;
  @override
  final String chineseName;
  @override
  final AirStatus airStatus;
  @override
  final EpisodeStatus userEpisodeStatus;
  @override
  final EpisodeType episodeType;

  factory _$SimpleHtmlBasedEpisode(
          [void Function(SimpleHtmlBasedEpisodeBuilder) updates]) =>
      (new SimpleHtmlBasedEpisodeBuilder()..update(updates)).build();

  _$SimpleHtmlBasedEpisode._(
      {this.episodeInfo,
      this.id,
      this.name,
      this.chineseName,
      this.airStatus,
      this.userEpisodeStatus,
      this.episodeType})
      : super._() {
    if (episodeInfo == null) {
      throw new BuiltValueNullFieldError(
          'SimpleHtmlBasedEpisode', 'episodeInfo');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('SimpleHtmlBasedEpisode', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('SimpleHtmlBasedEpisode', 'name');
    }
    if (chineseName == null) {
      throw new BuiltValueNullFieldError(
          'SimpleHtmlBasedEpisode', 'chineseName');
    }
    if (airStatus == null) {
      throw new BuiltValueNullFieldError('SimpleHtmlBasedEpisode', 'airStatus');
    }
    if (userEpisodeStatus == null) {
      throw new BuiltValueNullFieldError(
          'SimpleHtmlBasedEpisode', 'userEpisodeStatus');
    }
    if (episodeType == null) {
      throw new BuiltValueNullFieldError(
          'SimpleHtmlBasedEpisode', 'episodeType');
    }
  }

  @override
  SimpleHtmlBasedEpisode rebuild(
          void Function(SimpleHtmlBasedEpisodeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SimpleHtmlBasedEpisodeBuilder toBuilder() =>
      new SimpleHtmlBasedEpisodeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SimpleHtmlBasedEpisode &&
        episodeInfo == other.episodeInfo &&
        id == other.id &&
        name == other.name &&
        chineseName == other.chineseName &&
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
                    chineseName.hashCode),
                airStatus.hashCode),
            userEpisodeStatus.hashCode),
        episodeType.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SimpleHtmlBasedEpisode')
          ..add('episodeInfo', episodeInfo)
          ..add('id', id)
          ..add('name', name)
          ..add('chineseName', chineseName)
          ..add('airStatus', airStatus)
          ..add('userEpisodeStatus', userEpisodeStatus)
          ..add('episodeType', episodeType))
        .toString();
  }
}

class SimpleHtmlBasedEpisodeBuilder
    implements
        Builder<SimpleHtmlBasedEpisode, SimpleHtmlBasedEpisodeBuilder>,
        BaseEpisodeBuilder {
  _$SimpleHtmlBasedEpisode _$v;

  String _episodeInfo;
  String get episodeInfo => _$this._episodeInfo;
  set episodeInfo(String episodeInfo) => _$this._episodeInfo = episodeInfo;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _chineseName;
  String get chineseName => _$this._chineseName;
  set chineseName(String chineseName) => _$this._chineseName = chineseName;

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

  SimpleHtmlBasedEpisodeBuilder();

  SimpleHtmlBasedEpisodeBuilder get _$this {
    if (_$v != null) {
      _episodeInfo = _$v.episodeInfo;
      _id = _$v.id;
      _name = _$v.name;
      _chineseName = _$v.chineseName;
      _airStatus = _$v.airStatus;
      _userEpisodeStatus = _$v.userEpisodeStatus;
      _episodeType = _$v.episodeType;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant SimpleHtmlBasedEpisode other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SimpleHtmlBasedEpisode;
  }

  @override
  void update(void Function(SimpleHtmlBasedEpisodeBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SimpleHtmlBasedEpisode build() {
    final _$result = _$v ??
        new _$SimpleHtmlBasedEpisode._(
            episodeInfo: episodeInfo,
            id: id,
            name: name,
            chineseName: chineseName,
            airStatus: airStatus,
            userEpisodeStatus: userEpisodeStatus,
            episodeType: episodeType);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
