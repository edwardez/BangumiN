// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppState.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppState extends AppState {
  @override
  final BangumiUserBasic currentAuthenticatedUserBasicInfo;
  @override
  final bool isAuthenticated;
  @override
  final OauthState oauthState;

  factory _$AppState([void updates(AppStateBuilder b)]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._(
      {this.currentAuthenticatedUserBasicInfo,
      this.isAuthenticated,
      this.oauthState})
      : super._() {
    if (isAuthenticated == null) {
      throw new BuiltValueNullFieldError('AppState', 'isAuthenticated');
    }
    if (oauthState == null) {
      throw new BuiltValueNullFieldError('AppState', 'oauthState');
    }
  }

  @override
  AppState rebuild(void updates(AppStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppState &&
        currentAuthenticatedUserBasicInfo ==
            other.currentAuthenticatedUserBasicInfo &&
        isAuthenticated == other.isAuthenticated &&
        oauthState == other.oauthState;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, currentAuthenticatedUserBasicInfo.hashCode),
            isAuthenticated.hashCode),
        oauthState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('currentAuthenticatedUserBasicInfo',
              currentAuthenticatedUserBasicInfo)
          ..add('isAuthenticated', isAuthenticated)
          ..add('oauthState', oauthState))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  BangumiUserBasicBuilder _currentAuthenticatedUserBasicInfo;
  BangumiUserBasicBuilder get currentAuthenticatedUserBasicInfo =>
      _$this._currentAuthenticatedUserBasicInfo ??=
          new BangumiUserBasicBuilder();
  set currentAuthenticatedUserBasicInfo(
          BangumiUserBasicBuilder currentAuthenticatedUserBasicInfo) =>
      _$this._currentAuthenticatedUserBasicInfo =
          currentAuthenticatedUserBasicInfo;

  bool _isAuthenticated;
  bool get isAuthenticated => _$this._isAuthenticated;
  set isAuthenticated(bool isAuthenticated) =>
      _$this._isAuthenticated = isAuthenticated;

  OauthStateBuilder _oauthState;
  OauthStateBuilder get oauthState =>
      _$this._oauthState ??= new OauthStateBuilder();
  set oauthState(OauthStateBuilder oauthState) =>
      _$this._oauthState = oauthState;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _currentAuthenticatedUserBasicInfo =
          _$v.currentAuthenticatedUserBasicInfo?.toBuilder();
      _isAuthenticated = _$v.isAuthenticated;
      _oauthState = _$v.oauthState?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AppState;
  }

  @override
  void update(void updates(AppStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    _$AppState _$result;
    try {
      _$result = _$v ??
          new _$AppState._(
              currentAuthenticatedUserBasicInfo:
                  _currentAuthenticatedUserBasicInfo?.build(),
              isAuthenticated: isAuthenticated,
              oauthState: oauthState.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'currentAuthenticatedUserBasicInfo';
        _currentAuthenticatedUserBasicInfo?.build();

        _$failedField = 'oauthState';
        oauthState.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
