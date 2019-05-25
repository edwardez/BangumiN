import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import './RouteHandlers.dart';

class RoutesVariable {
  static const subjectId = ':subjectId';
  static const username = ':username';
}

class Routes {
  static const root = "/";
  static const loginRoute = "/login";
  static const homeRoute = "/home";
  static const bangumiOauthRoute = "/bangumiOauth";
  static const subjectMainPageRoute = "/subject/${RoutesVariable.subjectId}";
  static const subjectDetailInfoPageRoute = "/subject/${RoutesVariable
      .subjectId}/info";
  static const subjectCollectionManagementRoute =
      "/subject/${RoutesVariable.subjectId}/collection";

  // User
  static const userProfileRoute = "/user/${RoutesVariable.username}";
  static const userProfileTimelineRoute =
      "/user/${RoutesVariable.username}/timeline";
  static String composeTimelineMessageRoute =
      "/user/${RoutesVariable.username}/timeline/new";

  // Setting
  static const settingRoute = "/setting";
  static const generalSettingRoute = "/setting/general";
  static const themeSettingRoute = "/setting/theme";
  static const muteSettingRoute = "/setting/mute";
  static const muteSettingBatchImportUsersRoute =
      "/setting/mute/users/import/bangumi";


  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("Route is not found!");
    });
    router.define(loginRoute, handler: loginRouteHandler);
    router.define(homeRoute, handler: homeRouteHandler);
    router.define(bangumiOauthRoute, handler: bangumiOauthRouteHandler);
    router.define(subjectMainPageRoute, handler: subjectMainPageRouteHandler);
    router.define(subjectDetailInfoPageRoute,
        handler: subjectDetailInfoRouteHandler);
    router.define(subjectCollectionManagementRoute,
        handler: subjectCollectionManagementRouteHandler);
    router.define(userProfileRoute, handler: userProfileRouteHandler);
    router.define(composeTimelineMessageRoute,
        handler: composeTimelineMessageRouteHandler);
    router.define(settingRoute, handler: settingRouteHandler);
    router.define(generalSettingRoute, handler: generalSettingRouteHandler);
    router.define(themeSettingRoute, handler: themeSettingRouteHandler);
    router.define(muteSettingRoute, handler: muteSettingRouteHandler);
    router.define(muteSettingBatchImportUsersRoute,
        handler: muteSettingBatchImportUsersRouteHandler);
  }
}
