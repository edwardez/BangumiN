// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectCommentMetaInfo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SubjectCommentMetaInfo> _$subjectCommentMetaInfoSerializer =
    new _$SubjectCommentMetaInfoSerializer();

class _$SubjectCommentMetaInfoSerializer
    implements StructuredSerializer<SubjectCommentMetaInfo> {
  @override
  final Iterable<Type> types = const [
    SubjectCommentMetaInfo,
    _$SubjectCommentMetaInfo
  ];
  @override
  final String wireName = 'SubjectCommentMetaInfo';

  @override
  Iterable serialize(Serializers serializers, SubjectCommentMetaInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'updatedAt',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(String)),
      'nickName',
      serializers.serialize(object.nickName,
          specifiedType: const FullType(String)),
      'userId',
      serializers.serialize(object.userId,
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
  SubjectCommentMetaInfo deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubjectCommentMetaInfoBuilder();

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
              specifiedType: const FullType(String)) as String;
          break;
        case 'nickName':
          result.nickName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'avatarImageUrl':
          result.avatarImageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
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

class _$SubjectCommentMetaInfo extends SubjectCommentMetaInfo {
  @override
  final Images images;
  @override
  final double score;
  @override
  final String updatedAt;
  @override
  final String nickName;
  @override
  final String avatarImageUrl;
  @override
  final String userId;
  @override
  final String actionName;

  factory _$SubjectCommentMetaInfo(
          [void updates(SubjectCommentMetaInfoBuilder b)]) =>
      (new SubjectCommentMetaInfoBuilder()..update(updates)).build();

  _$SubjectCommentMetaInfo._(
      {this.images,
      this.score,
      this.updatedAt,
      this.nickName,
      this.avatarImageUrl,
      this.userId,
      this.actionName})
      : super._() {
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('SubjectCommentMetaInfo', 'updatedAt');
    }
    if (nickName == null) {
      throw new BuiltValueNullFieldError('SubjectCommentMetaInfo', 'nickName');
    }
    if (userId == null) {
      throw new BuiltValueNullFieldError('SubjectCommentMetaInfo', 'userId');
    }
  }

  @override
  SubjectCommentMetaInfo rebuild(
          void updates(SubjectCommentMetaInfoBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  SubjectCommentMetaInfoBuilder toBuilder() =>
      new SubjectCommentMetaInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubjectCommentMetaInfo &&
        images == other.images &&
        score == other.score &&
        updatedAt == other.updatedAt &&
        nickName == other.nickName &&
        avatarImageUrl == other.avatarImageUrl &&
        userId == other.userId &&
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
            userId.hashCode),
        actionName.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubjectCommentMetaInfo')
          ..add('images', images)
          ..add('score', score)
          ..add('updatedAt', updatedAt)
          ..add('nickName', nickName)
          ..add('avatarImageUrl', avatarImageUrl)
          ..add('userId', userId)
          ..add('actionName', actionName))
        .toString();
  }
}

class SubjectCommentMetaInfoBuilder
    implements Builder<SubjectCommentMetaInfo, SubjectCommentMetaInfoBuilder> {
  _$SubjectCommentMetaInfo _$v;

  ImagesBuilder _images;
  ImagesBuilder get images => _$this._images ??= new ImagesBuilder();
  set images(ImagesBuilder images) => _$this._images = images;

  double _score;
  double get score => _$this._score;
  set score(double score) => _$this._score = score;

  String _updatedAt;
  String get updatedAt => _$this._updatedAt;
  set updatedAt(String updatedAt) => _$this._updatedAt = updatedAt;

  String _nickName;
  String get nickName => _$this._nickName;
  set nickName(String nickName) => _$this._nickName = nickName;

  String _avatarImageUrl;
  String get avatarImageUrl => _$this._avatarImageUrl;
  set avatarImageUrl(String avatarImageUrl) =>
      _$this._avatarImageUrl = avatarImageUrl;

  String _userId;
  String get userId => _$this._userId;
  set userId(String userId) => _$this._userId = userId;

  String _actionName;
  String get actionName => _$this._actionName;
  set actionName(String actionName) => _$this._actionName = actionName;

  SubjectCommentMetaInfoBuilder();

  SubjectCommentMetaInfoBuilder get _$this {
    if (_$v != null) {
      _images = _$v.images?.toBuilder();
      _score = _$v.score;
      _updatedAt = _$v.updatedAt;
      _nickName = _$v.nickName;
      _avatarImageUrl = _$v.avatarImageUrl;
      _userId = _$v.userId;
      _actionName = _$v.actionName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubjectCommentMetaInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubjectCommentMetaInfo;
  }

  @override
  void update(void updates(SubjectCommentMetaInfoBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$SubjectCommentMetaInfo build() {
    _$SubjectCommentMetaInfo _$result;
    try {
      _$result = _$v ??
          new _$SubjectCommentMetaInfo._(
              images: _images?.build(),
              score: score,
              updatedAt: updatedAt,
              nickName: nickName,
              avatarImageUrl: avatarImageUrl,
              userId: userId,
              actionName: actionName);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'images';
        _images?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SubjectCommentMetaInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
