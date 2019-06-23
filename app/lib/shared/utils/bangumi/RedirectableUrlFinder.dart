import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:quiver/core.dart';

_escapeRoute(String route) => route.replaceAll('/', r'\/');

_unescapeRoute(String route) => route.replaceAll(r'\/', '/');

/// Supported sub routes that need to be captures.
///
/// New sub-route should be added to [_supportedSubRoutesWithDigitOnlyId] or
/// [_supportedSubRoutesWithAlphanumericId] depending pattern of the id.
/// Note that '/' in route is escaped to '\/'
final _supportedSubRoutesWithDigitOnlyId = [
  BangumiContent.Subject.webPageRouteName,
  BangumiContent.SubjectTopic.webPageRouteName,
  BangumiContent.Episode.webPageRouteName,
  BangumiContent.GroupTopic.webPageRouteName,
  BangumiContent.Blog.webPageRouteName,
]
// should only follow with digits
    .map((route) => route + r'(?=/\d+)');

final _supportedSubRoutesWithAlphanumericId = [
  BangumiContent.User.webPageRouteName,
] // should only follow with alphanumerics
    .map((route) => route + r'(?=/\w+)');

final _supportedSubRoutes = [
  ..._supportedSubRoutesWithAlphanumericId,
  ..._supportedSubRoutesWithDigitOnlyId,
].map(_escapeRoute);

final possibleDomains = r'https?:\/\/(?:bgm\.tv|bangumi\.tv|chii\.in)\/';

final _possibleSubRoutes = '(${_supportedSubRoutes.join('|')})';

final _urlRegex = RegExp('$possibleDomains'
    '$_possibleSubRoutes\\/(\\w+)');

/// Checks whether the url can be redirected to a munin-internal widget, returns
/// its value in [Optional] if such widget exists.
Optional<RedirectableUrlInfo> findRedirectableUrl(String url) {
  if (url == null) {
    return Optional.absent();
  }

  final matchers = _urlRegex.firstMatch(url);

  // [urlMatcher] specifies 2 capturing group.
  if (matchers == null || matchers.groupCount != 2) {
    return Optional.absent();
  }

  final contentType = BangumiContent.bangumiContentFromWebPageRouteName(
      _unescapeRoute(matchers.group(1)));

  if (contentType.isNotPresent) {
    return Optional.absent();
  }

  return Optional.of(RedirectableUrlInfo(
    contentType.value,
    matchers.group(2),
  ));
}

class RedirectableUrlInfo {
  final String id;
  final BangumiContent bangumiContent;

  const RedirectableUrlInfo(
    this.bangumiContent,
    this.id,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RedirectableUrlInfo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          bangumiContent == other.bangumiContent;

  @override
  int get hashCode => id.hashCode ^ bangumiContent.hashCode;

  @override
  String toString() {
    return 'RedirectableUrlInfo{id: $id, bangumiContent: $bangumiContent}';
  }
}
