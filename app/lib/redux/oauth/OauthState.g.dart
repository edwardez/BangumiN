// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OauthState.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OauthState> _$oauthStateSerializer = new _$OauthStateSerializer();

class _$OauthStateSerializer implements StructuredSerializer<OauthState> {
  @override
  final Iterable<Type> types = const [OauthState, _$OauthState];
  @override
  final String wireName = 'OauthState';

  @override
  Iterable serialize(Serializers serializers, OauthState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.showLoginErrorSnackBar != null) {
      result
        ..add('showLoginErrorSnackBar')
        ..add(serializers.serialize(object.showLoginErrorSnackBar,
            specifiedType: const FullType(bool)));
    }
    if (object.oauthFailureMessage != null) {
      result
        ..add('oauthFailureMessage')
        ..add(serializers.serialize(object.oauthFailureMessage,
            specifiedType: const FullType(String)));
    }
    if (object.error != null) {
      result
        ..add('error')
        ..add(serializers.serialize(object.error,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  OauthState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OauthStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'showLoginErrorSnackBar':
          result.showLoginErrorSnackBar = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'oauthFailureMessage':
          result.oauthFailureMessage = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'error':
          result.error = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$OauthState extends OauthState {
  @override
  final bool showLoginErrorSnackBar;
  @override
  final String oauthFailureMessage;
  @override
  final String error;

  factory _$OauthState([void Function(OauthStateBuilder) updates]) =>
      (new OauthStateBuilder()..update(updates)).build();

  _$OauthState._(
      {this.showLoginErrorSnackBar, this.oauthFailureMessage, this.error})
      : super._();

  @override
  OauthState rebuild(void Function(OauthStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OauthStateBuilder toBuilder() => new OauthStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OauthState &&
        showLoginErrorSnackBar == other.showLoginErrorSnackBar &&
        oauthFailureMessage == other.oauthFailureMessage &&
        error == other.error;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, showLoginErrorSnackBar.hashCode),
            oauthFailureMessage.hashCode),
        error.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OauthState')
          ..add('showLoginErrorSnackBar', showLoginErrorSnackBar)
          ..add('oauthFailureMessage', oauthFailureMessage)
          ..add('error', error))
        .toString();
  }
}

class OauthStateBuilder implements Builder<OauthState, OauthStateBuilder> {
  _$OauthState _$v;

  bool _showLoginErrorSnackBar;
  bool get showLoginErrorSnackBar => _$this._showLoginErrorSnackBar;
  set showLoginErrorSnackBar(bool showLoginErrorSnackBar) =>
      _$this._showLoginErrorSnackBar = showLoginErrorSnackBar;

  String _oauthFailureMessage;
  String get oauthFailureMessage => _$this._oauthFailureMessage;
  set oauthFailureMessage(String oauthFailureMessage) =>
      _$this._oauthFailureMessage = oauthFailureMessage;

  String _error;
  String get error => _$this._error;
  set error(String error) => _$this._error = error;

  OauthStateBuilder();

  OauthStateBuilder get _$this {
    if (_$v != null) {
      _showLoginErrorSnackBar = _$v.showLoginErrorSnackBar;
      _oauthFailureMessage = _$v.oauthFailureMessage;
      _error = _$v.error;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OauthState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OauthState;
  }

  @override
  void update(void Function(OauthStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OauthState build() {
    final _$result = _$v ??
        new _$OauthState._(
            showLoginErrorSnackBar: showLoginErrorSnackBar,
            oauthFailureMessage: oauthFailureMessage,
            error: error);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
