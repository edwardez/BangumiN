// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PreferredSubjectInfoLanguage.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PreferredSubjectInfoLanguage _$Original =
    const PreferredSubjectInfoLanguage._('Original');
const PreferredSubjectInfoLanguage _$Chinese =
    const PreferredSubjectInfoLanguage._('Chinese');

PreferredSubjectInfoLanguage _$valueOf(String name) {
  switch (name) {
    case 'Original':
      return _$Original;
    case 'Chinese':
      return _$Chinese;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<PreferredSubjectInfoLanguage> _$values = new BuiltSet<
    PreferredSubjectInfoLanguage>(const <PreferredSubjectInfoLanguage>[
  _$Original,
  _$Chinese,
]);

Serializer<PreferredSubjectInfoLanguage>
    _$preferredSubjectInfoLanguageSerializer =
    new _$PreferredSubjectInfoLanguageSerializer();

class _$PreferredSubjectInfoLanguageSerializer
    implements PrimitiveSerializer<PreferredSubjectInfoLanguage> {
  @override
  final Iterable<Type> types = const <Type>[PreferredSubjectInfoLanguage];
  @override
  final String wireName = 'PreferredSubjectInfoLanguage';

  @override
  Object serialize(Serializers serializers, PreferredSubjectInfoLanguage object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  PreferredSubjectInfoLanguage deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PreferredSubjectInfoLanguage.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
