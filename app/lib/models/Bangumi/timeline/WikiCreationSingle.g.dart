// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WikiCreationSingle.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WikiCreationSingle extends WikiCreationSingle {
  @override
  final TimelineUserInfo user;
  @override
  final String newItemName;
  @override
  final int newItemId;

  factory _$WikiCreationSingle([void updates(WikiCreationSingleBuilder b)]) =>
      (new WikiCreationSingleBuilder()..update(updates)).build();

  _$WikiCreationSingle._({this.user, this.newItemName, this.newItemId})
      : super._() {
    if (user == null) {
      throw new BuiltValueNullFieldError('WikiCreationSingle', 'user');
    }
    if (newItemName == null) {
      throw new BuiltValueNullFieldError('WikiCreationSingle', 'newItemName');
    }
    if (newItemId == null) {
      throw new BuiltValueNullFieldError('WikiCreationSingle', 'newItemId');
    }
  }

  @override
  WikiCreationSingle rebuild(void updates(WikiCreationSingleBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  WikiCreationSingleBuilder toBuilder() =>
      new WikiCreationSingleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WikiCreationSingle &&
        user == other.user &&
        newItemName == other.newItemName &&
        newItemId == other.newItemId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, user.hashCode), newItemName.hashCode), newItemId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WikiCreationSingle')
          ..add('user', user)
          ..add('newItemName', newItemName)
          ..add('newItemId', newItemId))
        .toString();
  }
}

class WikiCreationSingleBuilder
    implements Builder<WikiCreationSingle, WikiCreationSingleBuilder> {
  _$WikiCreationSingle _$v;

  TimelineUserInfoBuilder _user;

  TimelineUserInfoBuilder get user =>
      _$this._user ??= new TimelineUserInfoBuilder();

  set user(TimelineUserInfoBuilder user) => _$this._user = user;

  String _newItemName;

  String get newItemName => _$this._newItemName;

  set newItemName(String newItemName) => _$this._newItemName = newItemName;

  int _newItemId;

  int get newItemId => _$this._newItemId;

  set newItemId(int newItemId) => _$this._newItemId = newItemId;

  WikiCreationSingleBuilder();

  WikiCreationSingleBuilder get _$this {
    if (_$v != null) {
      _user = _$v.user?.toBuilder();
      _newItemName = _$v.newItemName;
      _newItemId = _$v.newItemId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WikiCreationSingle other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$WikiCreationSingle;
  }

  @override
  void update(void updates(WikiCreationSingleBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$WikiCreationSingle build() {
    _$WikiCreationSingle _$result;
    try {
      _$result = _$v ??
          new _$WikiCreationSingle._(
              user: user.build(),
              newItemName: newItemName,
              newItemId: newItemId);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'WikiCreationSingle', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
