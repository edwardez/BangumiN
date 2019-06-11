import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import './RouteHandlers.dart';

/// Parameters of route variables.
/// To add a new variable, both the variable and its parameter([paramIdentifier] + variableName)
/// need to be the variable list.
class RoutesVariable {
  static const paramIdentifier = ':';

  static const subjectId = 'subjectId';
  static const subjectIdParam = '$paramIdentifier$subjectId';

  static const username = ':username';
  static const usernameParam = '$paramIdentifier$username';

  static const threadId = 'threadId';
  static const threadIdParam = '$paramIdentifier$threadId';
}

class RoutesQueryParameter {
  static const subjectReviewsFriendOnly = 'friendOnly';
  static const subjectReviewsMainFilter = 'subjectMainFilter';
}

class Routes {
  static const root = "/";
  static const loginRoute = "/login";
  static const homeRoute = "/home";
  static const bangumiOauthRoute = "/bangumiOauth";

  // subject
  static const subjectMainPageRoute = "/subject/${RoutesVariable
      .subjectIdParam}";
  static const subjectDetailInfoPageRoute = "/subject/${RoutesVariable
      .subjectIdParam}/info";
  static const subjectCollectionManagementRoute =
      "/subject/${RoutesVariable.subjectIdParam}/collection";
  static const subjectEpisodesRoute =
      "/subject/${RoutesVariable.subjectIdParam}/episodes";
  static const subjectReviewsRoute =
      "/subject/${RoutesVariable.subjectIdParam}/reviews";

  // User
  static const userProfileRoute = "/user/${RoutesVariable.usernameParam}";
  static const userProfileTimelineRoute =
      "/user/${RoutesVariable.usernameParam}/timeline";
  static String composeTimelineMessageRoute =
      "/user/${RoutesVariable.usernameParam}/timeline/new";

  // Setting
  static const settingRoute = "/setting";
  static const generalSettingRoute = "/setting/general";
  static const themeSettingRoute = "/setting/theme";
  static const muteSettingRoute = "/setting/mute";
  static const privacySettingRoute = "/setting/privacy";
  static const muteSettingBatchImportUsersRoute =
      "/setting/mute/users/import/bangumi";


  /// Discussion
  static const groupThreadRoute = "/group/topic/${RoutesVariable
      .threadIdParam}";
  static const episodeThreadRoute = "/episode/${RoutesVariable.threadIdParam}";
  static const subjectTopicThreadRoute = "/subject/topic/${RoutesVariable
      .threadIdParam}";

  /// Blog
  static const blogThreadRoute = "/blog/${RoutesVariable.threadIdParam}";

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
    router.define(subjectEpisodesRoute,
        handler: subjectEpisodesRouteHandler);
    router.define(subjectReviewsRoute,
        handler: subjectReviewsRouteHandler);

    router.define(userProfileRoute, handler: userProfileRouteHandler);

    router.define(composeTimelineMessageRoute,
        handler: composeTimelineMessageRouteHandler);

    router.define(groupThreadRoute,
        handler: groupThreadRouteHandler);
    router.define(episodeThreadRoute,
        handler: episodeThreadRouteHandler);
    router.define(subjectTopicThreadRoute,
        handler: subjectTopicThreadRouteHandler);
    router.define(blogThreadRoute,
        handler: blogThreadRouteHandler);

    router.define(settingRoute, handler: settingRouteHandler);
    router.define(generalSettingRoute, handler: generalSettingRouteHandler);
    router.define(themeSettingRoute, handler: themeSettingRouteHandler);
    router.define(muteSettingRoute, handler: muteSettingRouteHandler);
    router.define(privacySettingRoute, handler: privacySettingRouteHandler);
    router.define(muteSettingBatchImportUsersRoute,
        handler: muteSettingBatchImportUsersRouteHandler);
  }
}
