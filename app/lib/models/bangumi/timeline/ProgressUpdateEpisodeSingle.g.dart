// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProgressUpdateEpisodeSingle.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProgressUpdateEpisodeSingle>
    _$progressUpdateEpisodeSingleSerializer =
    new _$ProgressUpdateEpisodeSingleSerializer();

class _$ProgressUpdateEpisodeSingleSerializer
    implements StructuredSerializer<ProgressUpdateEpisodeSingle> {
  @override
  final Iterable<Type> types = const [
    ProgressUpdateEpisodeSingle,
    _$ProgressUpdateEpisodeSingle
  ];
  @override
  final String wireName = 'ProgressUpdateEpisodeSingle';

  @override
  Iterable serialize(
      Serializers serializers, ProgressUpdateEpisodeSingle object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'user',
      serializers.serialize(object.user,
          specifiedType: const FullType(FeedMetaInfo)),
      'episodeName',
      serializers.serialize(object.episodeName,
          specifiedType: const FullType(String)),
      'episodeId',
      serializers.serialize(object.episodeId,
          specifiedType: const FullType(String)),
      'subjectName',
      serializers.serialize(object.subjectName,
          specifiedType: const FullType(String)),
      'subjectId',
      serializers.serialize(object.subjectId,
          specifiedType: const FullType(String)),
      'bangumiContent',
      serializers.serialize(object.bangumiContent,
          specifiedType: const FullType(BangumiContent)),
    ];
    if (object.isFromMutedUser != null) {
      result
        ..add('isFromMutedUser')
        ..add(serializers.serialize(object.isFromMutedUser,
            specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  ProgressUpdateEpisodeSingle deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProgressUpdateEpisodeSingleBuilder();

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
        case 'episodeName':
          result.episodeName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'episodeId':
          result.episodeId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'subjectName':
          result.subjectName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'subjectId':
          result.subjectId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'bangumiContent':
          result.bangumiContent = serializers.deserialize(value,
              specifiedType: const FullType(BangumiContent)) as BangumiContent;
          break;
        case 'isFromMutedUser':
          result.isFromMutedUser = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$ProgressUpdateEpisodeSingle extends ProgressUpdateEpisodeSingle {
  @override
  final FeedMetaInfo user;
  @override
  final String episodeName;
  @override
  final String episodeId;
  @override
  final String subjectName;
  @override
  final String subjectId;
  @override
  final BangumiContent bangumiContent;
  @override
  final bool isFromMutedUser;

  factory _$ProgressUpdateEpisodeSingle(
          [void Function(ProgressUpdateEpisodeSingleBuilder) updates]) =>
      (new ProgressUpdateEpisodeSingleBuilder()..update(updates)).build();

  _$ProgressUpdateEpisodeSingle._(
      {this.user,
      this.episodeName,
      this.episodeId,
      this.subjectName,
      this.subjectId,
      this.bangumiContent,
      this.isFromMutedUser})
      : super._() {
    if (user == null) {
      throw new BuiltValueNullFieldError('ProgressUpdateEpisodeSingle', 'user');
    }
    if (episodeName == null) {
      throw new BuiltValueNullFieldError(
          'ProgressUpdateEpisodeSingle', 'episodeName');
    }
    if (episodeId == null) {
      throw new BuiltValueNullFieldError(
          'ProgressUpdateEpisodeSingle', 'episodeId');
    }
    if (subjectName == null) {
      throw new BuiltValueNullFieldError(
          'ProgressUpdateEpisodeSingle', 'subjectName');
    }
    if (subjectId == null) {
      throw new BuiltValueNullFieldError(
          'ProgressUpdateEpisodeSingle', 'subjectId');
    }
    if (bangumiContent == null) {
      throw new BuiltValueNullFieldError(
          'ProgressUpdateEpisodeSingle', 'bangumiContent');
    }
  }

  @override
  ProgressUpdateEpisodeSingle rebuild(
          void Function(ProgressUpdateEpisodeSingleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProgressUpdateEpisodeSingleBuilder toBuilder() =>
      new ProgressUpdateEpisodeSingleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProgressUpdateEpisodeSingle &&
        user == other.user &&
        episodeName == other.episodeName &&
        episodeId == other.episodeId &&
        subjectName == other.subjectName &&
        subjectId == other.subjectId &&
        bangumiContent == other.bangumiContent &&
        isFromMutedUser == other.isFromMutedUser;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, user.hashCode), episodeName.hashCode),
                        episodeId.hashCode),
                    subjectName.hashCode),
                subjectId.hashCode),
            bangumiContent.hashCode),
        isFromMutedUser.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProgressUpdateEpisodeSingle')
          ..add('user', user)
          ..add('episodeName', episodeName)
          ..add('episodeId', episodeId)
          ..add('subjectName', subjectName)
          ..add('subjectId', subjectId)
          ..add('bangumiContent', bangumiContent)
          ..add('isFromMutedUser', isFromMutedUser))
        .toString();
  }
}

class ProgressUpdateEpisodeSingleBuilder
    implements
        Builder<ProgressUpdateEpisodeSingle,
            ProgressUpdateEpisodeSingleBuilder>,
        TimelineFeedBuilder {
  _$ProgressUpdateEpisodeSingle _$v;

  FeedMetaInfoBuilder _user;
  FeedMetaInfoBuilder get user => _$this._user ??= new FeedMetaInfoBuilder();
  set user(FeedMetaInfoBuilder user) => _$this._user = user;

  String _episodeName;
  String get episodeName => _$this._episodeName;
  set episodeName(String episodeName) => _$this._episodeName = episodeName;

  String _episodeId;
  String get episodeId => _$this._episodeId;
  set episodeId(String episodeId) => _$this._episodeId = episodeId;

  String _subjectName;
  String get subjectName => _$this._subjectName;
  set subjectName(String subjectName) => _$this._subjectName = subjectName;

  String _subjectId;
  String get subjectId => _$this._subjectId;
  set subjectId(String subjectId) => _$this._subjectId = subjectId;

  BangumiContent _bangumiContent;
  BangumiContent get bangumiContent => _$this._bangumiContent;
  set bangumiContent(BangumiContent bangumiContent) =>
      _$this._bangumiContent = bangumiContent;

  bool _isFromMutedUser;
  bool get isFromMutedUser => _$this._isFromMutedUser;
  set isFromMutedUser(bool isFromMutedUser) =>
      _$this._isFromMutedUser = isFromMutedUser;

  ProgressUpdateEpisodeSingleBuilder();

  ProgressUpdateEpisodeSingleBuilder get _$this {
    if (_$v != null) {
      _user = _$v.user?.toBuilder();
      _episodeName = _$v.episodeName;
      _episodeId = _$v.episodeId;
      _subjectName = _$v.subjectName;
      _subjectId = _$v.subjectId;
      _bangumiContent = _$v.bangumiContent;
      _isFromMutedUser = _$v.isFromMutedUser;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant ProgressUpdateEpisodeSingle other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProgressUpdateEpisodeSingle;
  }

  @override
  void update(void Function(ProgressUpdateEpisodeSingleBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProgressUpdateEpisodeSingle build() {
    _$ProgressUpdateEpisodeSingle _$result;
    try {
      _$result = _$v ??
          new _$ProgressUpdateEpisodeSingle._(
              user: user.build(),
              episodeName: episodeName,
              episodeId: episodeId,
              subjectName: subjectName,
              subjectId: subjectId,
              bangumiContent: bangumiContent,
              isFromMutedUser: isFromMutedUser);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ProgressUpdateEpisodeSingle', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
