import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:munin/shared/utils/bangumi/RedirectableUrlResolver.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:munin/shared/utils/misc/Launch.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/widgets/shared/html/MuninWidgetFactory.dart';
import 'package:munin/widgets/shared/text/SpoilerText.dart';
import 'package:munin/widgets/shared/utils/common.dart';
import 'package:url_launcher/url_launcher.dart';

/// Renders a html with some bangumi-specific configs
class BangumiHtml extends StatelessWidget {
  final String html;
  final bool showSpoiler;

  static WidgetFactory _widgetFactory;

  const BangumiHtml({Key key, @required this.html, this.showSpoiler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      html,
      baseUrl: bangumiHostUriForDio,
      factoryBuilder: () => MuninWidgetFactory(),
      enableCaching: false,
      //Optional parameters:
      customWidgetBuilder: (dom.Element e) {
        if (MuninCustomHtmlClasses.hasSpoilerClass(e)) {
          return SpoilerText(
            text: e.text,
            showSpoiler: showSpoiler,
          );
        }
        return null;
      },
      onTapUrl: (String url) {
        final maybeRedirectableContent = resolveRedirectableUrl(url);
        if (maybeRedirectableContent.isNotPresent) {
          return canLaunch(url) != null
              ? launchByPreference(context, url)
              : null;
        }

        final redirectableContent = maybeRedirectableContent.value;

        return generateOnTapCallbackForBangumiContent(
            contentType: redirectableContent.bangumiContent,
            id: redirectableContent.id,
            postId: redirectableContent.postId,
            context: context)();
      },
    );
  }
}
