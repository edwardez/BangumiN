// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetDiscussionRequest.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GetDiscussionRequest> _$getDiscussionRequestSerializer =
    new _$GetDiscussionRequestSerializer();

class _$GetDiscussionRequestSerializer
    implements StructuredSerializer<GetDiscussionRequest> {
  @override
  final Iterable<Type> types = const [
    GetDiscussionRequest,
    _$GetDiscussionRequest
  ];
  @override
  final String wireName = 'GetDiscussionRequest';

  @override
  Iterable serialize(Serializers serializers, GetDiscussionRequest object,
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
  GetDiscussionRequest deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GetDiscussionRequestBuilder();

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

class _$GetDiscussionRequest extends GetDiscussionRequest {
  @override
  final DiscussionType discussionType;
  @override
  final DiscussionFilter discussionFilter;
  int __pageIndex;

  factory _$GetDiscussionRequest(
          [void Function(GetDiscussionRequestBuilder) updates]) =>
      (new GetDiscussionRequestBuilder()..update(updates)).build();

  _$GetDiscussionRequest._({this.discussionType, this.discussionFilter})
      : super._() {
    if (discussionType == null) {
      throw new BuiltValueNullFieldError(
          'GetDiscussionRequest', 'discussionType');
    }
    if (discussionFilter == null) {
      throw new BuiltValueNullFieldError(
          'GetDiscussionRequest', 'discussionFilter');
    }
  }

  @override
  int get pageIndex => __pageIndex ??= super.pageIndex;

  @override
  GetDiscussionRequest rebuild(
          void Function(GetDiscussionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetDiscussionRequestBuilder toBuilder() =>
      new GetDiscussionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetDiscussionRequest &&
        discussionType == other.discussionType &&
        discussionFilter == other.discussionFilter;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, discussionType.hashCode), discussionFilter.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GetDiscussionRequest')
          ..add('discussionType', discussionType)
          ..add('discussionFilter', discussionFilter))
        .toString();
  }
}

class GetDiscussionRequestBuilder
    implements Builder<GetDiscussionRequest, GetDiscussionRequestBuilder> {
  _$GetDiscussionRequest _$v;

  DiscussionType _discussionType;
  DiscussionType get discussionType => _$this._discussionType;
  set discussionType(DiscussionType discussionType) =>
      _$this._discussionType = discussionType;

  DiscussionFilter _discussionFilter;
  DiscussionFilter get discussionFilter => _$this._discussionFilter;
  set discussionFilter(DiscussionFilter discussionFilter) =>
      _$this._discussionFilter = discussionFilter;

  GetDiscussionRequestBuilder();

  GetDiscussionRequestBuilder get _$this {
    if (_$v != null) {
      _discussionType = _$v.discussionType;
      _discussionFilter = _$v.discussionFilter;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetDiscussionRequest other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$GetDiscussionRequest;
  }

  @override
  void update(void Function(GetDiscussionRequestBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GetDiscussionRequest build() {
    final _$result = _$v ??
        new _$GetDiscussionRequest._(
            discussionType: discussionType, discussionFilter: discussionFilter);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
