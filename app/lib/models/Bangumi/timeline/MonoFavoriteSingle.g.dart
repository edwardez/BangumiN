// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MonoFavoriteSingle.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MonoFavoriteSingle extends MonoFavoriteSingle {
  @override
  final TimelineUserInfo user;
  @override
  final String monoName;
  @override
  final String monoAvatarImageUrl;
  @override
  final int monoId;

  factory _$MonoFavoriteSingle([void updates(MonoFavoriteSingleBuilder b)]) =>
      (new MonoFavoriteSingleBuilder()..update(updates)).build();

  _$MonoFavoriteSingle._(
      {this.user, this.monoName, this.monoAvatarImageUrl, this.monoId})
      : super._() {
    if (user == null) {
      throw new BuiltValueNullFieldError('MonoFavoriteSingle', 'user');
    }
    if (monoName == null) {
      throw new BuiltValueNullFieldError('MonoFavoriteSingle', 'monoName');
    }
    if (monoAvatarImageUrl == null) {
      throw new BuiltValueNullFieldError(
          'MonoFavoriteSingle', 'monoAvatarImageUrl');
    }
    if (monoId == null) {
      throw new BuiltValueNullFieldError('MonoFavoriteSingle', 'monoId');
    }
  }

  @override
  MonoFavoriteSingle rebuild(void updates(MonoFavoriteSingleBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  MonoFavoriteSingleBuilder toBuilder() =>
      new MonoFavoriteSingleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MonoFavoriteSingle &&
        user == other.user &&
        monoName == other.monoName &&
        monoAvatarImageUrl == other.monoAvatarImageUrl &&
        monoId == other.monoId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, user.hashCode), monoName.hashCode),
            monoAvatarImageUrl.hashCode),
        monoId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MonoFavoriteSingle')
          ..add('user', user)
          ..add('monoName', monoName)
          ..add('monoAvatarImageUrl', monoAvatarImageUrl)
          ..add('monoId', monoId))
        .toString();
  }
}

class MonoFavoriteSingleBuilder
    implements Builder<MonoFavoriteSingle, MonoFavoriteSingleBuilder> {
  _$MonoFavoriteSingle _$v;

  TimelineUserInfoBuilder _user;

  TimelineUserInfoBuilder get user =>
      _$this._user ??= new TimelineUserInfoBuilder();

  set user(TimelineUserInfoBuilder user) => _$this._user = user;

  String _monoName;

  String get monoName => _$this._monoName;

  set monoName(String monoName) => _$this._monoName = monoName;

  String _monoAvatarImageUrl;

  String get monoAvatarImageUrl => _$this._monoAvatarImageUrl;

  set monoAvatarImageUrl(String monoAvatarImageUrl) =>
      _$this._monoAvatarImageUrl = monoAvatarImageUrl;

  int _monoId;

  int get monoId => _$this._monoId;

  set monoId(int monoId) => _$this._monoId = monoId;

  MonoFavoriteSingleBuilder();

  MonoFavoriteSingleBuilder get _$this {
    if (_$v != null) {
      _user = _$v.user?.toBuilder();
      _monoName = _$v.monoName;
      _monoAvatarImageUrl = _$v.monoAvatarImageUrl;
      _monoId = _$v.monoId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MonoFavoriteSingle other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MonoFavoriteSingle;
  }

  @override
  void update(void updates(MonoFavoriteSingleBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$MonoFavoriteSingle build() {
    _$MonoFavoriteSingle _$result;
    try {
      _$result = _$v ??
          new _$MonoFavoriteSingle._(
              user: user.build(),
              monoName: monoName,
              monoAvatarImageUrl: monoAvatarImageUrl,
              monoId: monoId);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'MonoFavoriteSingle', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
