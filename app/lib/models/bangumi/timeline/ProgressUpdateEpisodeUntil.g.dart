// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProgressUpdateEpisodeUntil.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProgressUpdateEpisodeUntil> _$progressUpdateEpisodeUntilSerializer =
    new _$ProgressUpdateEpisodeUntilSerializer();

class _$ProgressUpdateEpisodeUntilSerializer
    implements StructuredSerializer<ProgressUpdateEpisodeUntil> {
  @override
  final Iterable<Type> types = const [
    ProgressUpdateEpisodeUntil,
    _$ProgressUpdateEpisodeUntil
  ];
  @override
  final String wireName = 'ProgressUpdateEpisodeUntil';

  @override
  Iterable serialize(Serializers serializers, ProgressUpdateEpisodeUntil object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'user',
      serializers.serialize(object.user,
          specifiedType: const FullType(FeedMetaInfo)),
      'subjectName',
      serializers.serialize(object.subjectName,
          specifiedType: const FullType(String)),
      'subjectId',
      serializers.serialize(object.subjectId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ProgressUpdateEpisodeUntil deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProgressUpdateEpisodeUntilBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'user':
          result.user.replace(serializers.deserialize(value,
              specifiedType: const FullType(FeedMetaInfo)) as FeedMetaInfo);
          break;
        case 'subjectName':
          result.subjectName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'subjectId':
          result.subjectId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ProgressUpdateEpisodeUntil extends ProgressUpdateEpisodeUntil {
  @override
  final FeedMetaInfo user;
  @override
  final String subjectName;
  @override
  final String subjectId;

  factory _$ProgressUpdateEpisodeUntil(
          [void Function(ProgressUpdateEpisodeUntilBuilder) updates]) =>
      (new ProgressUpdateEpisodeUntilBuilder()..update(updates)).build();

  _$ProgressUpdateEpisodeUntil._({this.user, this.subjectName, this.subjectId})
      : super._() {
    if (user == null) {
      throw new BuiltValueNullFieldError('ProgressUpdateEpisodeUntil', 'user');
    }
    if (subjectName == null) {
      throw new BuiltValueNullFieldError(
          'ProgressUpdateEpisodeUntil', 'subjectName');
    }
    if (subjectId == null) {
      throw new BuiltValueNullFieldError(
          'ProgressUpdateEpisodeUntil', 'subjectId');
    }
  }

  @override
  ProgressUpdateEpisodeUntil rebuild(
          void Function(ProgressUpdateEpisodeUntilBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProgressUpdateEpisodeUntilBuilder toBuilder() =>
      new ProgressUpdateEpisodeUntilBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProgressUpdateEpisodeUntil &&
        user == other.user &&
        subjectName == other.subjectName &&
        subjectId == other.subjectId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, user.hashCode), subjectName.hashCode), subjectId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProgressUpdateEpisodeUntil')
          ..add('user', user)
          ..add('subjectName', subjectName)
          ..add('subjectId', subjectId))
        .toString();
  }
}

class ProgressUpdateEpisodeUntilBuilder
    implements
        Builder<ProgressUpdateEpisodeUntil, ProgressUpdateEpisodeUntilBuilder> {
  _$ProgressUpdateEpisodeUntil _$v;

  FeedMetaInfoBuilder _user;
  FeedMetaInfoBuilder get user => _$this._user ??= new FeedMetaInfoBuilder();
  set user(FeedMetaInfoBuilder user) => _$this._user = user;

  String _subjectName;
  String get subjectName => _$this._subjectName;
  set subjectName(String subjectName) => _$this._subjectName = subjectName;

  String _subjectId;
  String get subjectId => _$this._subjectId;
  set subjectId(String subjectId) => _$this._subjectId = subjectId;

  ProgressUpdateEpisodeUntilBuilder();

  ProgressUpdateEpisodeUntilBuilder get _$this {
    if (_$v != null) {
      _user = _$v.user?.toBuilder();
      _subjectName = _$v.subjectName;
      _subjectId = _$v.subjectId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProgressUpdateEpisodeUntil other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProgressUpdateEpisodeUntil;
  }

  @override
  void update(void Function(ProgressUpdateEpisodeUntilBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProgressUpdateEpisodeUntil build() {
    _$ProgressUpdateEpisodeUntil _$result;
    try {
      _$result = _$v ??
          new _$ProgressUpdateEpisodeUntil._(
              user: user.build(),
              subjectName: subjectName,
              subjectId: subjectId);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ProgressUpdateEpisodeUntil', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
