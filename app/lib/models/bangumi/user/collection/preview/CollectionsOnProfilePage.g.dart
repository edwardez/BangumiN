// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CollectionsOnProfilePage.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CollectionsOnProfilePage> _$collectionsOnProfilePageSerializer =
    new _$CollectionsOnProfilePageSerializer();

class _$CollectionsOnProfilePageSerializer
    implements StructuredSerializer<CollectionsOnProfilePage> {
  @override
  final Iterable<Type> types = const [
    CollectionsOnProfilePage,
    _$CollectionsOnProfilePage
  ];
  @override
  final String wireName = 'CollectionsOnProfilePage';

  @override
  Iterable serialize(Serializers serializers, CollectionsOnProfilePage object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'subjectType',
      serializers.serialize(object.subjectType,
          specifiedType: const FullType(SubjectType)),
      'onPlainTextPanel',
      serializers.serialize(object.onPlainTextPanel,
          specifiedType: const FullType(bool)),
      'collectionDistribution',
      serializers.serialize(object.collectionDistribution,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(CollectionStatus), const FullType(int)])),
      'subjects',
      serializers.serialize(object.subjects,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(CollectionStatus),
            const FullType(
                BuiltList, const [const FullType(SubjectBaseWithCover)])
          ])),
    ];

    return result;
  }

  @override
  CollectionsOnProfilePage deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CollectionsOnProfilePageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'subjectType':
          result.subjectType = serializers.deserialize(value,
              specifiedType: const FullType(SubjectType)) as SubjectType;
          break;
        case 'onPlainTextPanel':
          result.onPlainTextPanel = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'collectionDistribution':
          result.collectionDistribution.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(CollectionStatus),
                const FullType(int)
              ])) as BuiltMap);
          break;
        case 'subjects':
          result.subjects.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(CollectionStatus),
                const FullType(
                    BuiltList, const [const FullType(SubjectBaseWithCover)])
              ])) as BuiltMap);
          break;
      }
    }

    return result.build();
  }
}

class _$CollectionsOnProfilePage extends CollectionsOnProfilePage {
  @override
  final SubjectType subjectType;
  @override
  final bool onPlainTextPanel;
  @override
  final BuiltMap<CollectionStatus, int> collectionDistribution;
  @override
  final BuiltMap<CollectionStatus, BuiltList<SubjectBaseWithCover>> subjects;
  int __totalCollectionCount;

  factory _$CollectionsOnProfilePage(
          [void Function(CollectionsOnProfilePageBuilder) updates]) =>
      (new CollectionsOnProfilePageBuilder()..update(updates)).build();

  _$CollectionsOnProfilePage._(
      {this.subjectType,
      this.onPlainTextPanel,
      this.collectionDistribution,
      this.subjects})
      : super._() {
    if (subjectType == null) {
      throw new BuiltValueNullFieldError(
          'CollectionsOnProfilePage', 'subjectType');
    }
    if (onPlainTextPanel == null) {
      throw new BuiltValueNullFieldError(
          'CollectionsOnProfilePage', 'onPlainTextPanel');
    }
    if (collectionDistribution == null) {
      throw new BuiltValueNullFieldError(
          'CollectionsOnProfilePage', 'collectionDistribution');
    }
    if (subjects == null) {
      throw new BuiltValueNullFieldError(
          'CollectionsOnProfilePage', 'subjects');
    }
  }

  @override
  int get totalCollectionCount =>
      __totalCollectionCount ??= super.totalCollectionCount;

  @override
  CollectionsOnProfilePage rebuild(
          void Function(CollectionsOnProfilePageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CollectionsOnProfilePageBuilder toBuilder() =>
      new CollectionsOnProfilePageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CollectionsOnProfilePage &&
        subjectType == other.subjectType &&
        onPlainTextPanel == other.onPlainTextPanel &&
        collectionDistribution == other.collectionDistribution &&
        subjects == other.subjects;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, subjectType.hashCode), onPlainTextPanel.hashCode),
            collectionDistribution.hashCode),
        subjects.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CollectionsOnProfilePage')
          ..add('subjectType', subjectType)
          ..add('onPlainTextPanel', onPlainTextPanel)
          ..add('collectionDistribution', collectionDistribution)
          ..add('subjects', subjects))
        .toString();
  }
}

class CollectionsOnProfilePageBuilder
    implements
        Builder<CollectionsOnProfilePage, CollectionsOnProfilePageBuilder> {
  _$CollectionsOnProfilePage _$v;

  SubjectType _subjectType;
  SubjectType get subjectType => _$this._subjectType;
  set subjectType(SubjectType subjectType) => _$this._subjectType = subjectType;

  bool _onPlainTextPanel;
  bool get onPlainTextPanel => _$this._onPlainTextPanel;
  set onPlainTextPanel(bool onPlainTextPanel) =>
      _$this._onPlainTextPanel = onPlainTextPanel;

  MapBuilder<CollectionStatus, int> _collectionDistribution;
  MapBuilder<CollectionStatus, int> get collectionDistribution =>
      _$this._collectionDistribution ??=
          new MapBuilder<CollectionStatus, int>();
  set collectionDistribution(
          MapBuilder<CollectionStatus, int> collectionDistribution) =>
      _$this._collectionDistribution = collectionDistribution;

  MapBuilder<CollectionStatus, BuiltList<SubjectBaseWithCover>> _subjects;
  MapBuilder<CollectionStatus, BuiltList<SubjectBaseWithCover>> get subjects =>
      _$this._subjects ??=
          new MapBuilder<CollectionStatus, BuiltList<SubjectBaseWithCover>>();
  set subjects(
          MapBuilder<CollectionStatus, BuiltList<SubjectBaseWithCover>>
              subjects) =>
      _$this._subjects = subjects;

  CollectionsOnProfilePageBuilder();

  CollectionsOnProfilePageBuilder get _$this {
    if (_$v != null) {
      _subjectType = _$v.subjectType;
      _onPlainTextPanel = _$v.onPlainTextPanel;
      _collectionDistribution = _$v.collectionDistribution?.toBuilder();
      _subjects = _$v.subjects?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CollectionsOnProfilePage other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CollectionsOnProfilePage;
  }

  @override
  void update(void Function(CollectionsOnProfilePageBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CollectionsOnProfilePage build() {
    _$CollectionsOnProfilePage _$result;
    try {
      _$result = _$v ??
          new _$CollectionsOnProfilePage._(
              subjectType: subjectType,
              onPlainTextPanel: onPlainTextPanel,
              collectionDistribution: collectionDistribution.build(),
              subjects: subjects.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'collectionDistribution';
        collectionDistribution.build();
        _$failedField = 'subjects';
        subjects.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CollectionsOnProfilePage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
