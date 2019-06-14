// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectReview.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SubjectReview> _$subjectReviewSerializer =
    new _$SubjectReviewSerializer();

class _$SubjectReviewSerializer implements StructuredSerializer<SubjectReview> {
  @override
  final Iterable<Type> types = const [SubjectReview, _$SubjectReview];
  @override
  final String wireName = 'SubjectReview';

  @override
  Iterable serialize(Serializers serializers, SubjectReview object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'metaInfo',
      serializers.serialize(object.metaInfo,
          specifiedType: const FullType(ReviewMetaInfo)),
    ];
    if (object.content != null) {
      result
        ..add('content')
        ..add(serializers.serialize(object.content,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  SubjectReview deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubjectReviewBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'metaInfo':
          result.metaInfo.replace(serializers.deserialize(value,
              specifiedType: const FullType(ReviewMetaInfo)) as ReviewMetaInfo);
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

class _$SubjectReview extends SubjectReview {
  @override
  final ReviewMetaInfo metaInfo;
  @override
  final String content;

  factory _$SubjectReview([void Function(SubjectReviewBuilder) updates]) =>
      (new SubjectReviewBuilder()..update(updates)).build();

  _$SubjectReview._({this.metaInfo, this.content}) : super._() {
    if (metaInfo == null) {
      throw new BuiltValueNullFieldError('SubjectReview', 'metaInfo');
    }
  }

  @override
  SubjectReview rebuild(void Function(SubjectReviewBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubjectReviewBuilder toBuilder() => new SubjectReviewBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubjectReview &&
        metaInfo == other.metaInfo &&
        content == other.content;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, metaInfo.hashCode), content.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubjectReview')
          ..add('metaInfo', metaInfo)
          ..add('content', content))
        .toString();
  }
}

class SubjectReviewBuilder
    implements Builder<SubjectReview, SubjectReviewBuilder> {
  _$SubjectReview _$v;

  ReviewMetaInfoBuilder _metaInfo;
  ReviewMetaInfoBuilder get metaInfo =>
      _$this._metaInfo ??= new ReviewMetaInfoBuilder();
  set metaInfo(ReviewMetaInfoBuilder metaInfo) => _$this._metaInfo = metaInfo;

  String _content;
  String get content => _$this._content;
  set content(String content) => _$this._content = content;

  SubjectReviewBuilder();

  SubjectReviewBuilder get _$this {
    if (_$v != null) {
      _metaInfo = _$v.metaInfo?.toBuilder();
      _content = _$v.content;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubjectReview other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubjectReview;
  }

  @override
  void update(void Function(SubjectReviewBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubjectReview build() {
    _$SubjectReview _$result;
    try {
      _$result = _$v ??
          new _$SubjectReview._(metaInfo: metaInfo.build(), content: content);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'metaInfo';
        metaInfo.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SubjectReview', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
