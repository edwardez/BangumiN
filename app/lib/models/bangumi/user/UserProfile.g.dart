// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserProfile.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserProfile> _$userProfileSerializer = new _$UserProfileSerializer();

class _$UserProfileSerializer implements StructuredSerializer<UserProfile> {
  @override
  final Iterable<Type> types = const [UserProfile, _$UserProfile];
  @override
  final String wireName = 'UserProfile';

  @override
  Iterable serialize(Serializers serializers, UserProfile object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'introductionElement',
      serializers.serialize(object.introductionElement,
          specifiedType: const FullType(Element)),
      'networkServiceTags',
      serializers.serialize(object.networkServiceTags,
          specifiedType: const FullType(
              BuiltList, const [const FullType(NetworkServiceTag)])),
      'collectionPreviews',
      serializers.serialize(object.collectionPreviews,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(SubjectType),
            const FullType(CollectionPreview)
          ])),
      'timelinePreviews',
      serializers.serialize(object.timelinePreviews,
          specifiedType: const FullType(
              BuiltList, const [const FullType(TimelinePreview)])),
      'relationships',
      serializers.serialize(object.relationships,
          specifiedType:
              const FullType(BuiltSet, const [const FullType(Relationship)])),
    ];
    if (object.basicInfo != null) {
      result
        ..add('basicInfo')
        ..add(serializers.serialize(object.basicInfo,
            specifiedType: const FullType(BangumiUserBasic)));
    }

    return result;
  }

  @override
  UserProfile deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserProfileBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'introductionElement':
          result.introductionElement = serializers.deserialize(value,
              specifiedType: const FullType(Element)) as Element;
          break;
        case 'basicInfo':
          result.basicInfo.replace(serializers.deserialize(value,
                  specifiedType: const FullType(BangumiUserBasic))
              as BangumiUserBasic);
          break;
        case 'networkServiceTags':
          result.networkServiceTags.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(NetworkServiceTag)]))
              as BuiltList);
          break;
        case 'collectionPreviews':
          result.collectionPreviews.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(SubjectType),
                const FullType(CollectionPreview)
              ])) as BuiltMap);
          break;
        case 'timelinePreviews':
          result.timelinePreviews.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TimelinePreview)]))
              as BuiltList);
          break;
        case 'relationships':
          result.relationships.replace(serializers.deserialize(value,
              specifiedType: const FullType(
                  BuiltSet, const [const FullType(Relationship)])) as BuiltSet);
          break;
      }
    }

    return result.build();
  }
}

class _$UserProfile extends UserProfile {
  @override
  final Element introductionElement;
  @override
  final BangumiUserBasic basicInfo;
  @override
  final BuiltList<NetworkServiceTag> networkServiceTags;
  @override
  final BuiltMap<SubjectType, CollectionPreview> collectionPreviews;
  @override
  final BuiltList<TimelinePreview> timelinePreviews;
  @override
  final BuiltSet<Relationship> relationships;

  factory _$UserProfile([void Function(UserProfileBuilder) updates]) =>
      (new UserProfileBuilder()..update(updates)).build();

  _$UserProfile._(
      {this.introductionElement,
      this.basicInfo,
      this.networkServiceTags,
      this.collectionPreviews,
      this.timelinePreviews,
      this.relationships})
      : super._() {
    if (introductionElement == null) {
      throw new BuiltValueNullFieldError('UserProfile', 'introductionElement');
    }
    if (networkServiceTags == null) {
      throw new BuiltValueNullFieldError('UserProfile', 'networkServiceTags');
    }
    if (collectionPreviews == null) {
      throw new BuiltValueNullFieldError('UserProfile', 'collectionPreviews');
    }
    if (timelinePreviews == null) {
      throw new BuiltValueNullFieldError('UserProfile', 'timelinePreviews');
    }
    if (relationships == null) {
      throw new BuiltValueNullFieldError('UserProfile', 'relationships');
    }
  }

  @override
  UserProfile rebuild(void Function(UserProfileBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserProfileBuilder toBuilder() => new UserProfileBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserProfile &&
        introductionElement == other.introductionElement &&
        basicInfo == other.basicInfo &&
        networkServiceTags == other.networkServiceTags &&
        collectionPreviews == other.collectionPreviews &&
        timelinePreviews == other.timelinePreviews &&
        relationships == other.relationships;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc(0, introductionElement.hashCode),
                        basicInfo.hashCode),
                    networkServiceTags.hashCode),
                collectionPreviews.hashCode),
            timelinePreviews.hashCode),
        relationships.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserProfile')
          ..add('introductionElement', introductionElement)
          ..add('basicInfo', basicInfo)
          ..add('networkServiceTags', networkServiceTags)
          ..add('collectionPreviews', collectionPreviews)
          ..add('timelinePreviews', timelinePreviews)
          ..add('relationships', relationships))
        .toString();
  }
}

class UserProfileBuilder implements Builder<UserProfile, UserProfileBuilder> {
  _$UserProfile _$v;

  Element _introductionElement;
  Element get introductionElement => _$this._introductionElement;
  set introductionElement(Element introductionElement) =>
      _$this._introductionElement = introductionElement;

  BangumiUserBasicBuilder _basicInfo;
  BangumiUserBasicBuilder get basicInfo =>
      _$this._basicInfo ??= new BangumiUserBasicBuilder();
  set basicInfo(BangumiUserBasicBuilder basicInfo) =>
      _$this._basicInfo = basicInfo;

  ListBuilder<NetworkServiceTag> _networkServiceTags;
  ListBuilder<NetworkServiceTag> get networkServiceTags =>
      _$this._networkServiceTags ??= new ListBuilder<NetworkServiceTag>();
  set networkServiceTags(ListBuilder<NetworkServiceTag> networkServiceTags) =>
      _$this._networkServiceTags = networkServiceTags;

  MapBuilder<SubjectType, CollectionPreview> _collectionPreviews;
  MapBuilder<SubjectType, CollectionPreview> get collectionPreviews =>
      _$this._collectionPreviews ??=
          new MapBuilder<SubjectType, CollectionPreview>();
  set collectionPreviews(
          MapBuilder<SubjectType, CollectionPreview> collectionPreviews) =>
      _$this._collectionPreviews = collectionPreviews;

  ListBuilder<TimelinePreview> _timelinePreviews;
  ListBuilder<TimelinePreview> get timelinePreviews =>
      _$this._timelinePreviews ??= new ListBuilder<TimelinePreview>();
  set timelinePreviews(ListBuilder<TimelinePreview> timelinePreviews) =>
      _$this._timelinePreviews = timelinePreviews;

  SetBuilder<Relationship> _relationships;
  SetBuilder<Relationship> get relationships =>
      _$this._relationships ??= new SetBuilder<Relationship>();
  set relationships(SetBuilder<Relationship> relationships) =>
      _$this._relationships = relationships;

  UserProfileBuilder();

  UserProfileBuilder get _$this {
    if (_$v != null) {
      _introductionElement = _$v.introductionElement;
      _basicInfo = _$v.basicInfo?.toBuilder();
      _networkServiceTags = _$v.networkServiceTags?.toBuilder();
      _collectionPreviews = _$v.collectionPreviews?.toBuilder();
      _timelinePreviews = _$v.timelinePreviews?.toBuilder();
      _relationships = _$v.relationships?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserProfile other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserProfile;
  }

  @override
  void update(void Function(UserProfileBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserProfile build() {
    _$UserProfile _$result;
    try {
      _$result = _$v ??
          new _$UserProfile._(
              introductionElement: introductionElement,
              basicInfo: _basicInfo?.build(),
              networkServiceTags: networkServiceTags.build(),
              collectionPreviews: collectionPreviews.build(),
              timelinePreviews: timelinePreviews.build(),
              relationships: relationships.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'basicInfo';
        _basicInfo?.build();
        _$failedField = 'networkServiceTags';
        networkServiceTags.build();
        _$failedField = 'collectionPreviews';
        collectionPreviews.build();
        _$failedField = 'timelinePreviews';
        timelinePreviews.build();
        _$failedField = 'relationships';
        relationships.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserProfile', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
