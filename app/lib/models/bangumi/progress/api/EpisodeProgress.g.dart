// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EpisodeProgress.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<EpisodeProgress> _$episodeProgressSerializer =
    new _$EpisodeProgressSerializer();

class _$EpisodeProgressSerializer
    implements StructuredSerializer<EpisodeProgress> {
  @override
  final Iterable<Type> types = const [EpisodeProgress, _$EpisodeProgress];
  @override
  final String wireName = 'EpisodeProgress';

  @override
  Iterable serialize(Serializers serializers, EpisodeProgress object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'sort',
      serializers.serialize(object.sequentialNumber,
          specifiedType: const FullType(double)),
      'duration',
      serializers.serialize(object.duration,
          specifiedType: const FullType(String)),
      'airdate',
      serializers.serialize(object.airDate,
          specifiedType: const FullType(String)),
      'comment',
      serializers.serialize(object.totalCommentsCount,
          specifiedType: const FullType(int)),
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
    if (object.summary != null) {
      result
        ..add('desc')
        ..add(serializers.serialize(object.summary,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  EpisodeProgress deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EpisodeProgressBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'sort':
          result.sequentialNumber = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'duration':
          result.duration = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'airdate':
          result.airDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'comment':
          result.totalCommentsCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'desc':
          result.summary = serializers.deserialize(value,
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

class _$EpisodeProgress extends EpisodeProgress {
  @override
  final double sequentialNumber;
  @override
  final String duration;
  @override
  final String airDate;
  @override
  final int totalCommentsCount;
  @override
  final String summary;
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

  factory _$EpisodeProgress([void Function(EpisodeProgressBuilder) updates]) =>
      (new EpisodeProgressBuilder()..update(updates)).build();

  _$EpisodeProgress._(
      {this.sequentialNumber,
      this.duration,
      this.airDate,
      this.totalCommentsCount,
      this.summary,
      this.id,
      this.name,
      this.nameCn,
      this.airStatus,
      this.userEpisodeStatus,
      this.episodeType})
      : super._() {
    if (sequentialNumber == null) {
      throw new BuiltValueNullFieldError('EpisodeProgress', 'sequentialNumber');
    }
    if (duration == null) {
      throw new BuiltValueNullFieldError('EpisodeProgress', 'duration');
    }
    if (airDate == null) {
      throw new BuiltValueNullFieldError('EpisodeProgress', 'airDate');
    }
    if (totalCommentsCount == null) {
      throw new BuiltValueNullFieldError(
          'EpisodeProgress', 'totalCommentsCount');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('EpisodeProgress', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('EpisodeProgress', 'name');
    }
    if (nameCn == null) {
      throw new BuiltValueNullFieldError('EpisodeProgress', 'nameCn');
    }
    if (airStatus == null) {
      throw new BuiltValueNullFieldError('EpisodeProgress', 'airStatus');
    }
    if (userEpisodeStatus == null) {
      throw new BuiltValueNullFieldError(
          'EpisodeProgress', 'userEpisodeStatus');
    }
    if (episodeType == null) {
      throw new BuiltValueNullFieldError('EpisodeProgress', 'episodeType');
    }
  }

  @override
  EpisodeProgress rebuild(void Function(EpisodeProgressBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EpisodeProgressBuilder toBuilder() =>
      new EpisodeProgressBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EpisodeProgress &&
        sequentialNumber == other.sequentialNumber &&
        duration == other.duration &&
        airDate == other.airDate &&
        totalCommentsCount == other.totalCommentsCount &&
        summary == other.summary &&
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
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc($jc(0, sequentialNumber.hashCode),
                                            duration.hashCode),
                                        airDate.hashCode),
                                    totalCommentsCount.hashCode),
                                summary.hashCode),
                            id.hashCode),
                        name.hashCode),
                    nameCn.hashCode),
                airStatus.hashCode),
            userEpisodeStatus.hashCode),
        episodeType.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('EpisodeProgress')
          ..add('sequentialNumber', sequentialNumber)
          ..add('duration', duration)
          ..add('airDate', airDate)
          ..add('totalCommentsCount', totalCommentsCount)
          ..add('summary', summary)
          ..add('id', id)
          ..add('name', name)
          ..add('nameCn', nameCn)
          ..add('airStatus', airStatus)
          ..add('userEpisodeStatus', userEpisodeStatus)
          ..add('episodeType', episodeType))
        .toString();
  }
}

class EpisodeProgressBuilder
    implements
        Builder<EpisodeProgress, EpisodeProgressBuilder>,
        BaseEpisodeBuilder {
  _$EpisodeProgress _$v;

  double _sequentialNumber;
  double get sequentialNumber => _$this._sequentialNumber;
  set sequentialNumber(double sequentialNumber) =>
      _$this._sequentialNumber = sequentialNumber;

  String _duration;
  String get duration => _$this._duration;
  set duration(String duration) => _$this._duration = duration;

  String _airDate;
  String get airDate => _$this._airDate;
  set airDate(String airDate) => _$this._airDate = airDate;

  int _totalCommentsCount;
  int get totalCommentsCount => _$this._totalCommentsCount;
  set totalCommentsCount(int totalCommentsCount) =>
      _$this._totalCommentsCount = totalCommentsCount;

  String _summary;
  String get summary => _$this._summary;
  set summary(String summary) => _$this._summary = summary;

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

  EpisodeProgressBuilder();

  EpisodeProgressBuilder get _$this {
    if (_$v != null) {
      _sequentialNumber = _$v.sequentialNumber;
      _duration = _$v.duration;
      _airDate = _$v.airDate;
      _totalCommentsCount = _$v.totalCommentsCount;
      _summary = _$v.summary;
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
  void replace(covariant EpisodeProgress other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$EpisodeProgress;
  }

  @override
  void update(void Function(EpisodeProgressBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$EpisodeProgress build() {
    final _$result = _$v ??
        new _$EpisodeProgress._(
            sequentialNumber: sequentialNumber,
            duration: duration,
            airDate: airDate,
            totalCommentsCount: totalCommentsCount,
            summary: summary,
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
