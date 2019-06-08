import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'PrivacySetting.g.dart';

abstract class PrivacySetting
    implements Built<PrivacySetting, PrivacySettingBuilder> {
  static bool defaultOptInAnalytics = true;
  static bool defaultOptInAutoSendCrashReport = true;

  /// Whether user agrees to opt in for analytics.
  bool get optInAnalytics;

  /// Whether user agrees to opt in for crashlytics, enabling it let user
  /// automatically sends a crash report.
  bool get optInAutoSendCrashReport;

  PrivacySetting._();

  factory PrivacySetting([void Function(PrivacySettingBuilder) updates]) =>
      _$PrivacySetting((b) => b
        ..optInAnalytics = defaultOptInAnalytics
        ..optInAutoSendCrashReport = defaultOptInAutoSendCrashReport);

  String toJson() {
    return json
        .encode(serializers.serializeWith(PrivacySetting.serializer, this));
  }

  static PrivacySetting fromJson(String jsonString) {
    return serializers.deserializeWith(
        PrivacySetting.serializer, json.decode(jsonString));
  }

  static Serializer<PrivacySetting> get serializer =>
      _$privacySettingSerializer;
}
