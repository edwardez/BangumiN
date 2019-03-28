import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:munin/widgets/home/MuninHomePage.dart';
import 'package:munin/widgets/initial/BangumiOauthWebview.dart';
import 'package:munin/widgets/initial/MuninLoginPage.dart';
import 'package:munin/widgets/subject/SubjectWidget.dart';
import 'package:munin/widgets/subject/info/SubjectDetailInfoWidget.dart';

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
