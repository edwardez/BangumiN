import 'package:html/dom.dart';
import 'package:munin/shared/utils/common.dart';

/// Removes bangumi spoiler text style then adds a
/// [MuninCustomHtmlClasses.muninSpoiler] to it.
///
/// Bangumi defines spoiler as a span that has `background-color:#555`, then
/// uses js event listener to add hover effect, it won't work for us since we
/// don't have event listener, hence this workaround is needed.
DocumentFragment addSpoilerAttribute(
  DocumentFragment document,
) {
  final elements =
      document.querySelectorAll('span[style^="background-color:#555"]');
  for (var element in elements) {
    element.attributes.remove('style');
    element.classes.add(MuninCustomHtmlClasses.muninSpoiler);
  }

  return document;
}
