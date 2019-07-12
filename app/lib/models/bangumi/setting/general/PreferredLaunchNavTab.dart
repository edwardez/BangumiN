import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'PreferredLaunchNavTab.g.dart';

class PreferredLaunchNavTab extends EnumClass {
  static const PreferredLaunchNavTab Timeline = _$Timeline;

  static const PreferredLaunchNavTab Progress = _$Progress;

  static const PreferredLaunchNavTab Discussion = _$Discussion;

  static const PreferredLaunchNavTab HomePage = _$HomePage;

  String get chineseName {
    switch (this) {
      case PreferredLaunchNavTab.Timeline:
        return '时间线';
      case PreferredLaunchNavTab.Progress:
        return '进度';
      case PreferredLaunchNavTab.Discussion:
        return '讨论';
      case PreferredLaunchNavTab.HomePage:
        return '主页';
      default:
        assert(false, '$this doesn\'t have a valid chiense name');
        return '-';
    }
  }

  String get generalSettingPageChineseName {
    switch (this) {
      case PreferredLaunchNavTab.Timeline:
        return '时间线';
      case PreferredLaunchNavTab.Progress:
        return '进度页';
      case PreferredLaunchNavTab.Discussion:
        return '讨论页';
      case PreferredLaunchNavTab.HomePage:
        return '我的时光机';
      default:
        assert(false, '$this doesn\'t have a valid chiense name');
        return '-';
    }
  }

  /// A page index that's used to track index of child to set in `PageStorage`
  int get pageIndex {
    switch (this) {
      case PreferredLaunchNavTab.Timeline:
        return 0;
      case PreferredLaunchNavTab.Progress:
        return 1;
      case PreferredLaunchNavTab.Discussion:
        return 2;
      case PreferredLaunchNavTab.HomePage:
        return 3;
      default:
        assert(false, '$this doesn\'t have a valid page index');
        return 0;
    }
  }

  const PreferredLaunchNavTab._(String name) : super(name);

  static BuiltSet<PreferredLaunchNavTab> get values => _$values;

  static PreferredLaunchNavTab valueOf(String name) => _$valueOf(name);

  static Serializer<PreferredLaunchNavTab> get serializer =>
      _$preferredLaunchNavTabSerializer;

  static PreferredLaunchNavTab fromWiredName(String wiredName) {
    return serializers.deserializeWith(
        PreferredLaunchNavTab.serializer, wiredName);
  }
}
