import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import './RouteHandlers.dart';

class Routes {
  static String root = "/";
  static String loginRoute = "/login";
  static String homeRoute = "/home";
  static String bangumiOauthRoute = "/bangumiOauth";
  static String subjectMainPageRoute = "/subject/:subjectId";
  static String subjectDetailInfoPageRoute = "/subject/:subjectId/info";
  static String subjectCollectionManagementRoute =
      "/subject/:subjectId/collection";

  // User
  static String userProfileRoute = "/user/:username";
  static String userProfileTimelineRoute =
      "/user/:username/timeline";
  static String composeTimelineMessageRoute =
      "/user/:username/timeline/new";

  // Setting
  static String settingRoute = "/setting";
  static String generalSettingRoute = "/setting/general";
  static String themeSettingRoute = "/setting/theme";
  static String muteSettingRoute = "/setting/mute";
  static String muteSettingBatchImportUsersRoute =
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
