// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PublicMessageNormal.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PublicMessageNormal extends PublicMessageNormal {
  @override
  final TimelineUserInfo user;
  @override
  final String content;
  @override
  final String replyCount;
  @override
  final int id;

  factory _$PublicMessageNormal([void updates(PublicMessageNormalBuilder b)]) =>
      (new PublicMessageNormalBuilder()..update(updates)).build();

  _$PublicMessageNormal._({this.user, this.content, this.replyCount, this.id})
      : super._() {
    if (user == null) {
      throw new BuiltValueNullFieldError('PublicMessageNormal', 'user');
    }
    if (content == null) {
      throw new BuiltValueNullFieldError('PublicMessageNormal', 'content');
    }
    if (replyCount == null) {
      throw new BuiltValueNullFieldError('PublicMessageNormal', 'replyCount');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('PublicMessageNormal', 'id');
    }
  }

  @override
  PublicMessageNormal rebuild(void updates(PublicMessageNormalBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  PublicMessageNormalBuilder toBuilder() =>
      new PublicMessageNormalBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PublicMessageNormal &&
        user == other.user &&
        content == other.content &&
        replyCount == other.replyCount &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, user.hashCode), content.hashCode), replyCount.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PublicMessageNormal')
          ..add('user', user)
          ..add('content', content)
          ..add('replyCount', replyCount)
          ..add('id', id))
        .toString();
  }
}

class PublicMessageNormalBuilder
    implements Builder<PublicMessageNormal, PublicMessageNormalBuilder> {
  _$PublicMessageNormal _$v;

  TimelineUserInfoBuilder _user;

  TimelineUserInfoBuilder get user =>
      _$this._user ??= new TimelineUserInfoBuilder();

  set user(TimelineUserInfoBuilder user) => _$this._user = user;

  String _content;

  String get content => _$this._content;

  set content(String content) => _$this._content = content;

  String _replyCount;

  String get replyCount => _$this._replyCount;

  set replyCount(String replyCount) => _$this._replyCount = replyCount;

  int _id;

  int get id => _$this._id;

  set id(int id) => _$this._id = id;

  PublicMessageNormalBuilder();

  PublicMessageNormalBuilder get _$this {
    if (_$v != null) {
      _user = _$v.user?.toBuilder();
      _content = _$v.content;
      _replyCount = _$v.replyCount;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PublicMessageNormal other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PublicMessageNormal;
  }

  @override
  void update(void updates(PublicMessageNormalBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$PublicMessageNormal build() {
    _$PublicMessageNormal _$result;
    try {
      _$result = _$v ??
          new _$PublicMessageNormal._(
              user: user.build(),
              content: content,
              replyCount: replyCount,
              id: id);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PublicMessageNormal', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
