// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ReviewMetaInfo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ReviewMetaInfo> _$reviewMetaInfoSerializer =
    new _$ReviewMetaInfoSerializer();

class _$ReviewMetaInfoSerializer
    implements StructuredSerializer<ReviewMetaInfo> {
  @override
  final Iterable<Type> types = const [ReviewMetaInfo, _$ReviewMetaInfo];
  @override
  final String wireName = 'ReviewMetaInfo';

  @override
  Iterable serialize(Serializers serializers, ReviewMetaInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'updatedAt',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(int)),
      'nickName',
      serializers.serialize(object.nickName,
          specifiedType: const FullType(String)),
      'avatar',
      serializers.serialize(object.avatar,
          specifiedType: const FullType(BangumiImage)),
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
    ];
    if (object.score != null) {
      result
        ..add('score')
        ..add(serializers.serialize(object.score,
            specifiedType: const FullType(double)));
    }
    if (object.collectionStatus != null) {
      result
        ..add('collectionStatus')
        ..add(serializers.serialize(object.collectionStatus,
            specifiedType: const FullType(CollectionStatus)));
    }
    if (object.actionName != null) {
      result
        ..add('actionName')
        ..add(serializers.serialize(object.actionName,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ReviewMetaInfo deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReviewMetaInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'score':
          result.score = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'collectionStatus':
          result.collectionStatus = serializers.deserialize(value,
                  specifiedType: const FullType(CollectionStatus))
              as CollectionStatus;
          break;
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'nickName':
          result.nickName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'avatar':
          result.avatar.replace(serializers.deserialize(value,
              specifiedType: const FullType(BangumiImage)) as BangumiImage);
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'actionName':
          result.actionName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ReviewMetaInfo extends ReviewMetaInfo {
  @override
  final double score;
  @override
  final CollectionStatus collectionStatus;
  @override
  final int updatedAt;
  @override
  final String nickName;
  @override
  final BangumiImage avatar;
  @override
  final String username;
  @override
  final String actionName;

  factory _$ReviewMetaInfo([void Function(ReviewMetaInfoBuilder) updates]) =>
      (new ReviewMetaInfoBuilder()..update(updates)).build();

  _$ReviewMetaInfo._(
      {this.score,
      this.collectionStatus,
      this.updatedAt,
      this.nickName,
      this.avatar,
      this.username,
      this.actionName})
      : super._() {
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('ReviewMetaInfo', 'updatedAt');
    }
    if (nickName == null) {
      throw new BuiltValueNullFieldError('ReviewMetaInfo', 'nickName');
    }
    if (avatar == null) {
      throw new BuiltValueNullFieldError('ReviewMetaInfo', 'avatar');
    }
    if (username == null) {
      throw new BuiltValueNullFieldError('ReviewMetaInfo', 'username');
    }
  }

  @override
  ReviewMetaInfo rebuild(void Function(ReviewMetaInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReviewMetaInfoBuilder toBuilder() =>
      new ReviewMetaInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewMetaInfo &&
        score == other.score &&
        collectionStatus == other.collectionStatus &&
        updatedAt == other.updatedAt &&
        nickName == other.nickName &&
        avatar == other.avatar &&
        username == other.username &&
        actionName == other.actionName;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, score.hashCode), collectionStatus.hashCode),
                        updatedAt.hashCode),
                    nickName.hashCode),
                avatar.hashCode),
            username.hashCode),
        actionName.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ReviewMetaInfo')
          ..add('score', score)
          ..add('collectionStatus', collectionStatus)
          ..add('updatedAt', updatedAt)
          ..add('nickName', nickName)
          ..add('avatar', avatar)
          ..add('username', username)
          ..add('actionName', actionName))
        .toString();
  }
}

class ReviewMetaInfoBuilder
    implements Builder<ReviewMetaInfo, ReviewMetaInfoBuilder> {
  _$ReviewMetaInfo _$v;

  double _score;
  double get score => _$this._score;
  set score(double score) => _$this._score = score;

  CollectionStatus _collectionStatus;
  CollectionStatus get collectionStatus => _$this._collectionStatus;
  set collectionStatus(CollectionStatus collectionStatus) =>
      _$this._collectionStatus = collectionStatus;

  int _updatedAt;
  int get updatedAt => _$this._updatedAt;
  set updatedAt(int updatedAt) => _$this._updatedAt = updatedAt;

  String _nickName;
  String get nickName => _$this._nickName;
  set nickName(String nickName) => _$this._nickName = nickName;

  BangumiImageBuilder _avatar;
  BangumiImageBuilder get avatar =>
      _$this._avatar ??= new BangumiImageBuilder();
  set avatar(BangumiImageBuilder avatar) => _$this._avatar = avatar;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  String _actionName;
  String get actionName => _$this._actionName;
  set actionName(String actionName) => _$this._actionName = actionName;

  ReviewMetaInfoBuilder();

  ReviewMetaInfoBuilder get _$this {
    if (_$v != null) {
      _score = _$v.score;
      _collectionStatus = _$v.collectionStatus;
      _updatedAt = _$v.updatedAt;
      _nickName = _$v.nickName;
      _avatar = _$v.avatar?.toBuilder();
      _username = _$v.username;
      _actionName = _$v.actionName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReviewMetaInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ReviewMetaInfo;
  }

  @override
  void update(void Function(ReviewMetaInfoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ReviewMetaInfo build() {
    _$ReviewMetaInfo _$result;
    try {
      _$result = _$v ??
          new _$ReviewMetaInfo._(
              score: score,
              collectionStatus: collectionStatus,
              updatedAt: updatedAt,
              nickName: nickName,
              avatar: avatar.build(),
              username: username,
              actionName: actionName);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'avatar';
        avatar.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ReviewMetaInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
