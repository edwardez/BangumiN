// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IndexFavoriteSingle.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<IndexFavoriteSingle> _$indexFavoriteSingleSerializer =
    new _$IndexFavoriteSingleSerializer();

class _$IndexFavoriteSingleSerializer
    implements StructuredSerializer<IndexFavoriteSingle> {
  @override
  final Iterable<Type> types = const [
    IndexFavoriteSingle,
    _$IndexFavoriteSingle
  ];
  @override
  final String wireName = 'IndexFavoriteSingle';

  @override
  Iterable serialize(Serializers serializers, IndexFavoriteSingle object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'user',
      serializers.serialize(object.user,
          specifiedType: const FullType(FeedMetaInfo)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    if (object.summary != null) {
      result
        ..add('summary')
        ..add(serializers.serialize(object.summary,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  IndexFavoriteSingle deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new IndexFavoriteSingleBuilder();

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
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'summary':
          result.summary = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$IndexFavoriteSingle extends IndexFavoriteSingle {
  @override
  final FeedMetaInfo user;
  @override
  final String title;
  @override
  final String id;
  @override
  final String summary;

  factory _$IndexFavoriteSingle([void updates(IndexFavoriteSingleBuilder b)]) =>
      (new IndexFavoriteSingleBuilder()..update(updates)).build();

  _$IndexFavoriteSingle._({this.user, this.title, this.id, this.summary})
      : super._() {
    if (user == null) {
      throw new BuiltValueNullFieldError('IndexFavoriteSingle', 'user');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('IndexFavoriteSingle', 'title');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('IndexFavoriteSingle', 'id');
    }
  }

  @override
  IndexFavoriteSingle rebuild(void updates(IndexFavoriteSingleBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  IndexFavoriteSingleBuilder toBuilder() =>
      new IndexFavoriteSingleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IndexFavoriteSingle &&
        user == other.user &&
        title == other.title &&
        id == other.id &&
        summary == other.summary;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc($jc(0, user.hashCode), title.hashCode), id.hashCode),
        summary.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('IndexFavoriteSingle')
          ..add('user', user)
          ..add('title', title)
          ..add('id', id)
          ..add('summary', summary))
        .toString();
  }
}

class IndexFavoriteSingleBuilder
    implements Builder<IndexFavoriteSingle, IndexFavoriteSingleBuilder> {
  _$IndexFavoriteSingle _$v;

  FeedMetaInfoBuilder _user;
  FeedMetaInfoBuilder get user => _$this._user ??= new FeedMetaInfoBuilder();
  set user(FeedMetaInfoBuilder user) => _$this._user = user;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _summary;
  String get summary => _$this._summary;
  set summary(String summary) => _$this._summary = summary;

  IndexFavoriteSingleBuilder();

  IndexFavoriteSingleBuilder get _$this {
    if (_$v != null) {
      _user = _$v.user?.toBuilder();
      _title = _$v.title;
      _id = _$v.id;
      _summary = _$v.summary;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IndexFavoriteSingle other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$IndexFavoriteSingle;
  }

  @override
  void update(void updates(IndexFavoriteSingleBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$IndexFavoriteSingle build() {
    _$IndexFavoriteSingle _$result;
    try {
      _$result = _$v ??
          new _$IndexFavoriteSingle._(
              user: user.build(), title: title, id: id, summary: summary);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'IndexFavoriteSingle', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
