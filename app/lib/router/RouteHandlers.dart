import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:munin/widgets/UserProfile/UserProfileWidget.dart';
import 'package:munin/widgets/home/MuninHomePage.dart';
import 'package:munin/widgets/initial/BangumiOauthWebview.dart';
import 'package:munin/widgets/initial/MuninLoginPage.dart';
import 'package:munin/widgets/setting/Setting.dart';
import 'package:munin/widgets/setting/mute/ImportBlockedBangumiUsersWidget.dart';
import 'package:munin/widgets/setting/mute/MuteSettingWidget.dart';
import 'package:munin/widgets/setting/theme/ThemeSettingWidget.dart';
import 'package:munin/widgets/subject/SubjectWidget.dart';
import 'package:munin/widgets/subject/info/SubjectDetailInfoWidget.dart';
import 'package:munin/widgets/subject/management/SubjectCollectionManagementWidget.dart';

var loginRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MuninLoginPage();
});

var homeRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MuninHomePage();
});

var bangumiOauthRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return BangumiOauthWebview();
});

var subjectMainPageRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String subjectIdStr = params["subjectId"]?.first;
      int subjectId = tryParseInt(subjectIdStr, defaultValue: null);
  return Scaffold(
    body: SubjectWidget(
      subjectId: subjectId,
    ),
  );
});

var subjectDetailInfoRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String subjectIdStr = params["subjectId"]?.first;
      int subjectId = tryParseInt(subjectIdStr, defaultValue: null);
      return Scaffold(
        body: SubjectDetailInfoWidget(
          subjectId: subjectId,
        ),
      );
    });

var subjectCollectionManagementRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String subjectIdStr = params["subjectId"]?.first;
      int subjectId = tryParseInt(subjectIdStr, defaultValue: null);
      return Scaffold(
        body: SubjectCollectionManagementWidget(
          subjectId: subjectId,
        ),
      );
    });

var userProfileRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String username = params["username"]?.first;

      return Scaffold(
        body: UserProfileWidget(
          username: username,
        ),
      );
    });

/// Setting
var settingRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return SettingHome();
    });

var themeSettingRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return ThemeSettingWidget();
    });

var muteSettingRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return MuteSettingWidget();
    });

var muteSettingBatchImportUsersRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return ImportBlockedBangumiUsersWidget();
    });

