// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectStatus.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SubjectStatus _$Unknown = const SubjectStatus._('Unknown');
const SubjectStatus _$Normal = const SubjectStatus._('Normal');
const SubjectStatus _$LockedForCollection =
    const SubjectStatus._('LockedForCollection');

SubjectStatus _$valueOf(String name) {
  switch (name) {
    case 'Unknown':
      return _$Unknown;
    case 'Normal':
      return _$Normal;
    case 'LockedForCollection':
      return _$LockedForCollection;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<SubjectStatus> _$values =
    new BuiltSet<SubjectStatus>(const <SubjectStatus>[
  _$Unknown,
  _$Normal,
  _$LockedForCollection,
]);

Serializer<SubjectStatus> _$subjectStatusSerializer =
    new _$SubjectStatusSerializer();

class _$SubjectStatusSerializer implements PrimitiveSerializer<SubjectStatus> {
  @override
  final Iterable<Type> types = const <Type>[SubjectStatus];
  @override
  final String wireName = 'SubjectStatus';

  @override
  Object serialize(Serializers serializers, SubjectStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  SubjectStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      SubjectStatus.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
