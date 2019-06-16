// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestStatus.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RequestStatus _$Initial = const RequestStatus._('Initial');
const RequestStatus _$Loading = const RequestStatus._('Loading');
const RequestStatus _$Success = const RequestStatus._('Success');
const RequestStatus _$Timeout = const RequestStatus._('TimeoutException');
const RequestStatus _$UnknownError = const RequestStatus._('UnknownException');

RequestStatus _$valueOf(String name) {
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

final BuiltSet<RequestStatus> _$values =
    new BuiltSet<RequestStatus>(const <RequestStatus>[
  _$Initial,
  _$Loading,
  _$Success,
  _$Timeout,
  _$UnknownError,
]);

Serializer<RequestStatus> _$requestStatusSerializer =
    new _$RequestStatusSerializer();

class _$RequestStatusSerializer implements PrimitiveSerializer<RequestStatus> {
  @override
  final Iterable<Type> types = const <Type>[RequestStatus];
  @override
  final String wireName = 'RequestStatus';

  @override
  Object serialize(Serializers serializers, RequestStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  RequestStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RequestStatus.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
