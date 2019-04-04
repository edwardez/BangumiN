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
  }
}
