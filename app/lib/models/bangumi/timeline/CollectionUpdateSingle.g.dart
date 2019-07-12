// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CollectionUpdateSingle.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CollectionUpdateSingle> _$collectionUpdateSingleSerializer =
    new _$CollectionUpdateSingleSerializer();

class _$CollectionUpdateSingleSerializer
    implements StructuredSerializer<CollectionUpdateSingle> {
  @override
  final Iterable<Type> types = const [
    CollectionUpdateSingle,
    _$CollectionUpdateSingle
  ];
  @override
  final String wireName = 'CollectionUpdateSingle';

  @override
  Iterable serialize(Serializers serializers, CollectionUpdateSingle object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'user',
      serializers.serialize(object.user,
          specifiedType: const FullType(FeedMetaInfo)),
      'subjectId',
      serializers.serialize(object.subjectId,
          specifiedType: const FullType(String)),
      'subjectCover',
      serializers.serialize(object.subjectCover,
          specifiedType: const FullType(BangumiImage)),
      'subjectName',
      serializers.serialize(object.subjectName,
          specifiedType: const FullType(String)),
      'bangumiContent',
      serializers.serialize(object.bangumiContent,
          specifiedType: const FullType(BangumiContent)),
    ];
    if (object.subjectComment != null) {
      result
        ..add('subjectComment')
        ..add(serializers.serialize(object.subjectComment,
            specifiedType: const FullType(String)));
    }
    if (object.subjectScore != null) {
      result
        ..add('subjectScore')
        ..add(serializers.serialize(object.subjectScore,
            specifiedType: const FullType(double)));
    }
    if (object.isFromMutedUser != null) {
      result
        ..add('isFromMutedUser')
        ..add(serializers.serialize(object.isFromMutedUser,
            specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  CollectionUpdateSingle deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CollectionUpdateSingleBuilder();

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
        case 'subjectComment':
          result.subjectComment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'subjectId':
          result.subjectId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'subjectCover':
          result.subjectCover.replace(serializers.deserialize(value,
              specifiedType: const FullType(BangumiImage)) as BangumiImage);
          break;
        case 'subjectScore':
          result.subjectScore = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'subjectName':
          result.subjectName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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

class _$CollectionUpdateSingle extends CollectionUpdateSingle {
  @override
  final FeedMetaInfo user;
  @override
  final String subjectComment;
  @override
  final String subjectId;
  @override
  final BangumiImage subjectCover;
  @override
  final double subjectScore;
  @override
  final String subjectName;
  @override
  final BangumiContent bangumiContent;
  @override
  final bool isFromMutedUser;

  factory _$CollectionUpdateSingle(
          [void Function(CollectionUpdateSingleBuilder) updates]) =>
      (new CollectionUpdateSingleBuilder()..update(updates)).build();

  _$CollectionUpdateSingle._(
      {this.user,
      this.subjectComment,
      this.subjectId,
      this.subjectCover,
      this.subjectScore,
      this.subjectName,
      this.bangumiContent,
      this.isFromMutedUser})
      : super._() {
    if (user == null) {
      throw new BuiltValueNullFieldError('CollectionUpdateSingle', 'user');
    }
    if (subjectId == null) {
      throw new BuiltValueNullFieldError('CollectionUpdateSingle', 'subjectId');
    }
    if (subjectCover == null) {
      throw new BuiltValueNullFieldError(
          'CollectionUpdateSingle', 'subjectCover');
    }
    if (subjectName == null) {
      throw new BuiltValueNullFieldError(
          'CollectionUpdateSingle', 'subjectName');
    }
    if (bangumiContent == null) {
      throw new BuiltValueNullFieldError(
          'CollectionUpdateSingle', 'bangumiContent');
    }
  }

  @override
  CollectionUpdateSingle rebuild(
          void Function(CollectionUpdateSingleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CollectionUpdateSingleBuilder toBuilder() =>
      new CollectionUpdateSingleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CollectionUpdateSingle &&
        user == other.user &&
        subjectComment == other.subjectComment &&
        subjectId == other.subjectId &&
        subjectCover == other.subjectCover &&
        subjectScore == other.subjectScore &&
        subjectName == other.subjectName &&
        bangumiContent == other.bangumiContent &&
        isFromMutedUser == other.isFromMutedUser;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, user.hashCode), subjectComment.hashCode),
                            subjectId.hashCode),
                        subjectCover.hashCode),
                    subjectScore.hashCode),
                subjectName.hashCode),
            bangumiContent.hashCode),
        isFromMutedUser.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CollectionUpdateSingle')
          ..add('user', user)
          ..add('subjectComment', subjectComment)
          ..add('subjectId', subjectId)
          ..add('subjectCover', subjectCover)
          ..add('subjectScore', subjectScore)
          ..add('subjectName', subjectName)
          ..add('bangumiContent', bangumiContent)
          ..add('isFromMutedUser', isFromMutedUser))
        .toString();
  }
}

class CollectionUpdateSingleBuilder
    implements
        Builder<CollectionUpdateSingle, CollectionUpdateSingleBuilder>,
        TimelineFeedBuilder {
  _$CollectionUpdateSingle _$v;

  FeedMetaInfoBuilder _user;
  FeedMetaInfoBuilder get user => _$this._user ??= new FeedMetaInfoBuilder();
  set user(FeedMetaInfoBuilder user) => _$this._user = user;

  String _subjectComment;
  String get subjectComment => _$this._subjectComment;
  set subjectComment(String subjectComment) =>
      _$this._subjectComment = subjectComment;

  String _subjectId;
  String get subjectId => _$this._subjectId;
  set subjectId(String subjectId) => _$this._subjectId = subjectId;

  BangumiImageBuilder _subjectCover;
  BangumiImageBuilder get subjectCover =>
      _$this._subjectCover ??= new BangumiImageBuilder();
  set subjectCover(BangumiImageBuilder subjectCover) =>
      _$this._subjectCover = subjectCover;

  double _subjectScore;
  double get subjectScore => _$this._subjectScore;
  set subjectScore(double subjectScore) => _$this._subjectScore = subjectScore;

  String _subjectName;
  String get subjectName => _$this._subjectName;
  set subjectName(String subjectName) => _$this._subjectName = subjectName;

  BangumiContent _bangumiContent;
  BangumiContent get bangumiContent => _$this._bangumiContent;
  set bangumiContent(BangumiContent bangumiContent) =>
      _$this._bangumiContent = bangumiContent;

  bool _isFromMutedUser;
  bool get isFromMutedUser => _$this._isFromMutedUser;
  set isFromMutedUser(bool isFromMutedUser) =>
      _$this._isFromMutedUser = isFromMutedUser;

  CollectionUpdateSingleBuilder();

  CollectionUpdateSingleBuilder get _$this {
    if (_$v != null) {
      _user = _$v.user?.toBuilder();
      _subjectComment = _$v.subjectComment;
      _subjectId = _$v.subjectId;
      _subjectCover = _$v.subjectCover?.toBuilder();
      _subjectScore = _$v.subjectScore;
      _subjectName = _$v.subjectName;
      _bangumiContent = _$v.bangumiContent;
      _isFromMutedUser = _$v.isFromMutedUser;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant CollectionUpdateSingle other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CollectionUpdateSingle;
  }

  @override
  void update(void Function(CollectionUpdateSingleBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CollectionUpdateSingle build() {
    _$CollectionUpdateSingle _$result;
    try {
      _$result = _$v ??
          new _$CollectionUpdateSingle._(
              user: user.build(),
              subjectComment: subjectComment,
              subjectId: subjectId,
              subjectCover: subjectCover.build(),
              subjectScore: subjectScore,
              subjectName: subjectName,
              bangumiContent: bangumiContent,
              isFromMutedUser: isFromMutedUser);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        user.build();

        _$failedField = 'subjectCover';
        subjectCover.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CollectionUpdateSingle', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
