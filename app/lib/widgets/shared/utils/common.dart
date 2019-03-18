import 'package:munin/models/Bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/models/Bangumi/timeline/common/HyperItem.dart';
import 'package:quiver/core.dart';
import 'package:quiver/strings.dart';
import 'package:url_launcher/url_launcher.dart';

generateOnTapCallbackForBangumiContent(HyperItem hyperItem) {
  assert(hyperItem != null);

  /// if it's empty or null, returns empty function
  if (isEmpty(hyperItem.pageUrl)) return () {};

  Optional<String> maybeRouteUrl =
      _getRouterUrlByContentType(hyperItem.contentType);

  if (maybeRouteUrl.isPresent) {
    /// TODO: supports navigate to an internal app page
    return () => {launch(hyperItem.pageUrl, forceSafariVC: true)};
  }

  return () => {launch(hyperItem.pageUrl, forceSafariVC: true)};
}

Optional<String> _getRouterUrlByContentType(BangumiContent contentType) {
  return Optional.absent();
}
