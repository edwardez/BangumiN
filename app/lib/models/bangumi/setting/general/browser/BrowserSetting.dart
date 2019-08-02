import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/setting/general/browser/LaunchBrowserPreference.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'BrowserSetting.g.dart';

abstract class BrowserSetting
    implements Built<BrowserSetting, BrowserSettingBuilder> {
  LaunchBrowserPreference get launchBrowserPreference;

  BrowserSetting._();

  factory BrowserSetting([void Function(BrowserSettingBuilder) updates]) =>
      _$BrowserSetting((b) =>
          b.launchBrowserPreference = LaunchBrowserPreference.DefaultInApp);

  String toJson() {
    return json
        .encode(serializers.serializeWith(BrowserSetting.serializer, this));
  }

  static BrowserSetting fromJson(String jsonString) {
    return serializers.deserializeWith(
        BrowserSetting.serializer, json.decode(jsonString));
  }

  static Serializer<BrowserSetting> get serializer =>
      _$browserSettingSerializer;
}
