import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:quiver/strings.dart';
import 'package:url_launcher/url_launcher.dart';

generateOnTapCallbackForBangumiContent({
  BangumiContent contentType,
  String id,
  String pageUrl,
  BuildContext context,
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
      Application.router.navigateTo(context, '/subject/$id',
          transition: TransitionType.native);
    };
  }

  String routeUrl = _getRouterUrlByContentType(contentType, id);

  if (routeUrl != null) {
    return () {
      Application.router
          .navigateTo(context, routeUrl, transition: TransitionType.native);
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
      launch(webPageUrl, forceSafariVC: true);
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

/// checks whether the content type current has a web route page
/// returns null corresponding Bangumi web page cannot be found
String _getRouterUrlByContentType(BangumiContent contentType, String id) {
  if (contentType == BangumiContent.Subject) {
    return '/subject/$id';
  }

  return null;
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
