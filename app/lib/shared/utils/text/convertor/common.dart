class BBCodeTag {
  static const bold = 'b';
  static const italic = 'i';
  static const strike = 's';
  static const mask = 'mask';
  static const url = 'url';
  static const img = 'img';
  static const quote = 'quote';
  static const code = 'code';

  /// Following tags are not supported in markdown, but valid on Bangumi.
  static const size = 'size';
  static const color = 'color';
  static const underscore = 'code';
}

class BangumiTags {
  static final supportedBangumiTags = {
    BBCodeTag.bold,
    BBCodeTag.italic,
    BBCodeTag.strike,
    BBCodeTag.mask,
    BBCodeTag.url,
    BBCodeTag.img,
    BBCodeTag.quote,
    BBCodeTag.code,
  };

  /// An unsupported bangumi tag that might contain attributes.
  static Set<String> unsupportedWithAttributesBangumiTags = {
    BBCodeTag.color,
    BBCodeTag.size,
  };

  /// An unsupported bangumi tag that doesn't contain attributes.
  static Set<String> unsupportedWithoutAttributesBangumiTags = {
    BBCodeTag.underscore,
  };

  static final Set<String> allTags = {
    ...supportedBangumiTags,
    ...unsupportedWithAttributesBangumiTags,
    ...unsupportedWithoutAttributesBangumiTags,
  };
}

String bbCodeTagToMarkdown(String tag, {bool leftTag = true}) {
  switch (tag) {
    case BBCodeTag.bold:
      return '**';
    case BBCodeTag.italic:
      return '*';
    case BBCodeTag.strike:
      return '~~';
    case BBCodeTag.mask:
      return leftTag ? '>!' : '!<';
    case BBCodeTag.url:
      return leftTag ? '[' : ']';
    case BBCodeTag.img:
      return leftTag ? '![' : ']';
    case BBCodeTag.quote:
      return leftTag ? '>' : '';
    case BBCodeTag.code:
      return '```';
    case BBCodeTag.underscore:
      return leftTag
          ? '[${BBCodeTag.underscore}]'
          : '[/${BBCodeTag.underscore}]';
    case BBCodeTag.color:
      return leftTag ? '[${BBCodeTag.color}=' : '[/${BBCodeTag.color}]';
    case BBCodeTag.size:
      return leftTag ? '[${BBCodeTag.size}=' : '[/${BBCodeTag.size}]';
    default:
      return '';
  }
}

class BangumiHtmlTag {
  static const _listTags = {
    BangumiHtmlTag.ol,
    BangumiHtmlTag.li,
    BangumiHtmlTag.ul,
  };

  static const h1 = 'h1';
  static const h2 = 'h2';
  static const h3 = 'h3';
  static const h4 = 'h4';
  static const h5 = 'h5';
  static const h6 = 'h6';
  static const bold = 'strong';
  static const italic = 'em';
  static const strike = 'del';
  static const blockquote = 'blockquote';
  static const ul = 'ul';
  static const li = 'li';
  static const ol = 'ol';
  static const code = 'code';
  static const pre = 'pre';
  static const img = 'img';
  static const url = 'a';
  static const inlineSpoiler = 'bangumi-inline-spoiler';

  static bool isListTag(String tag) {
    return _listTags.contains(tag);
  }
}

String htmlTagToBBCode(String tag, {bool leftTag = true}) {
  switch (tag) {
    case BangumiHtmlTag.h1:
    case BangumiHtmlTag.h2:
    case BangumiHtmlTag.h3:
    case BangumiHtmlTag.h4:
    case BangumiHtmlTag.h5:
    case BangumiHtmlTag.h6:
    case BangumiHtmlTag.bold:
      return leftTag ? '[${BBCodeTag.bold}' : '[/${BBCodeTag.bold}]';
    case BangumiHtmlTag.italic:
      return leftTag ? '[${BBCodeTag.italic}' : '[/${BBCodeTag.italic}]';
    case BangumiHtmlTag.strike:
      return leftTag ? '[${BBCodeTag.strike}' : '[/${BBCodeTag.strike}]';
    case BangumiHtmlTag.blockquote:
      return leftTag ? '[${BBCodeTag.quote}' : '[/${BBCodeTag.quote}]';
    case BangumiHtmlTag.li:
      return leftTag ? '* ' : '';
    case BangumiHtmlTag.code:
      return leftTag ? '[${BBCodeTag.code}' : '[/${BBCodeTag.code}]';
    case BangumiHtmlTag.img:
      return leftTag ? '[${BBCodeTag.img}=' : '[/${BBCodeTag.img}]';
    case BangumiHtmlTag.inlineSpoiler:
      return leftTag ? '[${BBCodeTag.mask}' : '[/${BBCodeTag.mask}]';
    case BangumiHtmlTag.url:
      return leftTag ? '[${BBCodeTag.url}=' : '[/${BBCodeTag.url}]';
    case BangumiHtmlTag.pre:
      return '';
    default:
      return '';
  }
}
