// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoadingStatus.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LoadingStatus _$Initial = const LoadingStatus._('Initial');
const LoadingStatus _$Loading = const LoadingStatus._('Loading');
const LoadingStatus _$Success = const LoadingStatus._('Success');
const LoadingStatus _$Timeout = const LoadingStatus._('TimeoutException');
const LoadingStatus _$UnknownError = const LoadingStatus._('UnknownException');

LoadingStatus _$valueOf(String name) {
  switch (name) {
    case 'Initial':
      return _$Initial;
    case 'Loading':
      return _$Loading;
    case 'Success':
      return _$Success;
    case 'TimeoutException':
      return _$Timeout;
    case 'UnknownException':
      return _$UnknownError;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<LoadingStatus> _$values =
    new BuiltSet<LoadingStatus>(const <LoadingStatus>[
  _$Initial,
  _$Loading,
  _$Success,
  _$Timeout,
  _$UnknownError,
]);

Serializer<LoadingStatus> _$loadingStatusSerializer =
    new _$LoadingStatusSerializer();

class _$LoadingStatusSerializer implements PrimitiveSerializer<LoadingStatus> {
  @override
  final Iterable<Type> types = const <Type>[LoadingStatus];
  @override
  final String wireName = 'LoadingStatus';

  @override
  Object serialize(Serializers serializers, LoadingStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  LoadingStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      LoadingStatus.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
