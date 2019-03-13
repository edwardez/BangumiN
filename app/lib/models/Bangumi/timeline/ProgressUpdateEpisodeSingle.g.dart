// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProgressUpdateEpisodeSingle.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProgressUpdateEpisodeSingle extends ProgressUpdateEpisodeSingle {
  @override
  final TimelineUserInfo user;
  @override
  final String episodeName;
  @override
  final int episodeId;
  @override
  final String subjectName;
  @override
  final int subjectId;

  factory _$ProgressUpdateEpisodeSingle(
          [void updates(ProgressUpdateEpisodeSingleBuilder b)]) =>
      (new ProgressUpdateEpisodeSingleBuilder()..update(updates)).build();

  _$ProgressUpdateEpisodeSingle._(
      {this.user,
      this.episodeName,
      this.episodeId,
      this.subjectName,
      this.subjectId})
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
  }

  @override
  ProgressUpdateEpisodeSingle rebuild(
          void updates(ProgressUpdateEpisodeSingleBuilder b)) =>
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
        subjectId == other.subjectId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, user.hashCode), episodeName.hashCode),
                episodeId.hashCode),
            subjectName.hashCode),
        subjectId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProgressUpdateEpisodeSingle')
          ..add('user', user)
          ..add('episodeName', episodeName)
          ..add('episodeId', episodeId)
          ..add('subjectName', subjectName)
          ..add('subjectId', subjectId))
        .toString();
  }
}

class ProgressUpdateEpisodeSingleBuilder
    implements
        Builder<ProgressUpdateEpisodeSingle,
            ProgressUpdateEpisodeSingleBuilder> {
  _$ProgressUpdateEpisodeSingle _$v;

  TimelineUserInfoBuilder _user;

  TimelineUserInfoBuilder get user =>
      _$this._user ??= new TimelineUserInfoBuilder();

  set user(TimelineUserInfoBuilder user) => _$this._user = user;

  String _episodeName;

  String get episodeName => _$this._episodeName;

  set episodeName(String episodeName) => _$this._episodeName = episodeName;

  int _episodeId;

  int get episodeId => _$this._episodeId;

  set episodeId(int episodeId) => _$this._episodeId = episodeId;

  String _subjectName;

  String get subjectName => _$this._subjectName;

  set subjectName(String subjectName) => _$this._subjectName = subjectName;

  int _subjectId;

  int get subjectId => _$this._subjectId;

  set subjectId(int subjectId) => _$this._subjectId = subjectId;

  ProgressUpdateEpisodeSingleBuilder();

  ProgressUpdateEpisodeSingleBuilder get _$this {
    if (_$v != null) {
      _user = _$v.user?.toBuilder();
      _episodeName = _$v.episodeName;
      _episodeId = _$v.episodeId;
      _subjectName = _$v.subjectName;
      _subjectId = _$v.subjectId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProgressUpdateEpisodeSingle other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProgressUpdateEpisodeSingle;
  }

  @override
  void update(void updates(ProgressUpdateEpisodeSingleBuilder b)) {
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
              subjectId: subjectId);
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
