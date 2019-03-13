// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TimelineUserInfo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TimelineUserInfo extends TimelineUserInfo {
  @override
  final String updatedAt;
  @override
  final String nickName;
  @override
  final String avatarImageUrl;
  @override
  final String id;
  @override
  final String actionName;

  factory _$TimelineUserInfo([void updates(TimelineUserInfoBuilder b)]) =>
      (new TimelineUserInfoBuilder()..update(updates)).build();

  _$TimelineUserInfo._(
      {this.updatedAt,
      this.nickName,
      this.avatarImageUrl,
      this.id,
      this.actionName})
      : super._() {
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('TimelineUserInfo', 'updatedAt');
    }
    if (nickName == null) {
      throw new BuiltValueNullFieldError('TimelineUserInfo', 'nickName');
    }
    if (avatarImageUrl == null) {
      throw new BuiltValueNullFieldError('TimelineUserInfo', 'avatarImageUrl');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('TimelineUserInfo', 'id');
    }
    if (actionName == null) {
      throw new BuiltValueNullFieldError('TimelineUserInfo', 'actionName');
    }
  }

  @override
  TimelineUserInfo rebuild(void updates(TimelineUserInfoBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TimelineUserInfoBuilder toBuilder() =>
      new TimelineUserInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TimelineUserInfo &&
        updatedAt == other.updatedAt &&
        nickName == other.nickName &&
        avatarImageUrl == other.avatarImageUrl &&
        id == other.id &&
        actionName == other.actionName;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, updatedAt.hashCode), nickName.hashCode),
                avatarImageUrl.hashCode),
            id.hashCode),
        actionName.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TimelineUserInfo')
          ..add('updatedAt', updatedAt)
          ..add('nickName', nickName)
          ..add('avatarImageUrl', avatarImageUrl)
          ..add('id', id)
          ..add('actionName', actionName))
        .toString();
  }
}

class TimelineUserInfoBuilder
    implements Builder<TimelineUserInfo, TimelineUserInfoBuilder> {
  _$TimelineUserInfo _$v;

  String _updatedAt;

  String get updatedAt => _$this._updatedAt;

  set updatedAt(String updatedAt) => _$this._updatedAt = updatedAt;

  String _nickName;

  String get nickName => _$this._nickName;

  set nickName(String nickName) => _$this._nickName = nickName;

  String _avatarImageUrl;

  String get avatarImageUrl => _$this._avatarImageUrl;

  set avatarImageUrl(String avatarImageUrl) =>
      _$this._avatarImageUrl = avatarImageUrl;

  String _id;

  String get id => _$this._id;

  set id(String id) => _$this._id = id;

  String _actionName;

  String get actionName => _$this._actionName;

  set actionName(String actionName) => _$this._actionName = actionName;

  TimelineUserInfoBuilder();

  TimelineUserInfoBuilder get _$this {
    if (_$v != null) {
      _updatedAt = _$v.updatedAt;
      _nickName = _$v.nickName;
      _avatarImageUrl = _$v.avatarImageUrl;
      _id = _$v.id;
      _actionName = _$v.actionName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TimelineUserInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TimelineUserInfo;
  }

  @override
  void update(void updates(TimelineUserInfoBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TimelineUserInfo build() {
    final _$result = _$v ??
        new _$TimelineUserInfo._(
            updatedAt: updatedAt,
            nickName: nickName,
            avatarImageUrl: avatarImageUrl,
            id: id,
            actionName: actionName);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
