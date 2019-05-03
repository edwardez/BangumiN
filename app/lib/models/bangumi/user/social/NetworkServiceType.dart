import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/material.dart';
import 'package:munin/styles/theme/BangumiPinkBlue.dart';

part 'NetworkServiceType.g.dart';

class NetworkServiceType extends EnumClass {
  static const NetworkServiceType Bangumi = _$Bangumi;
  static const NetworkServiceType Home = _$Home;
  static const NetworkServiceType PSN = _$PSN;
  static const NetworkServiceType XboxLive = _$XboxLive;
  static const NetworkServiceType NS = _$NS;
  static const NetworkServiceType FriendCode = _$FriendCode;
  static const NetworkServiceType Steam = _$Steam;
  static const NetworkServiceType BattleTag = _$BattleTag;
  static const NetworkServiceType Pixiv = _$Pixiv;
  static const NetworkServiceType GitHub = _$Real;
  static const NetworkServiceType Twitter = _$Twitter;
  static const NetworkServiceType Instagram = _$Instagram;
  static const NetworkServiceType Unknown = _$Unknown;

  /// TODO: set color for each sns accordingly
  @memoized
  Color get themeColor {
    switch (this) {
      case NetworkServiceType.Bangumi:
        return BangumiPinkBlue.bangumiPink.shade200;
      case NetworkServiceType.Home:
        return Colors.orange;
      case NetworkServiceType.PSN:
        return Color(0xff004ab0);
      case NetworkServiceType.XboxLive:
        return Color(0xff107c11);
      case NetworkServiceType.NS:
        return Color(0xffe30b20);
      case NetworkServiceType.FriendCode:
        return Color(0xffee1c23);
      case NetworkServiceType.Steam:
        return Color(0xff171a21);
      case NetworkServiceType.BattleTag:
        return Color(0xff007cae);
      case NetworkServiceType.Pixiv:
        return Color(0xff0097dc);
      case NetworkServiceType.GitHub:
        return Color(0xff333333);
      case NetworkServiceType.Twitter:
        return Color(0xff55acee);
      case NetworkServiceType.Instagram:
        return Color(0xffad8466);
      default:
        debugPrint('Recevied unknown sns type value $this');
        return Colors.black;
    }
  }

  static NetworkServiceType fromBangumiValue(String value) {
    value = value?.toLowerCase();
    switch (value) {
      case 'bangumi':
        return NetworkServiceType.Bangumi;
      case 'home':
        return NetworkServiceType.Home;
      case 'psn':
        return NetworkServiceType.PSN;
      case 'xbox live':
        return NetworkServiceType.XboxLive;
      case 'ns':
        return NetworkServiceType.NS;
      case 'friendcode':
        return NetworkServiceType.FriendCode;
      case 'steam':
        return NetworkServiceType.Steam;
      case 'battletag':
        return NetworkServiceType.BattleTag;
      case 'pixiv':
        return NetworkServiceType.Pixiv;
      case 'github':
        return NetworkServiceType.GitHub;
      case 'twitter':
        return NetworkServiceType.Twitter;
      case 'instagram':
        return NetworkServiceType.Instagram;
      default:
        debugPrint('Recevied unknown sns type value $value');
        return NetworkServiceType.Unknown;
    }
  }

  const NetworkServiceType._(String name) : super(name);

  static BuiltSet<NetworkServiceType> get values => _$values;

  static NetworkServiceType valueOf(String name) => _$valueOf(name);

  static Serializer<NetworkServiceType> get serializer =>
      _$networkServiceTypeSerializer;
}
