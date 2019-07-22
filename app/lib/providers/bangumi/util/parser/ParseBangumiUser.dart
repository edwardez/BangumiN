import 'package:html/dom.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/common/BangumiUserBasic.dart';
import 'package:munin/providers/bangumi/util/utils.dart';

BangumiUserBasic parseBangumiUserBasic(Element element) {
  final imageUrl = imageUrlFromBackgroundImage(element);

  final userNameElement = element.querySelector('a[href*="/user/"].l');
  final nickname = userNameElement.text;

  final username = parseHrefId(userNameElement);
  return BangumiUserBasic(
    (b) => b
      ..nickname = nickname
      ..username = username
      ..avatar.replace(BangumiImage.fromImageUrl(
          imageUrl, ImageSize.Unknown, ImageType.UserAvatar)),
  );
}
