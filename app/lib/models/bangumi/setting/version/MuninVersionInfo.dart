import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'MuninVersionInfo.g.dart';

abstract class MuninVersionInfo
    implements Built<MuninVersionInfo, MuninVersionInfoBuilder> {
  String get latestVersion;

  /// Whether there is a critical update that's newer than user's current
  /// version.
  bool get hasCriticalUpdate;

  String get downloadPageUrl;

  /// The version that user decides to mute its update prompt.
  ///
  /// User won't receive notification for [mutedUpdateVersion], or version before
  /// [mutedUpdateVersion].
  @nullable
  String get mutedUpdateVersion;

  MuninVersionInfo._();

  factory MuninVersionInfo([void Function(MuninVersionInfoBuilder) updates]) =
      _$MuninVersionInfo;

  String toJson() {
    return json
        .encode(serializers.serializeWith(MuninVersionInfo.serializer, this));
  }

  static MuninVersionInfo fromJson(String jsonString) {
    return serializers.deserializeWith(
        MuninVersionInfo.serializer, json.decode(jsonString));
  }

  static Serializer<MuninVersionInfo> get serializer =>
      _$muninVersionInfoSerializer;
}
