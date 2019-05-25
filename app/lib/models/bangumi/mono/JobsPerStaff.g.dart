// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'JobsPerStaff.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<JobsPerStaff> _$jobsPerStaffSerializer =
    new _$JobsPerStaffSerializer();

class _$JobsPerStaffSerializer implements StructuredSerializer<JobsPerStaff> {
  @override
  final Iterable<Type> types = const [JobsPerStaff, _$JobsPerStaff];
  @override
  final String wireName = 'staff';

  @override
  Iterable serialize(Serializers serializers, JobsPerStaff object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'role_name',
      serializers.serialize(object.roleName,
          specifiedType: const FullType(String)),
      'images',
      serializers.serialize(object.image,
          specifiedType: const FullType(BangumiImage)),
      'jobs',
      serializers.serialize(object.jobs,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];
    if (object.nameCn != null) {
      result
        ..add('name_cn')
        ..add(serializers.serialize(object.nameCn,
            specifiedType: const FullType(String)));
    }
    if (object.commentCount != null) {
      result
        ..add('comment')
        ..add(serializers.serialize(object.commentCount,
            specifiedType: const FullType(int)));
    }
    if (object.collectionCounts != null) {
      result
        ..add('collects')
        ..add(serializers.serialize(object.collectionCounts,
            specifiedType: const FullType(int)));
    }
    if (object.pageUrl != null) {
      result
        ..add('url')
        ..add(serializers.serialize(object.pageUrl,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  JobsPerStaff deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new JobsPerStaffBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name_cn':
          result.nameCn = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'role_name':
          result.roleName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'images':
          result.image.replace(serializers.deserialize(value,
              specifiedType: const FullType(BangumiImage)) as BangumiImage);
          break;
        case 'comment':
          result.commentCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'collects':
          result.collectionCounts = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'jobs':
          result.jobs.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList);
          break;
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

class _$JobsPerStaff extends JobsPerStaff {
  @override
  final String nameCn;
  @override
  final String roleName;
  @override
  final BangumiImage image;
  @override
  final int commentCount;
  @override
  final int collectionCounts;
  @override
  final BuiltList<String> jobs;
  @override
  final int id;
  @override
  final String pageUrl;
  @override
  final String name;

  factory _$JobsPerStaff([void Function(JobsPerStaffBuilder) updates]) =>
      (new JobsPerStaffBuilder()..update(updates)).build();

  _$JobsPerStaff._(
      {this.nameCn,
      this.roleName,
      this.image,
      this.commentCount,
      this.collectionCounts,
      this.jobs,
      this.id,
      this.pageUrl,
      this.name})
      : super._() {
    if (roleName == null) {
      throw new BuiltValueNullFieldError('JobsPerStaff', 'roleName');
    }
    if (image == null) {
      throw new BuiltValueNullFieldError('JobsPerStaff', 'image');
    }
    if (jobs == null) {
      throw new BuiltValueNullFieldError('JobsPerStaff', 'jobs');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('JobsPerStaff', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('JobsPerStaff', 'name');
    }
  }

  @override
  JobsPerStaff rebuild(void Function(JobsPerStaffBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  JobsPerStaffBuilder toBuilder() => new JobsPerStaffBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is JobsPerStaff &&
        nameCn == other.nameCn &&
        roleName == other.roleName &&
        image == other.image &&
        commentCount == other.commentCount &&
        collectionCounts == other.collectionCounts &&
        jobs == other.jobs &&
        id == other.id &&
        pageUrl == other.pageUrl &&
        name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, nameCn.hashCode), roleName.hashCode),
                                image.hashCode),
                            commentCount.hashCode),
                        collectionCounts.hashCode),
                    jobs.hashCode),
                id.hashCode),
            pageUrl.hashCode),
        name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('JobsPerStaff')
          ..add('nameCn', nameCn)
          ..add('roleName', roleName)
          ..add('image', image)
          ..add('commentCount', commentCount)
          ..add('collectionCounts', collectionCounts)
          ..add('jobs', jobs)
          ..add('id', id)
          ..add('pageUrl', pageUrl)
          ..add('name', name))
        .toString();
  }
}

class JobsPerStaffBuilder
    implements Builder<JobsPerStaff, JobsPerStaffBuilder>, MonoBaseBuilder {
  _$JobsPerStaff _$v;

  String _nameCn;
  String get nameCn => _$this._nameCn;
  set nameCn(String nameCn) => _$this._nameCn = nameCn;

  String _roleName;
  String get roleName => _$this._roleName;
  set roleName(String roleName) => _$this._roleName = roleName;

  BangumiImageBuilder _image;
  BangumiImageBuilder get image => _$this._image ??= new BangumiImageBuilder();
  set image(BangumiImageBuilder image) => _$this._image = image;

  int _commentCount;
  int get commentCount => _$this._commentCount;
  set commentCount(int commentCount) => _$this._commentCount = commentCount;

  int _collectionCounts;
  int get collectionCounts => _$this._collectionCounts;
  set collectionCounts(int collectionCounts) =>
      _$this._collectionCounts = collectionCounts;

  ListBuilder<String> _jobs;
  ListBuilder<String> get jobs => _$this._jobs ??= new ListBuilder<String>();
  set jobs(ListBuilder<String> jobs) => _$this._jobs = jobs;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _pageUrl;
  String get pageUrl => _$this._pageUrl;
  set pageUrl(String pageUrl) => _$this._pageUrl = pageUrl;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  JobsPerStaffBuilder();

  JobsPerStaffBuilder get _$this {
    if (_$v != null) {
      _nameCn = _$v.nameCn;
      _roleName = _$v.roleName;
      _image = _$v.image?.toBuilder();
      _commentCount = _$v.commentCount;
      _collectionCounts = _$v.collectionCounts;
      _jobs = _$v.jobs?.toBuilder();
      _id = _$v.id;
      _pageUrl = _$v.pageUrl;
      _name = _$v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant JobsPerStaff other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$JobsPerStaff;
  }

  @override
  void update(void Function(JobsPerStaffBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$JobsPerStaff build() {
    _$JobsPerStaff _$result;
    try {
      _$result = _$v ??
          new _$JobsPerStaff._(
              nameCn: nameCn,
              roleName: roleName,
              image: image.build(),
              commentCount: commentCount,
              collectionCounts: collectionCounts,
              jobs: jobs.build(),
              id: id,
              pageUrl: pageUrl,
              name: name);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'image';
        image.build();

        _$failedField = 'jobs';
        jobs.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'JobsPerStaff', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
