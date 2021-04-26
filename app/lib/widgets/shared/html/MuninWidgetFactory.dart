import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:munin/shared/utils/misc/Launch.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/background/GreyRoundedBorderContainer.dart';
import 'package:munin/widgets/shared/bottomsheet/showMinHeightModalBottomSheet.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';
import 'package:munin/widgets/shared/refresh/AdaptiveProgressIndicator.dart';
import 'package:munin/widgets/shared/services/Clipboard.dart';

class MuninWidgetFactory extends WidgetFactory {
  final _assetOrDataImageUriPattern = RegExp('^(asset|data):');

  MuninWidgetFactory() : super();

  @override
  Widget buildImage(BuildMetadata meta, ImageMetadata image) {
    if (image?.sources == null || image.sources.isEmpty) return null;
    if (image.sources.length > 1) {
      print('More than one url in this image, this is not expected: $image');
    }

    final url = image.sources.first.url;

    if (_assetOrDataImageUriPattern.hasMatch(image.sources.first.url))
      return super.buildImage(meta, image);

    return _InkWellHtmlWrapper(url: url);
  }
}

/// A simpler wrapper to get [BuildContext] since [WidgetFactory.buildImage]
/// doesn't provide one.
class _InkWellHtmlWrapper extends StatelessWidget {
  final url;

  const _InkWellHtmlWrapper({Key key, @required this.url}) : super(key: key);

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
            leading: Icon(AdaptiveIcons.clipBoardIconData),
            title: Text('复制地址'),
            onTap: () {
              ClipboardService.copyAsPlainText(context, url, popContext: true);
            },
          ),
          ListTile(
            leading: Icon(Icons.open_in_browser_rounded),
            title: Text('浏览器中打开'),
            onTap: () {
              launchByPreference(context, url, popContext: true);
            },
          ),
        ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: CachedNetworkImage(
        imageUrl: url,
        fadeOutDuration: Duration(milliseconds: 300),
        fadeInDuration: Duration(milliseconds: 300),
        fit: BoxFit.cover,
        placeholder: (context, url) => AdaptiveProgressIndicator(),
        errorWidget: (context, url, obj) {
          return errorImageWidget(context, url);
        },
      ),
      onTap: () {
        launchByPreference(context, url);
      },
    );
  }
}
