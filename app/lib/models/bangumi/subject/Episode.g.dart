// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Episode.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Episode> _$episodeSerializer = new _$EpisodeSerializer();

class _$EpisodeSerializer implements StructuredSerializer<Episode> {
  @override
  final Iterable<Type> types = const [Episode, _$Episode];
  @override
  final String wireName = 'Episode';

  @override
  Iterable<Object> serialize(Serializers serializers, Episode object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'url',
      serializers.serialize(object.url, specifiedType: const FullType(String)),
      'type',
      serializers.serialize(object.type, specifiedType: const FullType(int)),
      'sort',
      serializers.serialize(object.sort, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'name_cn',
      serializers.serialize(object.chineseName,
          specifiedType: const FullType(String)),
      'duration',
      serializers.serialize(object.duration,
          specifiedType: const FullType(String)),
      'airdate',
      serializers.serialize(object.airDate,
          specifiedType: const FullType(String)),
      'comment',
      serializers.serialize(object.comment, specifiedType: const FullType(int)),
      'desc',
      serializers.serialize(object.summary,
          specifiedType: const FullType(String)),
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Episode deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EpisodeBuilder();

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
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'sort':
          result.sort = serializers.deserialize(value,
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
        case 'duration':
          result.duration = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'airdate':
          result.airDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'comment':
          result.comment = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'desc':
          result.summary = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Episode extends Episode {
  @override
  final int id;
  @override
  final String url;
  @override
  final int type;
  @override
  final int sort;
  @override
  final String name;
  @override
  final String chineseName;
  @override
  final String duration;
  @override
  final String airDate;
  @override
  final int comment;
  @override
  final String summary;
  @override
  final String status;

  factory _$Episode([void Function(EpisodeBuilder) updates]) =>
      (new EpisodeBuilder()..update(updates)).build();

  _$Episode._(
      {this.id,
      this.url,
      this.type,
      this.sort,
      this.name,
      this.chineseName,
      this.duration,
      this.airDate,
      this.comment,
      this.summary,
      this.status})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Episode', 'id');
    }
    if (url == null) {
      throw new BuiltValueNullFieldError('Episode', 'url');
    }
    if (type == null) {
      throw new BuiltValueNullFieldError('Episode', 'type');
    }
    if (sort == null) {
      throw new BuiltValueNullFieldError('Episode', 'sort');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('Episode', 'name');
    }
    if (chineseName == null) {
      throw new BuiltValueNullFieldError('Episode', 'chineseName');
    }
    if (duration == null) {
      throw new BuiltValueNullFieldError('Episode', 'duration');
    }
    if (airDate == null) {
      throw new BuiltValueNullFieldError('Episode', 'airDate');
    }
    if (comment == null) {
      throw new BuiltValueNullFieldError('Episode', 'comment');
    }
    if (summary == null) {
      throw new BuiltValueNullFieldError('Episode', 'summary');
    }
    if (status == null) {
      throw new BuiltValueNullFieldError('Episode', 'status');
    }
  }

  @override
  Episode rebuild(void Function(EpisodeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EpisodeBuilder toBuilder() => new EpisodeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Episode &&
        id == other.id &&
        url == other.url &&
        type == other.type &&
        sort == other.sort &&
        name == other.name &&
        chineseName == other.chineseName &&
        duration == other.duration &&
        airDate == other.airDate &&
        comment == other.comment &&
        summary == other.summary &&
        status == other.status;
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
                                    $jc($jc($jc(0, id.hashCode), url.hashCode),
                                        type.hashCode),
                                    sort.hashCode),
                                name.hashCode),
                            chineseName.hashCode),
                        duration.hashCode),
                    airDate.hashCode),
                comment.hashCode),
            summary.hashCode),
        status.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Episode')
          ..add('id', id)
          ..add('url', url)
          ..add('type', type)
          ..add('sort', sort)
          ..add('name', name)
          ..add('chineseName', chineseName)
          ..add('duration', duration)
          ..add('airDate', airDate)
          ..add('comment', comment)
          ..add('summary', summary)
          ..add('status', status))
        .toString();
  }
}

class EpisodeBuilder implements Builder<Episode, EpisodeBuilder> {
  _$Episode _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _url;
  String get url => _$this._url;
  set url(String url) => _$this._url = url;

  int _type;
  int get type => _$this._type;
  set type(int type) => _$this._type = type;

  int _sort;
  int get sort => _$this._sort;
  set sort(int sort) => _$this._sort = sort;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _chineseName;
  String get chineseName => _$this._chineseName;
  set chineseName(String chineseName) => _$this._chineseName = chineseName;

  String _duration;
  String get duration => _$this._duration;
  set duration(String duration) => _$this._duration = duration;

  String _airDate;
  String get airDate => _$this._airDate;
  set airDate(String airDate) => _$this._airDate = airDate;

  int _comment;
  int get comment => _$this._comment;
  set comment(int comment) => _$this._comment = comment;

  String _summary;
  String get summary => _$this._summary;
  set summary(String summary) => _$this._summary = summary;

  String _status;
  String get status => _$this._status;
  set status(String status) => _$this._status = status;

  EpisodeBuilder();

  EpisodeBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _url = _$v.url;
      _type = _$v.type;
      _sort = _$v.sort;
      _name = _$v.name;
      _chineseName = _$v.chineseName;
      _duration = _$v.duration;
      _airDate = _$v.airDate;
      _comment = _$v.comment;
      _summary = _$v.summary;
      _status = _$v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Episode other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Episode;
  }

  @override
  void update(void Function(EpisodeBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Episode build() {
    final _$result = _$v ??
        new _$Episode._(
            id: id,
            url: url,
            type: type,
            sort: sort,
            name: name,
            chineseName: chineseName,
            duration: duration,
            airDate: airDate,
            comment: comment,
            summary: summary,
            status: status);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
