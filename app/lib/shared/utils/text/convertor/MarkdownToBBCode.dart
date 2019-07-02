import 'dart:convert';

import 'package:markdown/markdown.dart';
import 'package:munin/shared/utils/text/convertor/CustomMarkdown.dart';
import 'package:munin/shared/utils/text/convertor/common.dart';
import 'package:quiver/strings.dart';

String markdownToBBCode(String input) {
  var document = Document(
    extensionSet: ExtensionSet(
      [
        const FencedCodeBlockSyntax(),
      ],
      [
        SpoilerInlineSyntax(),
        StrikethroughSyntax(),
      ],
    ),
    encodeHtml: false,
  );

  // Replace windows line endings with unix line endings, and split.
  var lines = input.replaceAll('\r\n', '\n').split('\n');

  return BBCodeRenderer().render(document.parseLines(lines));
}

const _blockTags = {
  'blockquote',
  'h1',
  'h2',
  'h3',
  'h4',
  'h5',
  'h6',
  'hr',
  'li',
  'ol',
  'p',
  'pre',
  'ul',
};

/// Translates a parsed markdown to BBCode.
class BBCodeRenderer implements NodeVisitor {
  StringBuffer buffer;

  final _elementStack = <Element>[];
  String _lastVisitedTag;

  BBCodeRenderer();

  String render(List<Node> nodes) {
    buffer = StringBuffer();

    for (final node in nodes) {
      node.accept(this);
    }

    return buffer.toString();
  }

  void visitText(Text text) {
    var content = text.text;
    if (const {'p', 'li'}.contains(_lastVisitedTag)) {
      content =
          LineSplitter.split(content).map((line) => line.trimLeft()).join('\n');
      if (text.text.endsWith('\n')) {
        content = '$content\n';
      }
    }
    buffer.write(content);

    _lastVisitedTag = null;
  }

  bool visitElementBefore(Element element) {
    // Hackish. Separate block-level elements with newlines.
    if (buffer.isNotEmpty && _blockTags.contains(element.tag)) {
      buffer.writeln();
    }

    final tag = htmlTagToBBCode(element.tag);

    final shouldAppendLeftCloseBracket =
        isNotEmpty(tag) && !BangumiHtmlTag.isListTag(element.tag);
    if (isNotEmpty(tag)) {
      buffer.write(tag);
    }

    /// Adds only the minimum attributes that can be understood by bangumi
    /// BBCode.
    if (element.tag == BangumiHtmlTag.url &&
        element.attributes.containsKey('href')) {
      buffer.write('${element.attributes['href']}');
    } else if (element.tag == BangumiHtmlTag.img &&
        element.attributes.containsKey('src')) {
      buffer.write('${element.attributes['src']}');
    }
    _lastVisitedTag = element.tag;

    if (element.isEmpty && shouldAppendLeftCloseBracket) {
      // Empty element like <hr/>.
      buffer.write(']');

      if (element.tag == 'br') {
        buffer.write('\n');
      }

      return false;
    } else {
      _elementStack.add(element);
      if (shouldAppendLeftCloseBracket) {
        buffer.write(']');
      }

      return true;
    }
  }

  void visitElementAfter(Element element) {
    assert(identical(_elementStack.last, element));

    if (element.children != null &&
        element.children.isNotEmpty &&
        _blockTags.contains(_lastVisitedTag) &&
        _blockTags.contains(element.tag)) {
      buffer.writeln();
    } else if (element.tag == 'blockquote') {
      buffer.writeln();
    }

    buffer.write(htmlTagToBBCode(
      element.tag,
      leftTag: false,
    ));

    _lastVisitedTag = _elementStack.removeLast().tag;
  }
}
