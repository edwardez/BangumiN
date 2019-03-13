// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DoujinActivitySingle.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DoujinActivitySingle extends DoujinActivitySingle {
  @override
  final TimelineUserInfo user;
  @override
  final String url;
  @override
  final String activityTargetName;
  @override
  final String imageUrl;

  factory _$DoujinActivitySingle(
          [void updates(DoujinActivitySingleBuilder b)]) =>
      (new DoujinActivitySingleBuilder()..update(updates)).build();

  _$DoujinActivitySingle._(
      {this.user, this.url, this.activityTargetName, this.imageUrl})
      : super._() {
    if (user == null) {
      throw new BuiltValueNullFieldError('DoujinActivitySingle', 'user');
    }
    if (url == null) {
      throw new BuiltValueNullFieldError('DoujinActivitySingle', 'url');
    }
    if (activityTargetName == null) {
      throw new BuiltValueNullFieldError(
          'DoujinActivitySingle', 'activityTargetName');
    }
  }

  @override
  DoujinActivitySingle rebuild(void updates(DoujinActivitySingleBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  DoujinActivitySingleBuilder toBuilder() =>
      new DoujinActivitySingleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DoujinActivitySingle &&
        user == other.user &&
        url == other.url &&
        activityTargetName == other.activityTargetName &&
        imageUrl == other.imageUrl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, user.hashCode), url.hashCode),
            activityTargetName.hashCode),
        imageUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DoujinActivitySingle')
          ..add('user', user)
          ..add('url', url)
          ..add('activityTargetName', activityTargetName)
          ..add('imageUrl', imageUrl))
        .toString();
  }
}

class DoujinActivitySingleBuilder
    implements Builder<DoujinActivitySingle, DoujinActivitySingleBuilder> {
  _$DoujinActivitySingle _$v;

  TimelineUserInfoBuilder _user;

  TimelineUserInfoBuilder get user =>
      _$this._user ??= new TimelineUserInfoBuilder();

  set user(TimelineUserInfoBuilder user) => _$this._user = user;

  String _url;

  String get url => _$this._url;

  set url(String url) => _$this._url = url;

  String _activityTargetName;

  String get activityTargetName => _$this._activityTargetName;

  set activityTargetName(String activityTargetName) =>
      _$this._activityTargetName = activityTargetName;

  String _imageUrl;

  String get imageUrl => _$this._imageUrl;

  set imageUrl(String imageUrl) => _$this._imageUrl = imageUrl;

  DoujinActivitySingleBuilder();

  DoujinActivitySingleBuilder get _$this {
    if (_$v != null) {
      _user = _$v.user?.toBuilder();
      _url = _$v.url;
      _activityTargetName = _$v.activityTargetName;
      _imageUrl = _$v.imageUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DoujinActivitySingle other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DoujinActivitySingle;
  }

  @override
  void update(void updates(DoujinActivitySingleBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$DoujinActivitySingle build() {
    _$DoujinActivitySingle _$result;
    try {
      _$result = _$v ??
          new _$DoujinActivitySingle._(
              user: user.build(),
              url: url,
              activityTargetName: activityTargetName,
              imageUrl: imageUrl);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DoujinActivitySingle', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
