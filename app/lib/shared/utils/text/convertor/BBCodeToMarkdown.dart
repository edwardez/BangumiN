import 'dart:convert';

import 'package:bbob_dart/bbob_dart.dart';
import 'package:munin/shared/utils/text/convertor/common.dart';

String bbCodeToMarkdown(String bbCode) {
  var ast = parse(
    '[b]bold[/b][i]italic[/i][s]strike[/s][url=https://www.dartlang.org/]'
    '[dart]lang[/url][quote]abc[/quote][code]let x = 1;[/code](bgm35)'
    'newline\n[color=red]彩[/color][color=green]色[/color][color=blue]的[/color]'
    '[color=orange]哟[/color]。[size=10]不同[/size][size=14]大小的[/size]'
    '[size=18]文字[/size]效果也可实现[b][size=20][new!]混合[/size][/b]',
    onError: (msg) {
      print(msg);
    },
    validTags: BangumiTags.allTags,
  );

  return MarkdownRenderer().render(ast);
}

const _blockTags = {BBCodeTag.quote, BBCodeTag.code};

/// Translates a parsed BBCode ast into markdown.
class MarkdownRenderer implements NodeVisitor {
  StringBuffer buffer;

  final _elementStack = <Element>[];
  String _lastVisitedTag;

  MarkdownRenderer();

  String render(List<Node> nodes) {
    buffer = StringBuffer();

    for (final node in nodes) {
      node.accept(this);
    }

    return buffer.toString();
  }

  void visitText(Text text) {
    var content = text.text;
    if (_blockTags.contains(_lastVisitedTag)) {
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
    final lowerCaseTagName = element.tag?.toLowerCase();

    // Hackish. Separate block-level elements with newlines.
    if (buffer.isNotEmpty && _blockTags.contains(lowerCaseTagName)) {
      buffer.writeln();
    }

    buffer.write(bbCodeTagToMarkdown(lowerCaseTagName));

    if (BangumiTags.unsupportedWithAttributesBangumiTags
            .contains(lowerCaseTagName) &&
        element.attributes.isNotEmpty) {
      buffer.write('${element.attributes.keys.first}]');
    }

    _lastVisitedTag = lowerCaseTagName;

    if (element.isChildrenNullOrEmpty) {
      // Empty element.
      buffer.write(bbCodeTagToMarkdown(
        lowerCaseTagName,
        leftTag: false,
      ));

      return false;
    } else {
      _elementStack.add(element);

      return true;
    }
  }

  void visitElementAfter(Element element) {
    final lowerCaseTagName = element.tag?.toLowerCase();
    assert(identical(_elementStack.last, element));

    if (!element.isChildrenNullOrEmpty &&
        _blockTags.contains(_lastVisitedTag) &&
        _blockTags.contains(lowerCaseTagName)) {
      buffer.writeln();
    } else if (lowerCaseTagName == BBCodeTag.quote) {
      buffer.writeln();
    }

    final right = '${bbCodeTagToMarkdown(lowerCaseTagName, leftTag: false)}';

    if (lowerCaseTagName == BBCodeTag.url) {
      final hasNoAttributes = element.attributes.keys.isEmpty;
      final url =
          hasNoAttributes ? element.textContent : element.attributes.keys.first;
      buffer.write('$right(${hasNoAttributes ? element.textContent : url})');
    } else if (lowerCaseTagName == BBCodeTag.img) {
      buffer.write('$right(${element.textContent})');
    } else {
      buffer.write(bbCodeTagToMarkdown(
        lowerCaseTagName,
        leftTag: false,
      ));
      if (lowerCaseTagName == BBCodeTag.code) {
        buffer.writeln();
      }
    }

    _lastVisitedTag = _elementStack.removeLast().tag;
  }
}
