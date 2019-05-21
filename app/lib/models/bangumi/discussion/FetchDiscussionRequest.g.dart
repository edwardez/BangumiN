// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FetchDiscussionRequest.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FetchDiscussionRequest> _$fetchDiscussionRequestSerializer =
    new _$FetchDiscussionRequestSerializer();

class _$FetchDiscussionRequestSerializer
    implements StructuredSerializer<FetchDiscussionRequest> {
  @override
  final Iterable<Type> types = const [
    FetchDiscussionRequest,
    _$FetchDiscussionRequest
  ];
  @override
  final String wireName = 'FetchDiscussionRequest';

  @override
  Iterable serialize(Serializers serializers, FetchDiscussionRequest object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'discussionType',
      serializers.serialize(object.discussionType,
          specifiedType: const FullType(DiscussionType)),
      'discussionFilter',
      serializers.serialize(object.discussionFilter,
          specifiedType: const FullType(DiscussionFilter)),
    ];

    return result;
  }

  @override
  FetchDiscussionRequest deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FetchDiscussionRequestBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'discussionType':
          result.discussionType = serializers.deserialize(value,
              specifiedType: const FullType(DiscussionType)) as DiscussionType;
          break;
        case 'discussionFilter':
          result.discussionFilter = serializers.deserialize(value,
                  specifiedType: const FullType(DiscussionFilter))
              as DiscussionFilter;
          break;
      }
    }

    return result.build();
  }
}

class _$FetchDiscussionRequest extends FetchDiscussionRequest {
  @override
  final DiscussionType discussionType;
  @override
  final DiscussionFilter discussionFilter;

  factory _$FetchDiscussionRequest(
          [void Function(FetchDiscussionRequestBuilder) updates]) =>
      (new FetchDiscussionRequestBuilder()..update(updates)).build();

  _$FetchDiscussionRequest._({this.discussionType, this.discussionFilter})
      : super._() {
    if (discussionType == null) {
      throw new BuiltValueNullFieldError(
          'FetchDiscussionRequest', 'discussionType');
    }
    if (discussionFilter == null) {
      throw new BuiltValueNullFieldError(
          'FetchDiscussionRequest', 'discussionFilter');
    }
  }

  @override
  FetchDiscussionRequest rebuild(
          void Function(FetchDiscussionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FetchDiscussionRequestBuilder toBuilder() =>
      new FetchDiscussionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FetchDiscussionRequest &&
        discussionType == other.discussionType &&
        discussionFilter == other.discussionFilter;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, discussionType.hashCode), discussionFilter.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FetchDiscussionRequest')
          ..add('discussionType', discussionType)
          ..add('discussionFilter', discussionFilter))
        .toString();
  }
}

class FetchDiscussionRequestBuilder
    implements Builder<FetchDiscussionRequest, FetchDiscussionRequestBuilder> {
  _$FetchDiscussionRequest _$v;

  DiscussionType _discussionType;
  DiscussionType get discussionType => _$this._discussionType;
  set discussionType(DiscussionType discussionType) =>
      _$this._discussionType = discussionType;

  DiscussionFilter _discussionFilter;
  DiscussionFilter get discussionFilter => _$this._discussionFilter;
  set discussionFilter(DiscussionFilter discussionFilter) =>
      _$this._discussionFilter = discussionFilter;

  FetchDiscussionRequestBuilder();

  FetchDiscussionRequestBuilder get _$this {
    if (_$v != null) {
      _discussionType = _$v.discussionType;
      _discussionFilter = _$v.discussionFilter;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FetchDiscussionRequest other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FetchDiscussionRequest;
  }

  @override
  void update(void Function(FetchDiscussionRequestBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FetchDiscussionRequest build() {
    final _$result = _$v ??
        new _$FetchDiscussionRequest._(
            discussionType: discussionType, discussionFilter: discussionFilter);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
