// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MonoFavoriteSingle.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<MonoFavoriteSingle> _$monoFavoriteSingleSerializer =
    new _$MonoFavoriteSingleSerializer();

class _$MonoFavoriteSingleSerializer
    implements StructuredSerializer<MonoFavoriteSingle> {
  @override
  final Iterable<Type> types = const [MonoFavoriteSingle, _$MonoFavoriteSingle];
  @override
  final String wireName = 'MonoFavoriteSingle';

  @override
  Iterable serialize(Serializers serializers, MonoFavoriteSingle object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'user',
      serializers.serialize(object.user,
          specifiedType: const FullType(FeedMetaInfo)),
      'monoName',
      serializers.serialize(object.monoName,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'monoType',
      serializers.serialize(object.monoType,
          specifiedType: const FullType(Mono)),
    ];
    if (object.monoAvatarImageUrl != null) {
      result
        ..add('monoAvatarImageUrl')
        ..add(serializers.serialize(object.monoAvatarImageUrl,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  MonoFavoriteSingle deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MonoFavoriteSingleBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'user':
          result.user.replace(serializers.deserialize(value,
              specifiedType: const FullType(FeedMetaInfo)) as FeedMetaInfo);
          break;
        case 'monoName':
          result.monoName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'monoAvatarImageUrl':
          result.monoAvatarImageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'monoType':
          result.monoType = serializers.deserialize(value,
              specifiedType: const FullType(Mono)) as Mono;
          break;
      }
    }

    return result.build();
  }
}

class _$MonoFavoriteSingle extends MonoFavoriteSingle {
  @override
  final FeedMetaInfo user;
  @override
  final String monoName;
  @override
  final String monoAvatarImageUrl;
  @override
  final String id;
  @override
  final Mono monoType;

  factory _$MonoFavoriteSingle([void updates(MonoFavoriteSingleBuilder b)]) =>
      (new MonoFavoriteSingleBuilder()..update(updates)).build();

  _$MonoFavoriteSingle._(
      {this.user,
      this.monoName,
      this.monoAvatarImageUrl,
      this.id,
      this.monoType})
      : super._() {
    if (user == null) {
      throw new BuiltValueNullFieldError('MonoFavoriteSingle', 'user');
    }
    if (monoName == null) {
      throw new BuiltValueNullFieldError('MonoFavoriteSingle', 'monoName');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('MonoFavoriteSingle', 'id');
    }
    if (monoType == null) {
      throw new BuiltValueNullFieldError('MonoFavoriteSingle', 'monoType');
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
        id == other.id &&
        monoType == other.monoType;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, user.hashCode), monoName.hashCode),
                monoAvatarImageUrl.hashCode),
            id.hashCode),
        monoType.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MonoFavoriteSingle')
          ..add('user', user)
          ..add('monoName', monoName)
          ..add('monoAvatarImageUrl', monoAvatarImageUrl)
          ..add('id', id)
          ..add('monoType', monoType))
        .toString();
  }
}

class MonoFavoriteSingleBuilder
    implements Builder<MonoFavoriteSingle, MonoFavoriteSingleBuilder> {
  _$MonoFavoriteSingle _$v;

  FeedMetaInfoBuilder _user;
  FeedMetaInfoBuilder get user => _$this._user ??= new FeedMetaInfoBuilder();
  set user(FeedMetaInfoBuilder user) => _$this._user = user;

  String _monoName;
  String get monoName => _$this._monoName;
  set monoName(String monoName) => _$this._monoName = monoName;

  String _monoAvatarImageUrl;
  String get monoAvatarImageUrl => _$this._monoAvatarImageUrl;
  set monoAvatarImageUrl(String monoAvatarImageUrl) =>
      _$this._monoAvatarImageUrl = monoAvatarImageUrl;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  Mono _monoType;
  Mono get monoType => _$this._monoType;
  set monoType(Mono monoType) => _$this._monoType = monoType;

  MonoFavoriteSingleBuilder();

  MonoFavoriteSingleBuilder get _$this {
    if (_$v != null) {
      _user = _$v.user?.toBuilder();
      _monoName = _$v.monoName;
      _monoAvatarImageUrl = _$v.monoAvatarImageUrl;
      _id = _$v.id;
      _monoType = _$v.monoType;
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
              id: id,
              monoType: monoType);
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
