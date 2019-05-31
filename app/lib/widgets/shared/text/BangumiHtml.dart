import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/text/SpoilerText.dart';
import 'package:url_launcher/url_launcher.dart';

/// Renders a html with some bangumi-specific configs
class BangumiHtml extends StatelessWidget {
  final String html;

  const BangumiHtml({Key key, @required this.html}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
        data: html,
        //Optional parameters:
        customRender: (node, children) {
          if (node is dom.Element) {
            if (node.localName == 'span' &&
                node.attributes['style'].startsWith('background-color:#555')) {
              return SpoilerText(text: node.text ?? '');
            }
          }
        },
        onLinkTap: (url) {
          launch(url, forceSafariVC: false);
        },
        linkStyle: TextStyle(
            decoration: TextDecoration.underline,
            color: lightPrimaryDarkAccentColor(context),
            decorationColor: lightPrimaryDarkAccentColor(context)));
  }
}
