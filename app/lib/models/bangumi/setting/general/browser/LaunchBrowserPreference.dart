import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'LaunchBrowserPreference.g.dart';

/// Preferences for how to launch web url link.
class LaunchBrowserPreference extends EnumClass {
  const LaunchBrowserPreference._(String name) : super(name);

  static const LaunchBrowserPreference DefaultInApp = _$Default;

  static const LaunchBrowserPreference DefaultExternal = _$DefaultExternal;

  @memoized
  String get chineseName {
    switch (this) {
      case LaunchBrowserPreference.DefaultInApp:
        return '内置';
      case LaunchBrowserPreference.DefaultExternal:
      default:
        assert(this == LaunchBrowserPreference.DefaultExternal);
        return '外部';
    }
  }

  /// An explanation of [chineseName].
  @memoized
  String get subChineseName {
    switch (this) {
      case LaunchBrowserPreference.DefaultInApp:
        return '应用内打开';
      case LaunchBrowserPreference.DefaultExternal:
      default:
        assert(this == LaunchBrowserPreference.DefaultExternal);
        return '跳转系统默认浏览器';
    }
  }

  static BuiltSet<LaunchBrowserPreference> get values => _$values;

  static LaunchBrowserPreference valueOf(String name) => _$valueOf(name);

  static Serializer<LaunchBrowserPreference> get serializer =>
      _$launchBrowserPreferenceSerializer;
}
