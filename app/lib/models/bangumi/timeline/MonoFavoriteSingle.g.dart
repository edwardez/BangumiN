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
  Iterable<Object> serialize(Serializers serializers, MonoFavoriteSingle object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'user',
      serializers.serialize(object.user,
          specifiedType: const FullType(FeedMetaInfo)),
      'monoName',
      serializers.serialize(object.monoName,
          specifiedType: const FullType(String)),
      'avatar',
      serializers.serialize(object.avatar,
          specifiedType: const FullType(BangumiImage)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'monoType',
      serializers.serialize(object.monoType,
          specifiedType: const FullType(Mono)),
      'bangumiContent',
      serializers.serialize(object.bangumiContent,
          specifiedType: const FullType(BangumiContent)),
    ];
    if (object.isFromMutedUser != null) {
      result
        ..add('isFromMutedUser')
        ..add(serializers.serialize(object.isFromMutedUser,
            specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  MonoFavoriteSingle deserialize(
      Serializers serializers, Iterable<Object> serialized,
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
        case 'avatar':
          result.avatar.replace(serializers.deserialize(value,
              specifiedType: const FullType(BangumiImage)) as BangumiImage);
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'monoType':
          result.monoType = serializers.deserialize(value,
              specifiedType: const FullType(Mono)) as Mono;
          break;
        case 'bangumiContent':
          result.bangumiContent = serializers.deserialize(value,
              specifiedType: const FullType(BangumiContent)) as BangumiContent;
          break;
        case 'isFromMutedUser':
          result.isFromMutedUser = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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
  final BangumiImage avatar;
  @override
  final String id;
  @override
  final Mono monoType;
  @override
  final BangumiContent bangumiContent;
  @override
  final bool isFromMutedUser;

  factory _$MonoFavoriteSingle(
          [void Function(MonoFavoriteSingleBuilder) updates]) =>
      (new MonoFavoriteSingleBuilder()..update(updates)).build();

  _$MonoFavoriteSingle._(
      {this.user,
      this.monoName,
      this.avatar,
      this.id,
      this.monoType,
      this.bangumiContent,
      this.isFromMutedUser})
      : super._() {
    if (user == null) {
      throw new BuiltValueNullFieldError('MonoFavoriteSingle', 'user');
    }
    if (monoName == null) {
      throw new BuiltValueNullFieldError('MonoFavoriteSingle', 'monoName');
    }
    if (avatar == null) {
      throw new BuiltValueNullFieldError('MonoFavoriteSingle', 'avatar');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('MonoFavoriteSingle', 'id');
    }
    if (monoType == null) {
      throw new BuiltValueNullFieldError('MonoFavoriteSingle', 'monoType');
    }
    if (bangumiContent == null) {
      throw new BuiltValueNullFieldError(
          'MonoFavoriteSingle', 'bangumiContent');
    }
  }

  @override
  MonoFavoriteSingle rebuild(
          void Function(MonoFavoriteSingleBuilder) updates) =>
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
        avatar == other.avatar &&
        id == other.id &&
        monoType == other.monoType &&
        bangumiContent == other.bangumiContent &&
        isFromMutedUser == other.isFromMutedUser;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, user.hashCode), monoName.hashCode),
                        avatar.hashCode),
                    id.hashCode),
                monoType.hashCode),
            bangumiContent.hashCode),
        isFromMutedUser.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MonoFavoriteSingle')
          ..add('user', user)
          ..add('monoName', monoName)
          ..add('avatar', avatar)
          ..add('id', id)
          ..add('monoType', monoType)
          ..add('bangumiContent', bangumiContent)
          ..add('isFromMutedUser', isFromMutedUser))
        .toString();
  }
}

class MonoFavoriteSingleBuilder
    implements
        Builder<MonoFavoriteSingle, MonoFavoriteSingleBuilder>,
        TimelineFeedBuilder {
  _$MonoFavoriteSingle _$v;

  FeedMetaInfoBuilder _user;
  FeedMetaInfoBuilder get user => _$this._user ??= new FeedMetaInfoBuilder();
  set user(FeedMetaInfoBuilder user) => _$this._user = user;

  String _monoName;
  String get monoName => _$this._monoName;
  set monoName(String monoName) => _$this._monoName = monoName;

  BangumiImageBuilder _avatar;
  BangumiImageBuilder get avatar =>
      _$this._avatar ??= new BangumiImageBuilder();
  set avatar(BangumiImageBuilder avatar) => _$this._avatar = avatar;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  Mono _monoType;
  Mono get monoType => _$this._monoType;
  set monoType(Mono monoType) => _$this._monoType = monoType;

  BangumiContent _bangumiContent;
  BangumiContent get bangumiContent => _$this._bangumiContent;
  set bangumiContent(BangumiContent bangumiContent) =>
      _$this._bangumiContent = bangumiContent;

  bool _isFromMutedUser;
  bool get isFromMutedUser => _$this._isFromMutedUser;
  set isFromMutedUser(bool isFromMutedUser) =>
      _$this._isFromMutedUser = isFromMutedUser;

  MonoFavoriteSingleBuilder();

  MonoFavoriteSingleBuilder get _$this {
    if (_$v != null) {
      _user = _$v.user?.toBuilder();
      _monoName = _$v.monoName;
      _avatar = _$v.avatar?.toBuilder();
      _id = _$v.id;
      _monoType = _$v.monoType;
      _bangumiContent = _$v.bangumiContent;
      _isFromMutedUser = _$v.isFromMutedUser;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant MonoFavoriteSingle other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MonoFavoriteSingle;
  }

  @override
  void update(void Function(MonoFavoriteSingleBuilder) updates) {
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
              avatar: avatar.build(),
              id: id,
              monoType: monoType,
              bangumiContent: bangumiContent,
              isFromMutedUser: isFromMutedUser);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        user.build();

        _$failedField = 'avatar';
        avatar.build();
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
