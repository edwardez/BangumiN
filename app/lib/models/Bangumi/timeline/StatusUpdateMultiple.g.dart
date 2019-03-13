// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StatusUpdateMultiple.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StatusUpdateMultiple extends StatusUpdateMultiple {
  @override
  final TimelineUserInfo user;
  @override
  final BuiltList<HyperImage> hyperImages;
  @override
  final BuiltList<HyperBangumiItem> hyperBangumiItems;

  factory _$StatusUpdateMultiple(
          [void updates(StatusUpdateMultipleBuilder b)]) =>
      (new StatusUpdateMultipleBuilder()..update(updates)).build();

  _$StatusUpdateMultiple._(
      {this.user, this.hyperImages, this.hyperBangumiItems})
      : super._() {
    if (user == null) {
      throw new BuiltValueNullFieldError('StatusUpdateMultiple', 'user');
    }
    if (hyperImages == null) {
      throw new BuiltValueNullFieldError('StatusUpdateMultiple', 'hyperImages');
    }
    if (hyperBangumiItems == null) {
      throw new BuiltValueNullFieldError(
          'StatusUpdateMultiple', 'hyperBangumiItems');
    }
  }

  @override
  StatusUpdateMultiple rebuild(void updates(StatusUpdateMultipleBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  StatusUpdateMultipleBuilder toBuilder() =>
      new StatusUpdateMultipleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StatusUpdateMultiple &&
        user == other.user &&
        hyperImages == other.hyperImages &&
        hyperBangumiItems == other.hyperBangumiItems;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, user.hashCode), hyperImages.hashCode),
        hyperBangumiItems.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StatusUpdateMultiple')
          ..add('user', user)
          ..add('hyperImages', hyperImages)
          ..add('hyperBangumiItems', hyperBangumiItems))
        .toString();
  }
}

class StatusUpdateMultipleBuilder
    implements Builder<StatusUpdateMultiple, StatusUpdateMultipleBuilder> {
  _$StatusUpdateMultiple _$v;

  TimelineUserInfoBuilder _user;

  TimelineUserInfoBuilder get user =>
      _$this._user ??= new TimelineUserInfoBuilder();

  set user(TimelineUserInfoBuilder user) => _$this._user = user;

  ListBuilder<HyperImage> _hyperImages;

  ListBuilder<HyperImage> get hyperImages =>
      _$this._hyperImages ??= new ListBuilder<HyperImage>();

  set hyperImages(ListBuilder<HyperImage> hyperImages) =>
      _$this._hyperImages = hyperImages;

  ListBuilder<HyperBangumiItem> _hyperBangumiItems;

  ListBuilder<HyperBangumiItem> get hyperBangumiItems =>
      _$this._hyperBangumiItems ??= new ListBuilder<HyperBangumiItem>();

  set hyperBangumiItems(ListBuilder<HyperBangumiItem> hyperBangumiItems) =>
      _$this._hyperBangumiItems = hyperBangumiItems;

  StatusUpdateMultipleBuilder();

  StatusUpdateMultipleBuilder get _$this {
    if (_$v != null) {
      _user = _$v.user?.toBuilder();
      _hyperImages = _$v.hyperImages?.toBuilder();
      _hyperBangumiItems = _$v.hyperBangumiItems?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StatusUpdateMultiple other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$StatusUpdateMultiple;
  }

  @override
  void update(void updates(StatusUpdateMultipleBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$StatusUpdateMultiple build() {
    _$StatusUpdateMultiple _$result;
    try {
      _$result = _$v ??
          new _$StatusUpdateMultiple._(
              user: user.build(),
              hyperImages: hyperImages.build(),
              hyperBangumiItems: hyperBangumiItems.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
        _$failedField = 'hyperImages';
        hyperImages.build();
        _$failedField = 'hyperBangumiItems';
        hyperBangumiItems.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'StatusUpdateMultiple', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
