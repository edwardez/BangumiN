import 'dart:collection';

import 'package:html/dom.dart';
import 'package:html/parser.dart' show parseFragment;
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/common/Images.dart';
import 'package:munin/models/bangumi/search/SearchType.dart';
import 'package:munin/models/bangumi/search/result/MonoSearchResult.dart';
import 'package:munin/providers/bangumi/util/utils.dart';
import 'package:munin/shared/utils/common.dart';

class MonoSearchParser {
  MonoSearchResult parseMonoSearchResult(
      Element monoElement, SearchType searchType) {
    Element nameElement = monoElement.querySelector('h2 a');

    /// [nameElement] must not be null and it's first node must be text node
    /// which contains original name, and its id must not be null,
    /// if not, we returns null immediately
    if (nameElement == null ||
        nameElement.nodes[0].nodeType != Node.TEXT_NODE) {
      return null;
    }

    int id = tryParseInt(parseHrefId(nameElement), defaultValue: null);

    if (id == null) {
      return null;
    }

    String name = nameElement.nodes[0].text;
    name = name.replaceAll(RegExp(r'\s+/\s*'), '');

    String nameCn = nameElement.querySelector('.tip')?.text ?? '';

    List<String> miscInfo = [];

    Element miscElement = monoElement.querySelector('.prsn_info .tip');
    String miscInfoRawText = miscElement?.text ?? '';
    for (String miscItem in miscInfoRawText.split('/')) {
      String trimmedMiscItem = miscItem.trim();
      if (trimmedMiscItem.isNotEmpty) {
        miscInfo.add(miscItem.trim());
      }
    }

    String imageUrl = imageSrcOrNull(monoElement.querySelector('.avatar.ll'));
    Images images =
        Images.fromImageUrl(imageUrl, ImageSize.Grid, ImageType.MonoAvatar);

    MonoSearchResult monoSearchResult = MonoSearchResult((b) => b
      ..id = id
      ..name = name
      ..nameCn = nameCn
      ..type = searchType
      ..images.replace(images)
      ..miscInfo.replace(miscInfo));

    return monoSearchResult;
  }

  LinkedHashMap<int, MonoSearchResult> process(String rawHtml,
      {@required SearchType searchType}) {
    assert(searchType != null && searchType.isMonoSearchType);

    DocumentFragment document = parseFragment(rawHtml);
    List<Element> monoElements = document.querySelectorAll('.light_odd');

    /// key is id in [int] format, value is [MonoSearchResult]
    LinkedHashMap<int, MonoSearchResult> monoSearchResults =
        LinkedHashMap<int, MonoSearchResult>();

    for (Element monoElement in monoElements) {
      MonoSearchResult monoSearchResult =
          parseMonoSearchResult(monoElement, searchType);
      if (monoSearchResult != null) {
        monoSearchResults[monoSearchResult.id] = monoSearchResult;
      }
    }

    return monoSearchResults;
  }
}
