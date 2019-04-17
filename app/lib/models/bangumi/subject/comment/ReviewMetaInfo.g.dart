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
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
    ];
    if (object.images != null) {
      result
        ..add('images')
        ..add(serializers.serialize(object.images,
            specifiedType: const FullType(Images)));
    }
    if (object.score != null) {
      result
        ..add('score')
        ..add(serializers.serialize(object.score,
            specifiedType: const FullType(double)));
    }
    if (object.avatarImageUrl != null) {
      result
        ..add('avatarImageUrl')
        ..add(serializers.serialize(object.avatarImageUrl,
            specifiedType: const FullType(String)));
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
        case 'images':
          result.images.replace(serializers.deserialize(value,
              specifiedType: const FullType(Images)) as Images);
          break;
        case 'score':
          result.score = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'nickName':
          result.nickName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'avatarImageUrl':
          result.avatarImageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
  final Images images;
  @override
  final double score;
  @override
  final int updatedAt;
  @override
  final String nickName;
  @override
  final String avatarImageUrl;
  @override
  final String username;
  @override
  final String actionName;

  factory _$ReviewMetaInfo([void Function(ReviewMetaInfoBuilder) updates]) =>
      (new ReviewMetaInfoBuilder()..update(updates)).build();

  _$ReviewMetaInfo._(
      {this.images,
      this.score,
      this.updatedAt,
      this.nickName,
      this.avatarImageUrl,
      this.username,
      this.actionName})
      : super._() {
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('ReviewMetaInfo', 'updatedAt');
    }
    if (nickName == null) {
      throw new BuiltValueNullFieldError('ReviewMetaInfo', 'nickName');
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
        images == other.images &&
        score == other.score &&
        updatedAt == other.updatedAt &&
        nickName == other.nickName &&
        avatarImageUrl == other.avatarImageUrl &&
        username == other.username &&
        actionName == other.actionName;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, images.hashCode), score.hashCode),
                        updatedAt.hashCode),
                    nickName.hashCode),
                avatarImageUrl.hashCode),
            username.hashCode),
        actionName.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ReviewMetaInfo')
          ..add('images', images)
          ..add('score', score)
          ..add('updatedAt', updatedAt)
          ..add('nickName', nickName)
          ..add('avatarImageUrl', avatarImageUrl)
          ..add('username', username)
          ..add('actionName', actionName))
        .toString();
  }
}

class ReviewMetaInfoBuilder
    implements Builder<ReviewMetaInfo, ReviewMetaInfoBuilder> {
  _$ReviewMetaInfo _$v;

  ImagesBuilder _images;
  ImagesBuilder get images => _$this._images ??= new ImagesBuilder();
  set images(ImagesBuilder images) => _$this._images = images;

  double _score;
  double get score => _$this._score;
  set score(double score) => _$this._score = score;

  int _updatedAt;
  int get updatedAt => _$this._updatedAt;
  set updatedAt(int updatedAt) => _$this._updatedAt = updatedAt;

  String _nickName;
  String get nickName => _$this._nickName;
  set nickName(String nickName) => _$this._nickName = nickName;

  String _avatarImageUrl;
  String get avatarImageUrl => _$this._avatarImageUrl;
  set avatarImageUrl(String avatarImageUrl) =>
      _$this._avatarImageUrl = avatarImageUrl;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  String _actionName;
  String get actionName => _$this._actionName;
  set actionName(String actionName) => _$this._actionName = actionName;

  ReviewMetaInfoBuilder();

  ReviewMetaInfoBuilder get _$this {
    if (_$v != null) {
      _images = _$v.images?.toBuilder();
      _score = _$v.score;
      _updatedAt = _$v.updatedAt;
      _nickName = _$v.nickName;
      _avatarImageUrl = _$v.avatarImageUrl;
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
              images: _images?.build(),
              score: score,
              updatedAt: updatedAt,
              nickName: nickName,
              avatarImageUrl: avatarImageUrl,
              username: username,
              actionName: actionName);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'images';
        _images?.build();
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
