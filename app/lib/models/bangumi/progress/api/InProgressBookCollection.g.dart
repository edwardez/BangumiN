// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'InProgressBookCollection.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<InProgressBookCollection> _$inProgressBookCollectionSerializer =
    new _$InProgressBookCollectionSerializer();

class _$InProgressBookCollectionSerializer
    implements StructuredSerializer<InProgressBookCollection> {
  @override
  final Iterable<Type> types = const [
    InProgressBookCollection,
    _$InProgressBookCollection
  ];
  @override
  final String wireName = 'InProgressBookCollection';

  @override
  Iterable<Object> serialize(
      Serializers serializers, InProgressBookCollection object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'ep_status',
      serializers.serialize(object.completedEpisodesCount,
          specifiedType: const FullType(int)),
      'vol_status',
      serializers.serialize(object.completedVolumesCount,
          specifiedType: const FullType(int)),
      'lasttouch',
      serializers.serialize(object.userUpdatedAt,
          specifiedType: const FullType(int)),
      'subject',
      serializers.serialize(object.subject,
          specifiedType: const FullType(InProgressSubjectInfo)),
    ];

    return result;
  }

  @override
  InProgressBookCollection deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InProgressBookCollectionBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'ep_status':
          result.completedEpisodesCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'vol_status':
          result.completedVolumesCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'lasttouch':
          result.userUpdatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'subject':
          result.subject.replace(serializers.deserialize(value,
                  specifiedType: const FullType(InProgressSubjectInfo))
              as InProgressSubjectInfo);
          break;
      }
    }

    return result.build();
  }
}

class _$InProgressBookCollection extends InProgressBookCollection {
  @override
  final int completedEpisodesCount;
  @override
  final int completedVolumesCount;
  @override
  final int userUpdatedAt;
  @override
  final InProgressSubjectInfo subject;

  factory _$InProgressBookCollection(
          [void Function(InProgressBookCollectionBuilder) updates]) =>
      (new InProgressBookCollectionBuilder()..update(updates)).build();

  _$InProgressBookCollection._(
      {this.completedEpisodesCount,
      this.completedVolumesCount,
      this.userUpdatedAt,
      this.subject})
      : super._() {
    if (completedEpisodesCount == null) {
      throw new BuiltValueNullFieldError(
          'InProgressBookCollection', 'completedEpisodesCount');
    }
    if (completedVolumesCount == null) {
      throw new BuiltValueNullFieldError(
          'InProgressBookCollection', 'completedVolumesCount');
    }
    if (userUpdatedAt == null) {
      throw new BuiltValueNullFieldError(
          'InProgressBookCollection', 'userUpdatedAt');
    }
    if (subject == null) {
      throw new BuiltValueNullFieldError('InProgressBookCollection', 'subject');
    }
  }

  @override
  InProgressBookCollection rebuild(
          void Function(InProgressBookCollectionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InProgressBookCollectionBuilder toBuilder() =>
      new InProgressBookCollectionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InProgressBookCollection &&
        completedEpisodesCount == other.completedEpisodesCount &&
        completedVolumesCount == other.completedVolumesCount &&
        userUpdatedAt == other.userUpdatedAt &&
        subject == other.subject;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc(0, completedEpisodesCount.hashCode),
                completedVolumesCount.hashCode),
            userUpdatedAt.hashCode),
        subject.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InProgressBookCollection')
          ..add('completedEpisodesCount', completedEpisodesCount)
          ..add('completedVolumesCount', completedVolumesCount)
          ..add('userUpdatedAt', userUpdatedAt)
          ..add('subject', subject))
        .toString();
  }
}

class InProgressBookCollectionBuilder
    implements
        Builder<InProgressBookCollection, InProgressBookCollectionBuilder>,
        InProgressCollectionBuilder {
  _$InProgressBookCollection _$v;

  int _completedEpisodesCount;
  int get completedEpisodesCount => _$this._completedEpisodesCount;
  set completedEpisodesCount(int completedEpisodesCount) =>
      _$this._completedEpisodesCount = completedEpisodesCount;

  int _completedVolumesCount;
  int get completedVolumesCount => _$this._completedVolumesCount;
  set completedVolumesCount(int completedVolumesCount) =>
      _$this._completedVolumesCount = completedVolumesCount;

  int _userUpdatedAt;
  int get userUpdatedAt => _$this._userUpdatedAt;
  set userUpdatedAt(int userUpdatedAt) => _$this._userUpdatedAt = userUpdatedAt;

  InProgressSubjectInfoBuilder _subject;
  InProgressSubjectInfoBuilder get subject =>
      _$this._subject ??= new InProgressSubjectInfoBuilder();
  set subject(InProgressSubjectInfoBuilder subject) =>
      _$this._subject = subject;

  InProgressBookCollectionBuilder();

  InProgressBookCollectionBuilder get _$this {
    if (_$v != null) {
      _completedEpisodesCount = _$v.completedEpisodesCount;
      _completedVolumesCount = _$v.completedVolumesCount;
      _userUpdatedAt = _$v.userUpdatedAt;
      _subject = _$v.subject?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant InProgressBookCollection other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InProgressBookCollection;
  }

  @override
  void update(void Function(InProgressBookCollectionBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InProgressBookCollection build() {
    _$InProgressBookCollection _$result;
    try {
      _$result = _$v ??
          new _$InProgressBookCollection._(
              completedEpisodesCount: completedEpisodesCount,
              completedVolumesCount: completedVolumesCount,
              userUpdatedAt: userUpdatedAt,
              subject: subject.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'subject';
        subject.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'InProgressBookCollection', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
