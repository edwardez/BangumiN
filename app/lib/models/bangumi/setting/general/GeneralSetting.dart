import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionRequest.dart';
import 'package:munin/models/bangumi/progress/common/GetProgressRequest.dart';
import 'package:munin/models/bangumi/setting/general/PreferredLaunchNavTab.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineCategoryFilter.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'GeneralSetting.g.dart';

abstract class GeneralSetting
    implements Built<GeneralSetting, GeneralSettingBuilder> {
  GeneralSetting._();

  @nullable
  PreferredLaunchNavTab get preferredLaunchNavTab;

  TimelineCategoryFilter get preferredTimelineLaunchPage;

  GetProgressRequest get preferredProgressLaunchPage;

  GetDiscussionRequest get preferredDiscussionLaunchPage;

  factory GeneralSetting([updates(GeneralSettingBuilder b)]) =>
      _$GeneralSetting((b) => b
        ..preferredLaunchNavTab = PreferredLaunchNavTab.Timeline
        ..preferredTimelineLaunchPage = TimelineCategoryFilter.AllFeeds
        ..preferredProgressLaunchPage
            .replace(GetProgressRequest.defaultProgressLaunchPageType)
        ..preferredDiscussionLaunchPage
            .replace(GetDiscussionRequest.defaultDiscussionLaunchPageType)
        ..update(updates));

  String toJson() {
    return json
        .encode(serializers.serializeWith(GeneralSetting.serializer, this));
  }

  static GeneralSetting fromJson(String jsonString) {
    return serializers.deserializeWith(
        GeneralSetting.serializer, json.decode(jsonString));
  }

  static Serializer<GeneralSetting> get serializer =>
      _$generalSettingSerializer;
}
