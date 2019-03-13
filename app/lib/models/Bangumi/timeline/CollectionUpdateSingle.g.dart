// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CollectionUpdateSingle.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CollectionUpdateSingle extends CollectionUpdateSingle {
  @override
  final TimelineUserInfo user;
  @override
  final String subjectComment;
  @override
  final int subjectId;
  @override
  final String subjectImageUrl;
  @override
  final double subjectScore;
  @override
  final String subjectTitle;

  factory _$CollectionUpdateSingle(
          [void updates(CollectionUpdateSingleBuilder b)]) =>
      (new CollectionUpdateSingleBuilder()..update(updates)).build();

  _$CollectionUpdateSingle._(
      {this.user,
      this.subjectComment,
      this.subjectId,
      this.subjectImageUrl,
      this.subjectScore,
      this.subjectTitle})
      : super._() {
    if (user == null) {
      throw new BuiltValueNullFieldError('CollectionUpdateSingle', 'user');
    }
    if (subjectComment == null) {
      throw new BuiltValueNullFieldError(
          'CollectionUpdateSingle', 'subjectComment');
    }
    if (subjectId == null) {
      throw new BuiltValueNullFieldError('CollectionUpdateSingle', 'subjectId');
    }
    if (subjectImageUrl == null) {
      throw new BuiltValueNullFieldError(
          'CollectionUpdateSingle', 'subjectImageUrl');
    }
    if (subjectScore == null) {
      throw new BuiltValueNullFieldError(
          'CollectionUpdateSingle', 'subjectScore');
    }
    if (subjectTitle == null) {
      throw new BuiltValueNullFieldError(
          'CollectionUpdateSingle', 'subjectTitle');
    }
  }

  @override
  CollectionUpdateSingle rebuild(
          void updates(CollectionUpdateSingleBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CollectionUpdateSingleBuilder toBuilder() =>
      new CollectionUpdateSingleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CollectionUpdateSingle &&
        user == other.user &&
        subjectComment == other.subjectComment &&
        subjectId == other.subjectId &&
        subjectImageUrl == other.subjectImageUrl &&
        subjectScore == other.subjectScore &&
        subjectTitle == other.subjectTitle;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, user.hashCode), subjectComment.hashCode),
                    subjectId.hashCode),
                subjectImageUrl.hashCode),
            subjectScore.hashCode),
        subjectTitle.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CollectionUpdateSingle')
          ..add('user', user)
          ..add('subjectComment', subjectComment)
          ..add('subjectId', subjectId)
          ..add('subjectImageUrl', subjectImageUrl)
          ..add('subjectScore', subjectScore)
          ..add('subjectTitle', subjectTitle))
        .toString();
  }
}

class CollectionUpdateSingleBuilder
    implements Builder<CollectionUpdateSingle, CollectionUpdateSingleBuilder> {
  _$CollectionUpdateSingle _$v;

  TimelineUserInfoBuilder _user;

  TimelineUserInfoBuilder get user =>
      _$this._user ??= new TimelineUserInfoBuilder();

  set user(TimelineUserInfoBuilder user) => _$this._user = user;

  String _subjectComment;

  String get subjectComment => _$this._subjectComment;

  set subjectComment(String subjectComment) =>
      _$this._subjectComment = subjectComment;

  int _subjectId;

  int get subjectId => _$this._subjectId;

  set subjectId(int subjectId) => _$this._subjectId = subjectId;

  String _subjectImageUrl;

  String get subjectImageUrl => _$this._subjectImageUrl;

  set subjectImageUrl(String subjectImageUrl) =>
      _$this._subjectImageUrl = subjectImageUrl;

  double _subjectScore;

  double get subjectScore => _$this._subjectScore;

  set subjectScore(double subjectScore) => _$this._subjectScore = subjectScore;

  String _subjectTitle;

  String get subjectTitle => _$this._subjectTitle;

  set subjectTitle(String subjectTitle) => _$this._subjectTitle = subjectTitle;

  CollectionUpdateSingleBuilder();

  CollectionUpdateSingleBuilder get _$this {
    if (_$v != null) {
      _user = _$v.user?.toBuilder();
      _subjectComment = _$v.subjectComment;
      _subjectId = _$v.subjectId;
      _subjectImageUrl = _$v.subjectImageUrl;
      _subjectScore = _$v.subjectScore;
      _subjectTitle = _$v.subjectTitle;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CollectionUpdateSingle other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CollectionUpdateSingle;
  }

  @override
  void update(void updates(CollectionUpdateSingleBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$CollectionUpdateSingle build() {
    _$CollectionUpdateSingle _$result;
    try {
      _$result = _$v ??
          new _$CollectionUpdateSingle._(
              user: user.build(),
              subjectComment: subjectComment,
              subjectId: subjectId,
              subjectImageUrl: subjectImageUrl,
              subjectScore: subjectScore,
              subjectTitle: subjectTitle);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CollectionUpdateSingle', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
