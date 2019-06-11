// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectReviewMainFilter.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SubjectReviewMainFilter _$WithNonEmptyComments =
    const SubjectReviewMainFilter._('WithNonEmptyComments');
const SubjectReviewMainFilter _$FromWishedUsers =
    const SubjectReviewMainFilter._('FromWishedUsers');
const SubjectReviewMainFilter _$FromCompletedUsers =
    const SubjectReviewMainFilter._('FromCompletedUsers');
const SubjectReviewMainFilter _$FromInProgressUsers =
    const SubjectReviewMainFilter._('FromInProgressUsers');
const SubjectReviewMainFilter _$FromOnHoldUsers =
    const SubjectReviewMainFilter._('FromOnHoldUsers');
const SubjectReviewMainFilter _$FromDroppedUsers =
    const SubjectReviewMainFilter._('FromDroppedUsers');

SubjectReviewMainFilter _$valueOf(String name) {
  switch (name) {
    case 'WithNonEmptyComments':
      return _$WithNonEmptyComments;
    case 'FromWishedUsers':
      return _$FromWishedUsers;
    case 'FromCompletedUsers':
      return _$FromCompletedUsers;
    case 'FromInProgressUsers':
      return _$FromInProgressUsers;
    case 'FromOnHoldUsers':
      return _$FromOnHoldUsers;
    case 'FromDroppedUsers':
      return _$FromDroppedUsers;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<SubjectReviewMainFilter> _$values =
    new BuiltSet<SubjectReviewMainFilter>(const <SubjectReviewMainFilter>[
  _$WithNonEmptyComments,
  _$FromWishedUsers,
  _$FromCompletedUsers,
  _$FromInProgressUsers,
  _$FromOnHoldUsers,
  _$FromDroppedUsers,
]);

Serializer<SubjectReviewMainFilter> _$subjectReviewMainFilterSerializer =
    new _$SubjectReviewMainFilterSerializer();

class _$SubjectReviewMainFilterSerializer
    implements PrimitiveSerializer<SubjectReviewMainFilter> {
  @override
  final Iterable<Type> types = const <Type>[SubjectReviewMainFilter];
  @override
  final String wireName = 'SubjectReviewMainFilter';

  @override
  Object serialize(Serializers serializers, SubjectReviewMainFilter object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  SubjectReviewMainFilter deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      SubjectReviewMainFilter.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
