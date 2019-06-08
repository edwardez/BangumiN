// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'InProgressSubjectInfo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<InProgressSubjectInfo> _$inProgressSubjectInfoSerializer =
    new _$InProgressSubjectInfoSerializer();

class _$InProgressSubjectInfoSerializer
    implements StructuredSerializer<InProgressSubjectInfo> {
  @override
  final Iterable<Type> types = const [
    InProgressSubjectInfo,
    _$InProgressSubjectInfo
  ];
  @override
  final String wireName = 'InProgressSubjectInfo';

  @override
  Iterable serialize(Serializers serializers, InProgressSubjectInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(SubjectType)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];
    if (object.cover != null) {
      result
        ..add('images')
        ..add(serializers.serialize(object.cover,
            specifiedType: const FullType(BangumiImage)));
    }
    if (object.airDate != null) {
      result
        ..add('air_date')
        ..add(serializers.serialize(object.airDate,
            specifiedType: const FullType(String)));
    }
    if (object.airWeekday != null) {
      result
        ..add('air_weekday')
        ..add(serializers.serialize(object.airWeekday,
            specifiedType: const FullType(int)));
    }
    if (object.totalEpisodesCount != null) {
      result
        ..add('eps_count')
        ..add(serializers.serialize(object.totalEpisodesCount,
            specifiedType: const FullType(int)));
    }
    if (object.totalVolumesCount != null) {
      result
        ..add('vol_count')
        ..add(serializers.serialize(object.totalVolumesCount,
            specifiedType: const FullType(int)));
    }
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    if (object.pageUrlFromApi != null) {
      result
        ..add('url')
        ..add(serializers.serialize(object.pageUrlFromApi,
            specifiedType: const FullType(String)));
    }
    if (object.nameCn != null) {
      result
        ..add('name_cn')
        ..add(serializers.serialize(object.nameCn,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  InProgressSubjectInfo deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InProgressSubjectInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(SubjectType)) as SubjectType;
          break;
        case 'images':
          result.cover.replace(serializers.deserialize(value,
              specifiedType: const FullType(BangumiImage)) as BangumiImage);
          break;
        case 'air_date':
          result.airDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'air_weekday':
          result.airWeekday = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'eps_count':
          result.totalEpisodesCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'vol_count':
          result.totalVolumesCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'url':
          result.pageUrlFromApi = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name_cn':
          result.nameCn = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$InProgressSubjectInfo extends InProgressSubjectInfo {
  @override
  final SubjectType type;
  @override
  final BangumiImage cover;
  @override
  final String airDate;
  @override
  final int airWeekday;
  @override
  final int totalEpisodesCount;
  @override
  final int totalVolumesCount;
  @override
  final int id;
  @override
  final String pageUrlFromApi;
  @override
  final String name;
  @override
  final String nameCn;

  factory _$InProgressSubjectInfo(
          [void Function(InProgressSubjectInfoBuilder) updates]) =>
      (new InProgressSubjectInfoBuilder()..update(updates)).build();

  _$InProgressSubjectInfo._(
      {this.type,
      this.cover,
      this.airDate,
      this.airWeekday,
      this.totalEpisodesCount,
      this.totalVolumesCount,
      this.id,
      this.pageUrlFromApi,
      this.name,
      this.nameCn})
      : super._() {
    if (type == null) {
      throw new BuiltValueNullFieldError('InProgressSubjectInfo', 'type');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('InProgressSubjectInfo', 'name');
    }
  }

  @override
  InProgressSubjectInfo rebuild(
          void Function(InProgressSubjectInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InProgressSubjectInfoBuilder toBuilder() =>
      new InProgressSubjectInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InProgressSubjectInfo &&
        type == other.type &&
        cover == other.cover &&
        airDate == other.airDate &&
        airWeekday == other.airWeekday &&
        totalEpisodesCount == other.totalEpisodesCount &&
        totalVolumesCount == other.totalVolumesCount &&
        id == other.id &&
        pageUrlFromApi == other.pageUrlFromApi &&
        name == other.name &&
        nameCn == other.nameCn;
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
                                $jc($jc($jc(0, type.hashCode), cover.hashCode),
                                    airDate.hashCode),
                                airWeekday.hashCode),
                            totalEpisodesCount.hashCode),
                        totalVolumesCount.hashCode),
                    id.hashCode),
                pageUrlFromApi.hashCode),
            name.hashCode),
        nameCn.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InProgressSubjectInfo')
          ..add('type', type)
          ..add('cover', cover)
          ..add('airDate', airDate)
          ..add('airWeekday', airWeekday)
          ..add('totalEpisodesCount', totalEpisodesCount)
          ..add('totalVolumesCount', totalVolumesCount)
          ..add('id', id)
          ..add('pageUrlFromApi', pageUrlFromApi)
          ..add('name', name)
          ..add('nameCn', nameCn))
        .toString();
  }
}

class InProgressSubjectInfoBuilder
    implements
        Builder<InProgressSubjectInfo, InProgressSubjectInfoBuilder>,
        SubjectBaseBuilder {
  _$InProgressSubjectInfo _$v;

  SubjectType _type;
  SubjectType get type => _$this._type;
  set type(SubjectType type) => _$this._type = type;

  BangumiImageBuilder _cover;
  BangumiImageBuilder get cover => _$this._cover ??= new BangumiImageBuilder();
  set cover(BangumiImageBuilder cover) => _$this._cover = cover;

  String _airDate;
  String get airDate => _$this._airDate;
  set airDate(String airDate) => _$this._airDate = airDate;

  int _airWeekday;
  int get airWeekday => _$this._airWeekday;
  set airWeekday(int airWeekday) => _$this._airWeekday = airWeekday;

  int _totalEpisodesCount;
  int get totalEpisodesCount => _$this._totalEpisodesCount;
  set totalEpisodesCount(int totalEpisodesCount) =>
      _$this._totalEpisodesCount = totalEpisodesCount;

  int _totalVolumesCount;
  int get totalVolumesCount => _$this._totalVolumesCount;
  set totalVolumesCount(int totalVolumesCount) =>
      _$this._totalVolumesCount = totalVolumesCount;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _pageUrlFromApi;
  String get pageUrlFromApi => _$this._pageUrlFromApi;
  set pageUrlFromApi(String pageUrlFromApi) =>
      _$this._pageUrlFromApi = pageUrlFromApi;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _nameCn;
  String get nameCn => _$this._nameCn;
  set nameCn(String nameCn) => _$this._nameCn = nameCn;

  InProgressSubjectInfoBuilder();

  InProgressSubjectInfoBuilder get _$this {
    if (_$v != null) {
      _type = _$v.type;
      _cover = _$v.cover?.toBuilder();
      _airDate = _$v.airDate;
      _airWeekday = _$v.airWeekday;
      _totalEpisodesCount = _$v.totalEpisodesCount;
      _totalVolumesCount = _$v.totalVolumesCount;
      _id = _$v.id;
      _pageUrlFromApi = _$v.pageUrlFromApi;
      _name = _$v.name;
      _nameCn = _$v.nameCn;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant InProgressSubjectInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InProgressSubjectInfo;
  }

  @override
  void update(void Function(InProgressSubjectInfoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InProgressSubjectInfo build() {
    _$InProgressSubjectInfo _$result;
    try {
      _$result = _$v ??
          new _$InProgressSubjectInfo._(
              type: type,
              cover: _cover?.build(),
              airDate: airDate,
              airWeekday: airWeekday,
              totalEpisodesCount: totalEpisodesCount,
              totalVolumesCount: totalVolumesCount,
              id: id,
              pageUrlFromApi: pageUrlFromApi,
              name: name,
              nameCn: nameCn);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'cover';
        _cover?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'InProgressSubjectInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
