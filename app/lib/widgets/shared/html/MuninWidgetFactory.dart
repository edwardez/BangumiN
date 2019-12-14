import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:munin/shared/utils/misc/Launch.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/background/GreyRoundedBorderContainer.dart';
import 'package:munin/widgets/shared/bottomsheet/showMinHeightModalBottomSheet.dart';
import 'package:munin/widgets/shared/services/Clipboard.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class MuninWidgetFactory extends WidgetFactory {


  static errorImageWidget(
    BuildContext context,
    String url,
  ) {
    return InkWell(
      child: GreyRoundedBorderContainer(
        child: Text(
          url,
          style: defaultCaptionText(context),
        ),
      ),
      onTap: () {
        showMinHeightModalBottomSheet(context, [
          Padding(
            padding: EdgeInsets.all(mediumOffset),
            child: Center(
              child: Text('此图片加载失败'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.content_copy),
            title: Text('复制地址'),
            onTap: () {
              ClipboardService.copyAsPlainText(context, url, popContext: true);
            },
          ),
          ListTile(
            leading: Icon(OMIcons.openInBrowser),
            title: Text('浏览器中打开'),
            onTap: () {
              launchByPreference(context, url, popContext: true);
            },
          ),
        ]);
      },
    );
  }

  MuninWidgetFactory(HtmlWidgetConfig _config) : super(_config);

  @override
  ImageProvider buildImageFromUrl(String url) => url?.isNotEmpty == true
      ? CachedNetworkImageProvider(
          url,
        )
      : null;
}
