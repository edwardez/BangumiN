// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NetworkServiceType.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NetworkServiceType _$Bangumi = const NetworkServiceType._('Bangumi');
const NetworkServiceType _$Home = const NetworkServiceType._('Home');
const NetworkServiceType _$PSN = const NetworkServiceType._('PSN');
const NetworkServiceType _$XboxLive = const NetworkServiceType._('XboxLive');
const NetworkServiceType _$NS = const NetworkServiceType._('NS');
const NetworkServiceType _$FriendCode =
    const NetworkServiceType._('FriendCode');
const NetworkServiceType _$Steam = const NetworkServiceType._('Steam');
const NetworkServiceType _$BattleTag = const NetworkServiceType._('BattleTag');
const NetworkServiceType _$Pixiv = const NetworkServiceType._('Pixiv');
const NetworkServiceType _$Real = const NetworkServiceType._('GitHub');
const NetworkServiceType _$Twitter = const NetworkServiceType._('Twitter');
const NetworkServiceType _$Instagram = const NetworkServiceType._('Instagram');
const NetworkServiceType _$Unknown = const NetworkServiceType._('Unknown');

NetworkServiceType _$valueOf(String name) {
  switch (name) {
    case 'Bangumi':
      return _$Bangumi;
    case 'Home':
      return _$Home;
    case 'PSN':
      return _$PSN;
    case 'XboxLive':
      return _$XboxLive;
    case 'NS':
      return _$NS;
    case 'FriendCode':
      return _$FriendCode;
    case 'Steam':
      return _$Steam;
    case 'BattleTag':
      return _$BattleTag;
    case 'Pixiv':
      return _$Pixiv;
    case 'GitHub':
      return _$Real;
    case 'Twitter':
      return _$Twitter;
    case 'Instagram':
      return _$Instagram;
    case 'Unknown':
      return _$Unknown;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<NetworkServiceType> _$values =
    new BuiltSet<NetworkServiceType>(const <NetworkServiceType>[
  _$Bangumi,
  _$Home,
  _$PSN,
  _$XboxLive,
  _$NS,
  _$FriendCode,
  _$Steam,
  _$BattleTag,
  _$Pixiv,
  _$Real,
  _$Twitter,
  _$Instagram,
  _$Unknown,
]);

Serializer<NetworkServiceType> _$networkServiceTypeSerializer =
    new _$NetworkServiceTypeSerializer();

class _$NetworkServiceTypeSerializer
    implements PrimitiveSerializer<NetworkServiceType> {
  @override
  final Iterable<Type> types = const <Type>[NetworkServiceType];
  @override
  final String wireName = 'NetworkServiceType';

  @override
  Object serialize(Serializers serializers, NetworkServiceType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  NetworkServiceType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      NetworkServiceType.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
