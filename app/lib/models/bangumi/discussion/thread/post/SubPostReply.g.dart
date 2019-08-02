// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubPostReply.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SubPostReply> _$subPostReplySerializer =
    new _$SubPostReplySerializer();

class _$SubPostReplySerializer implements StructuredSerializer<SubPostReply> {
  @override
  final Iterable<Type> types = const [SubPostReply, _$SubPostReply];
  @override
  final String wireName = 'SubPostReply';

  @override
  Iterable<Object> serialize(Serializers serializers, SubPostReply object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'mainPostId',
      serializers.serialize(object.mainPostId,
          specifiedType: const FullType(int)),
      'subSequentialNumber',
      serializers.serialize(object.subSequentialNumber,
          specifiedType: const FullType(int)),
      'author',
      serializers.serialize(object.author,
          specifiedType: const FullType(BangumiUserBasic)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'contentHtml',
      serializers.serialize(object.contentHtml,
          specifiedType: const FullType(String)),
      'authorPostedText',
      serializers.serialize(object.authorPostedText,
          specifiedType: const FullType(String)),
      'postTimeInMilliSeconds',
      serializers.serialize(object.postTimeInMilliSeconds,
          specifiedType: const FullType(int)),
      'mainSequentialNumber',
      serializers.serialize(object.mainSequentialNumber,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  SubPostReply deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubPostReplyBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'mainPostId':
          result.mainPostId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'subSequentialNumber':
          result.subSequentialNumber = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'author':
          result.author.replace(serializers.deserialize(value,
                  specifiedType: const FullType(BangumiUserBasic))
              as BangumiUserBasic);
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'contentHtml':
          result.contentHtml = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'authorPostedText':
          result.authorPostedText = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'postTimeInMilliSeconds':
          result.postTimeInMilliSeconds = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'mainSequentialNumber':
          result.mainSequentialNumber = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$SubPostReply extends SubPostReply {
  @override
  final int mainPostId;
  @override
  final int subSequentialNumber;
  @override
  final BangumiUserBasic author;
  @override
  final int id;
  @override
  final String contentHtml;
  @override
  final String authorPostedText;
  @override
  final int postTimeInMilliSeconds;
  @override
  final int mainSequentialNumber;

  factory _$SubPostReply([void Function(SubPostReplyBuilder) updates]) =>
      (new SubPostReplyBuilder()..update(updates)).build();

  _$SubPostReply._(
      {this.mainPostId,
      this.subSequentialNumber,
      this.author,
      this.id,
      this.contentHtml,
      this.authorPostedText,
      this.postTimeInMilliSeconds,
      this.mainSequentialNumber})
      : super._() {
    if (mainPostId == null) {
      throw new BuiltValueNullFieldError('SubPostReply', 'mainPostId');
    }
    if (subSequentialNumber == null) {
      throw new BuiltValueNullFieldError('SubPostReply', 'subSequentialNumber');
    }
    if (author == null) {
      throw new BuiltValueNullFieldError('SubPostReply', 'author');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('SubPostReply', 'id');
    }
    if (contentHtml == null) {
      throw new BuiltValueNullFieldError('SubPostReply', 'contentHtml');
    }
    if (authorPostedText == null) {
      throw new BuiltValueNullFieldError('SubPostReply', 'authorPostedText');
    }
    if (postTimeInMilliSeconds == null) {
      throw new BuiltValueNullFieldError(
          'SubPostReply', 'postTimeInMilliSeconds');
    }
    if (mainSequentialNumber == null) {
      throw new BuiltValueNullFieldError(
          'SubPostReply', 'mainSequentialNumber');
    }
  }

  @override
  SubPostReply rebuild(void Function(SubPostReplyBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubPostReplyBuilder toBuilder() => new SubPostReplyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubPostReply &&
        mainPostId == other.mainPostId &&
        subSequentialNumber == other.subSequentialNumber &&
        author == other.author &&
        id == other.id &&
        contentHtml == other.contentHtml &&
        authorPostedText == other.authorPostedText &&
        postTimeInMilliSeconds == other.postTimeInMilliSeconds &&
        mainSequentialNumber == other.mainSequentialNumber;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc(0, mainPostId.hashCode),
                                subSequentialNumber.hashCode),
                            author.hashCode),
                        id.hashCode),
                    contentHtml.hashCode),
                authorPostedText.hashCode),
            postTimeInMilliSeconds.hashCode),
        mainSequentialNumber.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubPostReply')
          ..add('mainPostId', mainPostId)
          ..add('subSequentialNumber', subSequentialNumber)
          ..add('author', author)
          ..add('id', id)
          ..add('contentHtml', contentHtml)
          ..add('authorPostedText', authorPostedText)
          ..add('postTimeInMilliSeconds', postTimeInMilliSeconds)
          ..add('mainSequentialNumber', mainSequentialNumber))
        .toString();
  }
}

class SubPostReplyBuilder
    implements Builder<SubPostReply, SubPostReplyBuilder>, PostBuilder {
  _$SubPostReply _$v;

  int _mainPostId;
  int get mainPostId => _$this._mainPostId;
  set mainPostId(int mainPostId) => _$this._mainPostId = mainPostId;

  int _subSequentialNumber;
  int get subSequentialNumber => _$this._subSequentialNumber;
  set subSequentialNumber(int subSequentialNumber) =>
      _$this._subSequentialNumber = subSequentialNumber;

  BangumiUserBasicBuilder _author;
  BangumiUserBasicBuilder get author =>
      _$this._author ??= new BangumiUserBasicBuilder();
  set author(BangumiUserBasicBuilder author) => _$this._author = author;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _contentHtml;
  String get contentHtml => _$this._contentHtml;
  set contentHtml(String contentHtml) => _$this._contentHtml = contentHtml;

  String _authorPostedText;
  String get authorPostedText => _$this._authorPostedText;
  set authorPostedText(String authorPostedText) =>
      _$this._authorPostedText = authorPostedText;

  int _postTimeInMilliSeconds;
  int get postTimeInMilliSeconds => _$this._postTimeInMilliSeconds;
  set postTimeInMilliSeconds(int postTimeInMilliSeconds) =>
      _$this._postTimeInMilliSeconds = postTimeInMilliSeconds;

  int _mainSequentialNumber;
  int get mainSequentialNumber => _$this._mainSequentialNumber;
  set mainSequentialNumber(int mainSequentialNumber) =>
      _$this._mainSequentialNumber = mainSequentialNumber;

  SubPostReplyBuilder();

  SubPostReplyBuilder get _$this {
    if (_$v != null) {
      _mainPostId = _$v.mainPostId;
      _subSequentialNumber = _$v.subSequentialNumber;
      _author = _$v.author?.toBuilder();
      _id = _$v.id;
      _contentHtml = _$v.contentHtml;
      _authorPostedText = _$v.authorPostedText;
      _postTimeInMilliSeconds = _$v.postTimeInMilliSeconds;
      _mainSequentialNumber = _$v.mainSequentialNumber;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant SubPostReply other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubPostReply;
  }

  @override
  void update(void Function(SubPostReplyBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubPostReply build() {
    _$SubPostReply _$result;
    try {
      _$result = _$v ??
          new _$SubPostReply._(
              mainPostId: mainPostId,
              subSequentialNumber: subSequentialNumber,
              author: author.build(),
              id: id,
              contentHtml: contentHtml,
              authorPostedText: authorPostedText,
              postTimeInMilliSeconds: postTimeInMilliSeconds,
              mainSequentialNumber: mainSequentialNumber);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'author';
        author.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SubPostReply', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
