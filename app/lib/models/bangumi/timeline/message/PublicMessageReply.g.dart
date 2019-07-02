// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PublicMessageReply.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PublicMessageReply> _$publicMessageReplySerializer =
    new _$PublicMessageReplySerializer();

class _$PublicMessageReplySerializer
    implements StructuredSerializer<PublicMessageReply> {
  @override
  final Iterable<Type> types = const [PublicMessageReply, _$PublicMessageReply];
  @override
  final String wireName = 'PublicMessageReply';

  @override
  Iterable serialize(Serializers serializers, PublicMessageReply object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'author',
      serializers.serialize(object.author,
          specifiedType: const FullType(BangumiUserBasic)),
      'contentHtml',
      serializers.serialize(object.contentHtml,
          specifiedType: const FullType(String)),
      'contentText',
      serializers.serialize(object.contentText,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  PublicMessageReply deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PublicMessageReplyBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'author':
          result.author.replace(serializers.deserialize(value,
                  specifiedType: const FullType(BangumiUserBasic))
              as BangumiUserBasic);
          break;
        case 'contentHtml':
          result.contentHtml = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'contentText':
          result.contentText = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$PublicMessageReply extends PublicMessageReply {
  @override
  final BangumiUserBasic author;
  @override
  final String contentHtml;
  @override
  final String contentText;

  factory _$PublicMessageReply(
          [void Function(PublicMessageReplyBuilder) updates]) =>
      (new PublicMessageReplyBuilder()..update(updates)).build();

  _$PublicMessageReply._({this.author, this.contentHtml, this.contentText})
      : super._() {
    if (author == null) {
      throw new BuiltValueNullFieldError('PublicMessageReply', 'author');
    }
    if (contentHtml == null) {
      throw new BuiltValueNullFieldError('PublicMessageReply', 'contentHtml');
    }
    if (contentText == null) {
      throw new BuiltValueNullFieldError('PublicMessageReply', 'contentText');
    }
  }

  @override
  PublicMessageReply rebuild(
          void Function(PublicMessageReplyBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PublicMessageReplyBuilder toBuilder() =>
      new PublicMessageReplyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PublicMessageReply &&
        author == other.author &&
        contentHtml == other.contentHtml &&
        contentText == other.contentText;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, author.hashCode), contentHtml.hashCode),
        contentText.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PublicMessageReply')
          ..add('author', author)
          ..add('contentHtml', contentHtml)
          ..add('contentText', contentText))
        .toString();
  }
}

class PublicMessageReplyBuilder
    implements Builder<PublicMessageReply, PublicMessageReplyBuilder> {
  _$PublicMessageReply _$v;

  BangumiUserBasicBuilder _author;
  BangumiUserBasicBuilder get author =>
      _$this._author ??= new BangumiUserBasicBuilder();
  set author(BangumiUserBasicBuilder author) => _$this._author = author;

  String _contentHtml;
  String get contentHtml => _$this._contentHtml;
  set contentHtml(String contentHtml) => _$this._contentHtml = contentHtml;

  String _contentText;
  String get contentText => _$this._contentText;
  set contentText(String contentText) => _$this._contentText = contentText;

  PublicMessageReplyBuilder();

  PublicMessageReplyBuilder get _$this {
    if (_$v != null) {
      _author = _$v.author?.toBuilder();
      _contentHtml = _$v.contentHtml;
      _contentText = _$v.contentText;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PublicMessageReply other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PublicMessageReply;
  }

  @override
  void update(void Function(PublicMessageReplyBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PublicMessageReply build() {
    _$PublicMessageReply _$result;
    try {
      _$result = _$v ??
          new _$PublicMessageReply._(
              author: author.build(),
              contentHtml: contentHtml,
              contentText: contentText);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'author';
        author.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PublicMessageReply', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
