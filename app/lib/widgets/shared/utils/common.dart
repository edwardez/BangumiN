import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/router/routes.dart';
import 'package:quiver/strings.dart';
import 'package:url_launcher/url_launcher.dart';

generateOnTapCallbackForBangumiContent({
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
        'Recevied invalid pair of BangumiContent $contentType and id $id');
    return () {};
  }
  if (contentType == BangumiContent.Subject) {
    return () {
      Application.router.navigateTo(context,
          Routes.subjectMainPageRoute.replaceAll(RoutesVariable.subjectId, id),
          transition: TransitionType.native);
    };
  }

  if (contentType == BangumiContent.User) {
    return () {
      Application.router.navigateTo(context,
          Routes.userProfileRoute.replaceAll(RoutesVariable.username, id),
          transition: TransitionType.native);
    };
  }

  String webPageUrl;

  if (contentType == BangumiContent.Doujin) {
    webPageUrl = pageUrl;
  } else {
    webPageUrl = _getWebPageUrlByContentType(contentType, id);
  }

  if (webPageUrl != null) {
    return () {
      launch(webPageUrl, forceSafariVC: false);
    };
  }

  /// otherwise returns an empty function and logs it
  debugPrint('Recevied invalid pair of BangumiContent $contentType and id $id');
  return () {};
}


/// checks whether the content type current has a app route page
/// returns null corresponding Munin page cannot be found
String _getWebPageUrlByContentType(BangumiContent contentType, String id) {
  String webPageSubRouteName =
  BangumiContent.enumToWebPageRouteName[contentType];

  if (webPageSubRouteName == null || id == null) {
    return null;
  }

  return 'https://${Application.environmentValue
      .bangumiMainHost}/$webPageSubRouteName/$id';
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
    return Theme
        .of(context)
        .colorScheme
        .primary;
  }

  return null;
}

bool isNightTheme(BuildContext context) {
  return Theme
      .of(context)
      .brightness == Brightness.dark;
}
