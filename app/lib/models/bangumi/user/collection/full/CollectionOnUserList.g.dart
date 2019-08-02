// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CollectionOnUserList.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CollectionOnUserList> _$collectionOnUserListSerializer =
    new _$CollectionOnUserListSerializer();

class _$CollectionOnUserListSerializer
    implements StructuredSerializer<CollectionOnUserList> {
  @override
  final Iterable<Type> types = const [
    CollectionOnUserList,
    _$CollectionOnUserList
  ];
  @override
  final String wireName = 'CollectionOnUserList';

  @override
  Iterable<Object> serialize(
      Serializers serializers, CollectionOnUserList object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'collectionStatus',
      serializers.serialize(object.collectionStatus,
          specifiedType: const FullType(CollectionStatus)),
      'collectedByCurrentAppUser',
      serializers.serialize(object.collectedByCurrentAppUser,
          specifiedType: const FullType(bool)),
      'tags',
      serializers.serialize(object.tags,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'subject',
      serializers.serialize(object.subject,
          specifiedType: const FullType(SubjectOnUserCollectionList)),
      'collectedTimeMilliSeconds',
      serializers.serialize(object.collectedTimeMilliSeconds,
          specifiedType: const FullType(int)),
    ];
    if (object.comment != null) {
      result
        ..add('comment')
        ..add(serializers.serialize(object.comment,
            specifiedType: const FullType(String)));
    }
    if (object.rating != null) {
      result
        ..add('rating')
        ..add(serializers.serialize(object.rating,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  CollectionOnUserList deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CollectionOnUserListBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'collectionStatus':
          result.collectionStatus = serializers.deserialize(value,
                  specifiedType: const FullType(CollectionStatus))
              as CollectionStatus;
          break;
        case 'collectedByCurrentAppUser':
          result.collectedByCurrentAppUser = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'comment':
          result.comment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'rating':
          result.rating = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'tags':
          result.tags.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<dynamic>);
          break;
        case 'subject':
          result.subject.replace(serializers.deserialize(value,
                  specifiedType: const FullType(SubjectOnUserCollectionList))
              as SubjectOnUserCollectionList);
          break;
        case 'collectedTimeMilliSeconds':
          result.collectedTimeMilliSeconds = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$CollectionOnUserList extends CollectionOnUserList {
  @override
  final CollectionStatus collectionStatus;
  @override
  final bool collectedByCurrentAppUser;
  @override
  final String comment;
  @override
  final int rating;
  @override
  final BuiltList<String> tags;
  @override
  final SubjectOnUserCollectionList subject;
  @override
  final int collectedTimeMilliSeconds;

  factory _$CollectionOnUserList(
          [void Function(CollectionOnUserListBuilder) updates]) =>
      (new CollectionOnUserListBuilder()..update(updates)).build();

  _$CollectionOnUserList._(
      {this.collectionStatus,
      this.collectedByCurrentAppUser,
      this.comment,
      this.rating,
      this.tags,
      this.subject,
      this.collectedTimeMilliSeconds})
      : super._() {
    if (collectionStatus == null) {
      throw new BuiltValueNullFieldError(
          'CollectionOnUserList', 'collectionStatus');
    }
    if (collectedByCurrentAppUser == null) {
      throw new BuiltValueNullFieldError(
          'CollectionOnUserList', 'collectedByCurrentAppUser');
    }
    if (tags == null) {
      throw new BuiltValueNullFieldError('CollectionOnUserList', 'tags');
    }
    if (subject == null) {
      throw new BuiltValueNullFieldError('CollectionOnUserList', 'subject');
    }
    if (collectedTimeMilliSeconds == null) {
      throw new BuiltValueNullFieldError(
          'CollectionOnUserList', 'collectedTimeMilliSeconds');
    }
  }

  @override
  CollectionOnUserList rebuild(
          void Function(CollectionOnUserListBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CollectionOnUserListBuilder toBuilder() =>
      new CollectionOnUserListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CollectionOnUserList &&
        collectionStatus == other.collectionStatus &&
        collectedByCurrentAppUser == other.collectedByCurrentAppUser &&
        comment == other.comment &&
        rating == other.rating &&
        tags == other.tags &&
        subject == other.subject &&
        collectedTimeMilliSeconds == other.collectedTimeMilliSeconds;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc(0, collectionStatus.hashCode),
                            collectedByCurrentAppUser.hashCode),
                        comment.hashCode),
                    rating.hashCode),
                tags.hashCode),
            subject.hashCode),
        collectedTimeMilliSeconds.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CollectionOnUserList')
          ..add('collectionStatus', collectionStatus)
          ..add('collectedByCurrentAppUser', collectedByCurrentAppUser)
          ..add('comment', comment)
          ..add('rating', rating)
          ..add('tags', tags)
          ..add('subject', subject)
          ..add('collectedTimeMilliSeconds', collectedTimeMilliSeconds))
        .toString();
  }
}

class CollectionOnUserListBuilder
    implements Builder<CollectionOnUserList, CollectionOnUserListBuilder> {
  _$CollectionOnUserList _$v;

  CollectionStatus _collectionStatus;
  CollectionStatus get collectionStatus => _$this._collectionStatus;
  set collectionStatus(CollectionStatus collectionStatus) =>
      _$this._collectionStatus = collectionStatus;

  bool _collectedByCurrentAppUser;
  bool get collectedByCurrentAppUser => _$this._collectedByCurrentAppUser;
  set collectedByCurrentAppUser(bool collectedByCurrentAppUser) =>
      _$this._collectedByCurrentAppUser = collectedByCurrentAppUser;

  String _comment;
  String get comment => _$this._comment;
  set comment(String comment) => _$this._comment = comment;

  int _rating;
  int get rating => _$this._rating;
  set rating(int rating) => _$this._rating = rating;

  ListBuilder<String> _tags;
  ListBuilder<String> get tags => _$this._tags ??= new ListBuilder<String>();
  set tags(ListBuilder<String> tags) => _$this._tags = tags;

  SubjectOnUserCollectionListBuilder _subject;
  SubjectOnUserCollectionListBuilder get subject =>
      _$this._subject ??= new SubjectOnUserCollectionListBuilder();
  set subject(SubjectOnUserCollectionListBuilder subject) =>
      _$this._subject = subject;

  int _collectedTimeMilliSeconds;
  int get collectedTimeMilliSeconds => _$this._collectedTimeMilliSeconds;
  set collectedTimeMilliSeconds(int collectedTimeMilliSeconds) =>
      _$this._collectedTimeMilliSeconds = collectedTimeMilliSeconds;

  CollectionOnUserListBuilder();

  CollectionOnUserListBuilder get _$this {
    if (_$v != null) {
      _collectionStatus = _$v.collectionStatus;
      _collectedByCurrentAppUser = _$v.collectedByCurrentAppUser;
      _comment = _$v.comment;
      _rating = _$v.rating;
      _tags = _$v.tags?.toBuilder();
      _subject = _$v.subject?.toBuilder();
      _collectedTimeMilliSeconds = _$v.collectedTimeMilliSeconds;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CollectionOnUserList other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CollectionOnUserList;
  }

  @override
  void update(void Function(CollectionOnUserListBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CollectionOnUserList build() {
    _$CollectionOnUserList _$result;
    try {
      _$result = _$v ??
          new _$CollectionOnUserList._(
              collectionStatus: collectionStatus,
              collectedByCurrentAppUser: collectedByCurrentAppUser,
              comment: comment,
              rating: rating,
              tags: tags.build(),
              subject: subject.build(),
              collectedTimeMilliSeconds: collectedTimeMilliSeconds);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'tags';
        tags.build();
        _$failedField = 'subject';
        subject.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CollectionOnUserList', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
