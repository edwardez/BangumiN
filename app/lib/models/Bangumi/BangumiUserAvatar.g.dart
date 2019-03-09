// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BangumiUserAvatar.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BangumiUserAvatar> _$bangumiUserAvatarSerializer =
    new _$BangumiUserAvatarSerializer();

class _$BangumiUserAvatarSerializer
    implements StructuredSerializer<BangumiUserAvatar> {
  @override
  final Iterable<Type> types = const [BangumiUserAvatar, _$BangumiUserAvatar];
  @override
  final String wireName = 'BangumiUserAvatar';

  @override
  Iterable serialize(Serializers serializers, BangumiUserAvatar object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'large',
      serializers.serialize(object.large,
          specifiedType: const FullType(String)),
      'medium',
      serializers.serialize(object.medium,
          specifiedType: const FullType(String)),
      'small',
      serializers.serialize(object.small,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  BangumiUserAvatar deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BangumiUserAvatarBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'large':
          result.large = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'medium':
          result.medium = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'small':
          result.small = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$BangumiUserAvatar extends BangumiUserAvatar {
  @override
  final String large;
  @override
  final String medium;
  @override
  final String small;

  factory _$BangumiUserAvatar([void updates(BangumiUserAvatarBuilder b)]) =>
      (new BangumiUserAvatarBuilder()..update(updates)).build();

  _$BangumiUserAvatar._({this.large, this.medium, this.small}) : super._() {
    if (large == null) {
      throw new BuiltValueNullFieldError('BangumiUserAvatar', 'large');
    }
    if (medium == null) {
      throw new BuiltValueNullFieldError('BangumiUserAvatar', 'medium');
    }
    if (small == null) {
      throw new BuiltValueNullFieldError('BangumiUserAvatar', 'small');
    }
  }

  @override
  BangumiUserAvatar rebuild(void updates(BangumiUserAvatarBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  BangumiUserAvatarBuilder toBuilder() =>
      new BangumiUserAvatarBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BangumiUserAvatar &&
        large == other.large &&
        medium == other.medium &&
        small == other.small;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, large.hashCode), medium.hashCode), small.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BangumiUserAvatar')
          ..add('large', large)
          ..add('medium', medium)
          ..add('small', small))
        .toString();
  }
}

class BangumiUserAvatarBuilder
    implements Builder<BangumiUserAvatar, BangumiUserAvatarBuilder> {
  _$BangumiUserAvatar _$v;

  String _large;

  String get large => _$this._large;

  set large(String large) => _$this._large = large;

  String _medium;

  String get medium => _$this._medium;

  set medium(String medium) => _$this._medium = medium;

  String _small;

  String get small => _$this._small;

  set small(String small) => _$this._small = small;

  BangumiUserAvatarBuilder();

  BangumiUserAvatarBuilder get _$this {
    if (_$v != null) {
      _large = _$v.large;
      _medium = _$v.medium;
      _small = _$v.small;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BangumiUserAvatar other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BangumiUserAvatar;
  }

  @override
  void update(void updates(BangumiUserAvatarBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$BangumiUserAvatar build() {
    final _$result = _$v ??
        new _$BangumiUserAvatar._(large: large, medium: medium, small: small);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
