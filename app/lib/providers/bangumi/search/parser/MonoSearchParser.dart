import 'dart:collection';

import 'package:html/dom.dart';
import 'package:html/parser.dart' show parseFragment;
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/search/SearchType.dart';
import 'package:munin/models/bangumi/search/result/MonoSearchResult.dart';
import 'package:munin/providers/bangumi/util/utils.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:quiver/core.dart';

class MonoSearchParser {
  Optional<MonoSearchResult> _parseMonoSearchResult(
      Element monoElement, SearchType searchType) {
    Element nameElement = monoElement.querySelector('h2 a');

    /// [nameElement] must not be null and it's first node must be text node
    /// which contains original name, and its id must not be null,
    /// if not, we returns null immediately
    if (nameElement == null ||
        nameElement.nodes[0].nodeType != Node.TEXT_NODE) {
      return Optional.absent();
    }

    int id = tryParseInt(
        parseHrefId(nameElement, digitOnly: true), defaultValue: null);

    if (id == null) {
      return Optional.absent();
    }

    String name = nameElement.nodes[0].text;
    name = name.replaceAll(RegExp(r'\s+/\s*'), '');

    String chineseName = nameElement
        .querySelector('.tip')
        ?.text ?? '';

    List<String> miscInfo = [];

    Element miscElement = monoElement.querySelector('.prsn_info .tip');
    String miscInfoRawText = miscElement?.text ?? '';
    for (String miscItem in miscInfoRawText.split('/')) {
      String trimmedMiscItem = miscItem.trim();
      if (trimmedMiscItem.isNotEmpty) {
        miscInfo.add(miscItem.trim());
      }
    }

    String imageUrl = imageSrcOrFallback(
        monoElement.querySelector('.avatar.ll'));
    BangumiImage image =
    BangumiImage.fromImageUrl(imageUrl, ImageSize.Grid, ImageType.MonoAvatar);

    MonoSearchResult monoSearchResult = MonoSearchResult((b) => b
      ..id = id
      ..name = name
      ..chineseName = chineseName
      ..type = searchType
      ..image.replace(image)
      ..miscInfo.replace(miscInfo));

    return Optional.of(monoSearchResult);
  }

  LinkedHashMap<int, MonoSearchResult> processMonoSearch(String rawHtml,
      {@required SearchType searchType}) {
    assert(searchType != null && searchType.isMonoSearchType);

    DocumentFragment document = parseFragment(rawHtml);
    List<Element> monoElements = document.querySelectorAll('.light_odd');

    /// key is id in [int] format, value is [MonoSearchResult]
    LinkedHashMap<int, MonoSearchResult> monoSearchResults =
        LinkedHashMap<int, MonoSearchResult>();

    for (Element monoElement in monoElements) {
      Optional<MonoSearchResult> maybeMonoSearchResult =
      _parseMonoSearchResult(monoElement, searchType);
      if (maybeMonoSearchResult.isPresent) {
        MonoSearchResult monoSearchResult = maybeMonoSearchResult.value;
        monoSearchResults[monoSearchResult.id] = monoSearchResult;
      }
    }

    return monoSearchResults;
  }
}
