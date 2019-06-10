import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/discussion/thread/common/GetThreadRequest.dart';
import 'package:munin/models/bangumi/discussion/thread/common/ThreadType.dart';
import 'package:munin/models/bangumi/setting/general/GeneralSetting.dart';
import 'package:munin/router/routes.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:munin/widgets/UserProfile/UserProfileWidget.dart';
import 'package:munin/widgets/discussion/thread/blog/BlogThreadWidget.dart';
import 'package:munin/widgets/discussion/thread/episode/EpisodeThreadWidget.dart';
import 'package:munin/widgets/discussion/thread/group/GroupThreadWidget.dart';
import 'package:munin/widgets/discussion/thread/subject/SubjectTopicThreadWidget.dart';
import 'package:munin/widgets/home/MuninHomePage.dart';
import 'package:munin/widgets/initial/BangumiOauthWebview.dart';
import 'package:munin/widgets/initial/MuninLoginPage.dart';
import 'package:munin/widgets/setting/Setting.dart';
import 'package:munin/widgets/setting/general/GeneralSettingWidget.dart';
import 'package:munin/widgets/setting/mute/ImportBlockedBangumiUsersWidget.dart';
import 'package:munin/widgets/setting/mute/MuteSettingWidget.dart';
import 'package:munin/widgets/setting/privacy/PrivacySettingWidget.dart';
import 'package:munin/widgets/setting/theme/ThemeSettingWidget.dart';
import 'package:munin/widgets/subject/SubjectWidget.dart';
import 'package:munin/widgets/subject/episodes/SubjectEpisodesWidget.dart';
import 'package:munin/widgets/subject/info/SubjectDetailInfoWidget.dart';
import 'package:munin/widgets/subject/management/SubjectCollectionManagementWidget.dart';
import 'package:munin/widgets/timeline/compose/ComposeTimelineMessage.dart';

final loginRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MuninLoginPage();
});

final homeRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return MuninHomePage(
        generalSetting: GeneralSetting(),
      );
    });

final bangumiOauthRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return BangumiOauthWebview();
});

final subjectMainPageRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String subjectIdStr = params[RoutesVariable.subjectId]?.first;
      int subjectId = tryParseInt(subjectIdStr, defaultValue: null);
  return Scaffold(
    body: SubjectWidget(
      subjectId: subjectId,
    ),
  );
});

final subjectDetailInfoRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String subjectIdStr = params[RoutesVariable.subjectId]?.first;
      int subjectId = tryParseInt(subjectIdStr, defaultValue: null);
      return Scaffold(
        body: SubjectDetailInfoWidget(
          subjectId: subjectId,
        ),
      );
    });

final subjectCollectionManagementRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String subjectIdStr = params[RoutesVariable.subjectId]?.first;
      int subjectId = tryParseInt(subjectIdStr, defaultValue: null);
      return SubjectCollectionManagementWidget(
        subjectId: subjectId,
      );
    });

final subjectEpisodesRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String subjectIdStr = params[RoutesVariable.subjectId]?.first;
      int subjectId = tryParseInt(subjectIdStr, defaultValue: null);
      return Scaffold(
        body: SubjectEpisodesWidget(
          subjectId: subjectId,
        ),
      );
    });

/// User
final userProfileRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String username = params[RoutesVariable.username]?.first;

      return Scaffold(
        body: UserProfileWidget(
          username: username,
        ),
      );
    });

final composeTimelineMessageRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return ComposeTimelineMessage();
    });

/// Discussion
final groupThreadRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String threadIdStr = params[RoutesVariable.threadId]?.first;
      int threadId = tryParseInt(threadIdStr, defaultValue: null);
      assert(threadId != null);
      GetThreadRequest request = GetThreadRequest((b) =>
      b
        ..threadType = ThreadType.Group
        ..id = threadId);
      return Scaffold(
        body: GroupThreadWidget(
          request: request,
        ),
      );
    });

final episodeThreadRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String threadIdStr = params[RoutesVariable.threadId]?.first;
      int threadId = tryParseInt(threadIdStr, defaultValue: null);
      assert(threadId != null);
      GetThreadRequest request = GetThreadRequest((b) =>
      b
        ..threadType = ThreadType.Episode
        ..id = threadId);
      return Scaffold(
        body: EpisodeThreadWidget(
          request: request,
        ),
      );
    });

final subjectTopicThreadRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String threadIdStr = params[RoutesVariable.threadId]?.first;
      int threadId = tryParseInt(threadIdStr, defaultValue: null);
      assert(threadId != null);
      GetThreadRequest request = GetThreadRequest((b) =>
      b
        ..threadType = ThreadType.SubjectTopic
        ..id = threadId);
      return Scaffold(
        body: SubjectTopicThreadWidget(
          request: request,
        ),
      );
    });

final blogThreadRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String threadIdStr = params[RoutesVariable.threadId]?.first;
      int threadId = tryParseInt(threadIdStr, defaultValue: null);
      assert(threadId != null);
      GetThreadRequest request = GetThreadRequest((b) =>
      b
        ..threadType = ThreadType.Blog
        ..id = threadId);
      return Scaffold(
        body: BlogThreadWidget(
          request: request,
        ),
      );
    });

/// Setting
final settingRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return Scaffold(
        body: SettingHome(),
      );
    });

final generalSettingRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return Scaffold(
        body: GeneralSettingWidget(),
      );
    });

final themeSettingRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return Scaffold(
        body: ThemeSettingWidget(),
      );
    });

final privacySettingRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return Scaffold(
        body: PrivacySettingWidget(),
      );
    });

final muteSettingRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return Scaffold(
        body: MuteSettingWidget(),
      );
    });

final muteSettingBatchImportUsersRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return ImportBlockedBangumiUsersWidget();
    });
