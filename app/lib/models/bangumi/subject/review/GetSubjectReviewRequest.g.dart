// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetSubjectReviewRequest.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GetSubjectReviewRequest> _$getSubjectReviewRequestSerializer =
    new _$GetSubjectReviewRequestSerializer();

class _$GetSubjectReviewRequestSerializer
    implements StructuredSerializer<GetSubjectReviewRequest> {
  @override
  final Iterable<Type> types = const [
    GetSubjectReviewRequest,
    _$GetSubjectReviewRequest
  ];
  @override
  final String wireName = 'GetSubjectReviewRequest';

  @override
  Iterable serialize(Serializers serializers, GetSubjectReviewRequest object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'subjectId',
      serializers.serialize(object.subjectId,
          specifiedType: const FullType(int)),
      'mainFilter',
      serializers.serialize(object.mainFilter,
          specifiedType: const FullType(SubjectReviewMainFilter)),
      'showOnlyFriends',
      serializers.serialize(object.showOnlyFriends,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GetSubjectReviewRequest deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GetSubjectReviewRequestBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'subjectId':
          result.subjectId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'mainFilter':
          result.mainFilter = serializers.deserialize(value,
                  specifiedType: const FullType(SubjectReviewMainFilter))
              as SubjectReviewMainFilter;
          break;
        case 'showOnlyFriends':
          result.showOnlyFriends = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GetSubjectReviewRequest extends GetSubjectReviewRequest {
  @override
  final int subjectId;
  @override
  final SubjectReviewMainFilter mainFilter;
  @override
  final bool showOnlyFriends;

  factory _$GetSubjectReviewRequest(
          [void Function(GetSubjectReviewRequestBuilder) updates]) =>
      (new GetSubjectReviewRequestBuilder()..update(updates)).build();

  _$GetSubjectReviewRequest._(
      {this.subjectId, this.mainFilter, this.showOnlyFriends})
      : super._() {
    if (subjectId == null) {
      throw new BuiltValueNullFieldError(
          'GetSubjectReviewRequest', 'subjectId');
    }
    if (mainFilter == null) {
      throw new BuiltValueNullFieldError(
          'GetSubjectReviewRequest', 'mainFilter');
    }
    if (showOnlyFriends == null) {
      throw new BuiltValueNullFieldError(
          'GetSubjectReviewRequest', 'showOnlyFriends');
    }
  }

  @override
  GetSubjectReviewRequest rebuild(
          void Function(GetSubjectReviewRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetSubjectReviewRequestBuilder toBuilder() =>
      new GetSubjectReviewRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetSubjectReviewRequest &&
        subjectId == other.subjectId &&
        mainFilter == other.mainFilter &&
        showOnlyFriends == other.showOnlyFriends;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, subjectId.hashCode), mainFilter.hashCode),
        showOnlyFriends.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GetSubjectReviewRequest')
          ..add('subjectId', subjectId)
          ..add('mainFilter', mainFilter)
          ..add('showOnlyFriends', showOnlyFriends))
        .toString();
  }
}

class GetSubjectReviewRequestBuilder
    implements
        Builder<GetSubjectReviewRequest, GetSubjectReviewRequestBuilder> {
  _$GetSubjectReviewRequest _$v;

  int _subjectId;
  int get subjectId => _$this._subjectId;
  set subjectId(int subjectId) => _$this._subjectId = subjectId;

  SubjectReviewMainFilter _mainFilter;
  SubjectReviewMainFilter get mainFilter => _$this._mainFilter;
  set mainFilter(SubjectReviewMainFilter mainFilter) =>
      _$this._mainFilter = mainFilter;

  bool _showOnlyFriends;
  bool get showOnlyFriends => _$this._showOnlyFriends;
  set showOnlyFriends(bool showOnlyFriends) =>
      _$this._showOnlyFriends = showOnlyFriends;

  GetSubjectReviewRequestBuilder();

  GetSubjectReviewRequestBuilder get _$this {
    if (_$v != null) {
      _subjectId = _$v.subjectId;
      _mainFilter = _$v.mainFilter;
      _showOnlyFriends = _$v.showOnlyFriends;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetSubjectReviewRequest other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$GetSubjectReviewRequest;
  }

  @override
  void update(void Function(GetSubjectReviewRequestBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GetSubjectReviewRequest build() {
    final _$result = _$v ??
        new _$GetSubjectReviewRequest._(
            subjectId: subjectId,
            mainFilter: mainFilter,
            showOnlyFriends: showOnlyFriends);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
