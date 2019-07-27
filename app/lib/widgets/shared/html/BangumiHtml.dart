import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:munin/shared/utils/bangumi/RedirectableUrlResolver.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/html/MuninWidgetFactory.dart';
import 'package:munin/widgets/shared/text/SpoilerText.dart';
import 'package:munin/widgets/shared/utils/common.dart';
import 'package:url_launcher/url_launcher.dart';

/// Renders a html with some bangumi-specific configs
class BangumiHtml extends StatelessWidget {
  final String html;
  final bool showSpoiler;

  const BangumiHtml({Key key, @required this.html, this.showSpoiler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      html,
      factoryBuilder: (context, htmlWidget) =>
          MuninWidgetFactory(context, htmlWidget),
      baseUrl: bangumiNonCdnHostUri,
      bodyPadding: EdgeInsets.zero,
      //Optional parameters:
      builderCallback: (NodeMetadata meta, dom.Element e) {
        if (e.localName == 'span' &&
            e.attributes['style'] != null &&
            e.attributes['style'].startsWith('background-color:#555')) {
          return lazySet(meta,
              buildOp: BuildOp(onWidgets: (NodeMetadata meta, _) {
            return [
              SpoilerText(
                text: meta.domElement.text,
                showSpoiler: showSpoiler,
              )
            ];
          }));
        }

        return meta;
      },
      hyperlinkColor: lightPrimaryDarkAccentColor(context),
      onTapUrl: (String url) {
        final maybeRedirectableContent = resolveRedirectableUrl(url);
        if (maybeRedirectableContent.isNotPresent) {
          return canLaunch(url) != null ? launch(url) : null;
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
