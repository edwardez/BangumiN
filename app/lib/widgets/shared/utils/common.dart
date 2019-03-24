import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/Bangumi/timeline/common/BangumiContent.dart';
import 'package:quiver/core.dart';
import 'package:quiver/strings.dart';
import 'package:url_launcher/url_launcher.dart';

generateOnTapCallbackForBangumiContent({
  BangumiContent contentType,
  String pageUrl,
  String id,
  BuildContext context,
}) {
  assert(contentType != null);

  /// if it's empty or null, returns empty function
  if (isEmpty(id)) return () {};

  if (contentType == BangumiContent.Subject) {
    return () {
      Application
          .router
          .navigateTo(context,
          '/subject/$id',
          transition: TransitionType.native);
    };
  }

  if (isEmpty(pageUrl)) return () {};

  Optional<String> maybeRouteUrl =
  _getRouterUrlByContentType(contentType);

  if (maybeRouteUrl.isPresent) {
    /// TODO: supports navigate to an internal app page
    return () =>
    {
    launch(pageUrl, forceSafariVC: true)
    };
  }

  return () =>
  {
  launch(pageUrl, forceSafariVC: true)
  };
}

Optional<String> _getRouterUrlByContentType(BangumiContent contentType) {
  return Optional.absent();
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
