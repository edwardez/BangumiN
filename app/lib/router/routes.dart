import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import './RouteHandlers.dart';

/// Parameters of route variables.
/// To add a new variable, both the variable and its parameter([paramIdentifier] + [RoutesComponents])
/// need to be the variable list.
class RoutesComponents {
  static const subjectId = 'subjectId';
  static const username = 'username';
  static const threadId = 'threadId';
  static const postId = 'postId';
  static const subjectType = 'subjectType';
  static const collectionStatus = 'collectionStatus';
}

class RoutesVariable {
  static const paramIdentifier = ':';

  static const subjectIdParam = '$paramIdentifier${RoutesComponents.subjectId}';
  static const usernameParam = '$paramIdentifier${RoutesComponents.username}';
  static const threadIdParam = '$paramIdentifier${RoutesComponents.threadId}';
  static const postIdParam = '$paramIdentifier${RoutesComponents.postId}';
  static const subjectTypeParam =
      '$paramIdentifier${RoutesComponents.subjectType}';
  static const collectionStatusParam =
      '$paramIdentifier${RoutesComponents.collectionStatus}';
}

class RoutesQueryParameter {
  static const subjectReviewsFriendOnly = 'friendOnly';
  static const subjectReviewsMainFilter = 'subjectMainFilter';
}

class Routes {
  static const root = '/';
  static const loginRoute = '/login';
  static const homeRoute = '/home';

  // subject

  // subject root prefix, [subjectRoutePrefix] itself is not a route.
  static const _subjectRoutePrefix = '/subject/';
  static const subjectMainPageRoute =
      '$_subjectRoutePrefix${RoutesVariable.subjectIdParam}';
  static const subjectDetailInfoPageRoute =
      '$_subjectRoutePrefix${RoutesVariable.subjectIdParam}/info';
  static const subjectCollectionManagementRoute =
      '$_subjectRoutePrefix${RoutesVariable.subjectIdParam}/collection';
  static const subjectEpisodesRoute =
      '$_subjectRoutePrefix${RoutesVariable.subjectIdParam}/episodes';
  static const subjectReviewsRoute =
      '$_subjectRoutePrefix${RoutesVariable.subjectIdParam}/reviews';

  // User
  static const userProfileRoute = '/user/${RoutesVariable.usernameParam}';
  static const userProfileTimelineRoute =
      '/user/${RoutesVariable.usernameParam}/timeline';
  static String composeTimelineMessageRoute =
      '/user/${RoutesVariable.usernameParam}/timeline/new';

  static const userCollectionsListRoute =
      '/user/${RoutesVariable.subjectTypeParam}/list/${RoutesVariable.usernameParam}'
      '/${RoutesVariable.collectionStatusParam}';

  // Setting
  // TODO: figure out why [userCollectionsListRoute] conflicts with [settingRoute]
  static const settingRoute = '/setting';
  static const generalSettingRoute = '/setting/general';
  static const themeSettingRoute = '/setting/theme';
  static const muteSettingRoute = '/setting/mute';
  static const privacySettingRoute = '/setting/privacy';
  static const muteSettingBatchImportUsersRoute =
      '/setting/mute/users/import/bangumi';

  /// Discussion
  static const groupThreadRoute =
      '/group/topic/${RoutesVariable.threadIdParam}/${RoutesVariable
      .postIdParam}';
  static const episodeThreadRoute =
      '/episode/${RoutesVariable.threadIdParam}/${RoutesVariable.postIdParam}';
  static const subjectTopicThreadRoute =
      '/subject/topic/${RoutesVariable.threadIdParam}/${RoutesVariable
      .postIdParam}';

  /// Blog
  static const blogThreadRoute =
      '/blog/${RoutesVariable.threadIdParam}/${RoutesVariable.postIdParam}';

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          return Text('Route is not found!');
    });
    router.define(loginRoute, handler: loginRouteHandler);
    router.define(homeRoute, handler: homeRouteHandler);

    router.define(subjectMainPageRoute, handler: subjectMainPageRouteHandler);
    router.define(subjectDetailInfoPageRoute,
        handler: subjectDetailInfoRouteHandler);
    router.define(subjectCollectionManagementRoute,
        handler: subjectCollectionManagementRouteHandler);
    router.define(subjectEpisodesRoute, handler: subjectEpisodesRouteHandler);
    router.define(subjectReviewsRoute, handler: subjectReviewsRouteHandler);

    router.define(userProfileRoute, handler: userProfileRouteHandler);

    router.define(composeTimelineMessageRoute,
        handler: composeTimelineMessageRouteHandler);

    router.define(userCollectionsListRoute,
        handler: userCollectionsListRouteHandler);

    router.define(groupThreadRoute, handler: groupThreadRouteHandler);
    router.define(episodeThreadRoute, handler: episodeThreadRouteHandler);
    router.define(subjectTopicThreadRoute,
        handler: subjectTopicThreadRouteHandler);
    router.define(blogThreadRoute, handler: blogThreadRouteHandler);

    router.define(settingRoute, handler: settingRouteHandler);
    router.define(generalSettingRoute, handler: generalSettingRouteHandler);
    router.define(themeSettingRoute, handler: themeSettingRouteHandler);
    router.define(muteSettingRoute, handler: muteSettingRouteHandler);
    router.define(privacySettingRoute, handler: privacySettingRouteHandler);
    router.define(muteSettingBatchImportUsersRoute,
        handler: muteSettingBatchImportUsersRouteHandler);
  }
}
