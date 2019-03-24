// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectComment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SubjectComment> _$subjectCommentSerializer =
    new _$SubjectCommentSerializer();

class _$SubjectCommentSerializer
    implements StructuredSerializer<SubjectComment> {
  @override
  final Iterable<Type> types = const [SubjectComment, _$SubjectComment];
  @override
  final String wireName = 'SubjectComment';

  @override
  Iterable serialize(Serializers serializers, SubjectComment object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'metaInfo',
      serializers.serialize(object.metaInfo,
          specifiedType: const FullType(SubjectCommentMetaInfo)),
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  SubjectComment deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubjectCommentBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'metaInfo':
          result.metaInfo.replace(serializers.deserialize(value,
                  specifiedType: const FullType(SubjectCommentMetaInfo))
              as SubjectCommentMetaInfo);
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$SubjectComment extends SubjectComment {
  @override
  final SubjectCommentMetaInfo metaInfo;
  @override
  final String content;

  factory _$SubjectComment([void updates(SubjectCommentBuilder b)]) =>
      (new SubjectCommentBuilder()..update(updates)).build();

  _$SubjectComment._({this.metaInfo, this.content}) : super._() {
    if (metaInfo == null) {
      throw new BuiltValueNullFieldError('SubjectComment', 'metaInfo');
    }
    if (content == null) {
      throw new BuiltValueNullFieldError('SubjectComment', 'content');
    }
  }

  @override
  SubjectComment rebuild(void updates(SubjectCommentBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  SubjectCommentBuilder toBuilder() =>
      new SubjectCommentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubjectComment &&
        metaInfo == other.metaInfo &&
        content == other.content;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, metaInfo.hashCode), content.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubjectComment')
          ..add('metaInfo', metaInfo)
          ..add('content', content))
        .toString();
  }
}

class SubjectCommentBuilder
    implements Builder<SubjectComment, SubjectCommentBuilder> {
  _$SubjectComment _$v;

  SubjectCommentMetaInfoBuilder _metaInfo;
  SubjectCommentMetaInfoBuilder get metaInfo =>
      _$this._metaInfo ??= new SubjectCommentMetaInfoBuilder();
  set metaInfo(SubjectCommentMetaInfoBuilder metaInfo) =>
      _$this._metaInfo = metaInfo;

  String _content;
  String get content => _$this._content;
  set content(String content) => _$this._content = content;

  SubjectCommentBuilder();

  SubjectCommentBuilder get _$this {
    if (_$v != null) {
      _metaInfo = _$v.metaInfo?.toBuilder();
      _content = _$v.content;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubjectComment other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubjectComment;
  }

  @override
  void update(void updates(SubjectCommentBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$SubjectComment build() {
    _$SubjectComment _$result;
    try {
      _$result = _$v ??
          new _$SubjectComment._(metaInfo: metaInfo.build(), content: content);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'metaInfo';
        metaInfo.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SubjectComment', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
