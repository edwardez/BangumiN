import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/router/routes.dart';
import 'package:quiver/core.dart';
import 'package:quiver/strings.dart';
import 'package:url_launcher/url_launcher.dart';

Function generateOnTapCallbackForBangumiContent({
  @required BangumiContent contentType,
  @required String id,
  @required BuildContext context,
  String pageUrl,
}) {
  assert(contentType != null);
  assert(id != null);
  assert(context != null);

  /// if it's empty or null, returns empty function
  if (isEmpty(id)) {
    debugPrint(
        'Recevied empty id $id with BangumiContent $contentType while trying to'
        'generate BangumiContent callback');
    return () {};
  }
  if (contentType == BangumiContent.Subject) {
    return () {
      Application.router.navigateTo(
          context,
          Routes.subjectMainPageRoute
              .replaceAll(RoutesVariable.subjectIdParam, id),
          transition: TransitionType.native);
    };
  }

  if (contentType == BangumiContent.User) {
    return () {
      Application.router.navigateTo(context,
          Routes.userProfileRoute.replaceAll(RoutesVariable.usernameParam, id),
          transition: TransitionType.native);
    };
  }

  if (contentType == BangumiContent.GroupTopic) {
    return () {
      Application.router.navigateTo(context,
          Routes.groupThreadRoute.replaceAll(RoutesVariable.threadIdParam, id),
          transition: TransitionType.native);
    };
  }

  if (contentType == BangumiContent.Episode) {
    return () {
      Application.router.navigateTo(
          context,
          Routes.episodeThreadRoute
              .replaceAll(RoutesVariable.threadIdParam, id),
          transition: TransitionType.native);
    };
  }

  if (contentType == BangumiContent.SubjectTopic) {
    return () {
      Application.router.navigateTo(
          context,
          Routes.subjectTopicThreadRoute
              .replaceAll(RoutesVariable.threadIdParam, id),
          transition: TransitionType.native);
    };
  }

  if (contentType == BangumiContent.Blog) {
    return () {
      Application.router.navigateTo(context,
          Routes.blogThreadRoute.replaceAll(RoutesVariable.threadIdParam, id),
          transition: TransitionType.native);
    };
  }

  String webPageUrl;

  if (contentType == BangumiContent.Doujin) {
    webPageUrl = pageUrl;
  } else {
    generateWebPageUrlByContentType(contentType, id).ifPresent((url) {
      webPageUrl = url;
    });
  }

  if (webPageUrl != null) {
    return () {
      launch(webPageUrl, forceSafariVC: false);
    };
  }

  /// otherwise returns an empty function and logs it
  debugPrint(
      'Recevied invalid pair of BangumiContent $contentType and id $id while '
      'trying to generate BangumiContent callback');
  return () {};
}

/// Generates corresponding bangumi web url.
/// returns null corresponding Munin page cannot be found
Optional<String> generateWebPageUrlByContentType(
    BangumiContent contentType, String id) {
  String webPageSubRouteName = contentType.webPageRouteName;

  if (id == null) {
    return Optional.absent();
  }

  return Optional.of(
      'https://${Application.environmentValue.bangumiMainHost}/$webPageSubRouteName/$id');
}

/// TODO: figure out a better way to calculate text height
getTextOffsetHeight(String title, String subtitle, TextStyle textStyle) {
  int textFactor = 0;

  if (title != null && subtitle != null) {
    textFactor = 3;
  } else if (title != null || subtitle != null) {
    textFactor = 2;
  }

  return textFactor * textStyle.fontSize;
}

/// on iOS, set secondary theme color as target color
/// on other platforms, returns null(use widget default)
getSwitchActiveColor(BuildContext context) {
  if (Platform.isIOS) {
    return Theme.of(context).colorScheme.primary;
  }

  return null;
}

bool isNightTheme(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}

/// Returns address of bangumi main site with https scheme.
String httpsBangumiMainSite() {
  return 'https://${Application.environmentValue.bangumiMainHost}';
}