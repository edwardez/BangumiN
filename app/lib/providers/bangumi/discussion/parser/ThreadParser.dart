import 'dart:ui';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parseFragment;
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/common/BangumiUserBasic.dart';
import 'package:munin/models/bangumi/discussion/thread/blog/BlogContent.dart';
import 'package:munin/models/bangumi/discussion/thread/blog/BlogThread.dart';
import 'package:munin/models/bangumi/discussion/thread/common/OriginalPost.dart';
import 'package:munin/models/bangumi/discussion/thread/common/Post.dart';
import 'package:munin/models/bangumi/discussion/thread/episode/EpisodeThread.dart';
import 'package:munin/models/bangumi/discussion/thread/episode/ThreadRelatedEpisode.dart';
import 'package:munin/models/bangumi/discussion/thread/group/GroupThread.dart';
import 'package:munin/models/bangumi/discussion/thread/post/MainPostReply.dart';
import 'package:munin/models/bangumi/discussion/thread/post/SubPostReply.dart';
import 'package:munin/models/bangumi/discussion/thread/subject/SubjectTopicThread.dart';
import 'package:munin/models/bangumi/progress/common/AirStatus.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:munin/models/bangumi/subject/common/ParentSubject.dart';
import 'package:munin/providers/bangumi/discussion/parser/common.dart';
import 'package:munin/providers/bangumi/util/utils.dart';
import 'package:munin/shared/utils/collections/common.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:munin/shared/utils/misc/constants.dart';

class ThreadParser {
  /// Matches format like
  /// 2019-5-28 00:52 /
  static RegExp postTimeRegex = RegExp(r'2\d+.+\d');

  /// Matches format like
  /// #1 - 2019-6-1 18:36
  /// #1-2 - 2019-6-1 18:36
  /// #22-24 - 2019-6-1 18:36
  /// #22-24 - 2019-6-1 18:36 / del / edit
  /// This regex is good through year 3000! :P
  static RegExp postTimeAndSequentialNumRegex =
      RegExp(r'\#(\d+)-?(\d+)?.*-\s+(' + postTimeRegex.pattern + r')');

  final BuiltMap<String, MutedUser> mutedUsers;

  /// An [captionTextColor] that'll be added to html.
  ///
  /// It can be used to decide caption text during parsing time instead of
  /// rendering time(during widget build).
  final Color captionTextColor;

  const ThreadParser({
    @required this.mutedUsers,
    @required this.captionTextColor,
  });

  PostTimeAndSeqNum _parsePostTimeAndSeqNum(String raw) {
    Match match = postTimeAndSequentialNumRegex.firstMatch(raw?.trim());
    int mainSequentialNumber = tryParseInt(match.group(1), defaultValue: null);
    int subSequentialNumber = tryParseInt(match.group(2), defaultValue: null);
    DateTime time = parseDateTime(match.group(3));

    return PostTimeAndSeqNum(
      postTimeInMilliSeconds: time.millisecondsSinceEpoch,
      mainSequentialNumber: mainSequentialNumber,
      subSequentialNumber: subSequentialNumber,
    );
  }

  Post _parsePost(Element element, PostType postType) {
    int id = extractFirstIntGroup(element.attributes['id'], defaultValue: null);
    PostTimeAndSeqNum postInfo =
        _parsePostTimeAndSeqNum(element.querySelector('.re_info').text);

    String userNickName = element.querySelector('.inner a.l').text;
    String username = parseHrefId(element.querySelector('.inner a.l'));
    String avatarImageUrl = imageUrlFromBackgroundImage(
        element.querySelector('.avatarNeue'),
        defaultImageSrc: null);
    BangumiImage avatar;
    if (avatarImageUrl != null) {
      avatar = BangumiImage.fromImageUrl(
          avatarImageUrl, ImageSize.Unknown, ImageType.UserAvatar);
    }

    BangumiUserBasic user = BangumiUserBasic((b) => b
      ..nickname = userNickName
      ..username = username
      ..avatar.replace(avatar));

    String contentHtmlSelector;
    switch (postType) {
      case PostType.InitialGroupPost:
      case PostType.InitialSubjectPost:
        contentHtmlSelector = '.topic_content';
        break;
      case PostType.InitialBlogPost:
        contentHtmlSelector = '#entry_content';
        break;
      case PostType.SubPostReply:
        contentHtmlSelector = '.cmt_sub_content';
        break;
      case PostType.MainPostReply:
      default:
        assert(postType == PostType.MainPostReply);
        contentHtmlSelector = '.reply_content>.message';
        break;
    }

    String contentHtml = element.querySelector(contentHtmlSelector).outerHtml;

    switch (postType) {
      case PostType.InitialGroupPost:
      case PostType.InitialSubjectPost:
      case PostType.InitialBlogPost:
        return OriginalPost((b) => b
          ..contentHtml = contentHtml
          ..author.replace(user)
          ..id = id
          ..mainSequentialNumber = postInfo.mainSequentialNumber
          ..postTimeInMilliSeconds = postInfo.postTimeInMilliSeconds);
      case PostType.SubPostReply:
        return SubPostReply((b) => b
          ..contentHtml = contentHtml
          ..author.replace(user)
          ..id = id
          ..mainSequentialNumber = postInfo.mainSequentialNumber
          ..subSequentialNumber = postInfo.subSequentialNumber
          ..postTimeInMilliSeconds = postInfo.postTimeInMilliSeconds);
      case PostType.MainPostReply:
      default:
        assert(postType == PostType.MainPostReply);
        return MainPostReply((b) => b
          ..contentHtml = contentHtml
          ..author.replace(user)
          ..id = id
          ..mainSequentialNumber = postInfo.mainSequentialNumber
          ..postTimeInMilliSeconds = postInfo.postTimeInMilliSeconds
          ..subReplies.replace(BuiltList<Post>.of(_parseSubReplies(element))));
    }
  }

  List<Post> _parseSubReplies(Element replyElement) {
    List<Post> replies = [];

    List<Element> elements = replyElement.querySelectorAll('.sub_reply_bg');
    for (var element in elements) {
      Post post = _parsePost(element, PostType.SubPostReply);
      if (!mutedUsers.containsKey(post.author.username)) {
        replies.add(post);
      }
    }

    return replies;
  }

  List<Post> _parseReplies(DocumentFragment document) {
    List<Post> replies = [];

    List<Element> elements = document.querySelectorAll('.row_reply');
    for (var element in elements) {
      Post post = _parsePost(element, PostType.MainPostReply);
      if (!mutedUsers.containsKey(post.author.username)) {
        replies.add(post);
      }
    }

    return replies;
  }

  List<ThreadRelatedEpisode> _parseThreadRelatedEpisodes(Element element) {
    AirStatus parseAirStatus(String rawAirStatusName) {
      switch (rawAirStatusName) {
        case 'Air':
          return AirStatus.Aired;
        case 'Today':
          return AirStatus.OnAir;
        case 'NA':
          return AirStatus.NotAired;
        default:
          return AirStatus.Unknown;
      }
    }

    List<ThreadRelatedEpisode> episodes = [];

    List<Element> episodeElements = element?.querySelectorAll('li');

    for (var episodeElement in episodeElements) {
      String name = episodeElement.querySelector('a')?.text ?? '??';

      int id = tryParseInt(
          parseHrefId(episodeElement.querySelector('a'), digitOnly: true),
          defaultValue: null);

      String rawAirStatus = episodeElement
          .querySelector('.epAirStatus > span')
          ?.className
          ?.trim();
      bool currentEpisode = episodeElement.classes.contains('cur');

      ThreadRelatedEpisode episode = ThreadRelatedEpisode((b) => b
        ..airStatus = parseAirStatus(rawAirStatus)
        ..id = id
        ..currentEpisode = currentEpisode
        ..name = name);

      episodes.add(episode);
    }

    return episodes;
  }

  BlogContent _parseBlogContent(DocumentFragment document) {
    String rawTime = postTimeRegex
        .firstMatch(document.querySelector('.re_info')?.text)
        .group(0);

    DateTime postTime = parseDateTime(rawTime);

    Element userElement = document.querySelector('#pageHeader .avatar.l');

    String userNickName = userElement.text?.trim();
    String username = parseHrefId(userElement);
    String avatarImageUrl = imageSrcOrFallback(userElement.querySelector('img'),
        fallbackImageSrc: bangumiAnonymousUserMediumAvatar);
    BangumiImage avatar;
    if (avatarImageUrl != null) {
      avatar = BangumiImage.fromImageUrl(
          avatarImageUrl, ImageSize.Unknown, ImageType.UserAvatar);
    }

    BangumiUserBasic author = BangumiUserBasic((b) => b
      ..nickname = userNickName
      ..username = username
      ..avatar.replace(avatar));

    List<ParentSubject> subjects = [];

    for (var subjectElement
        in document.querySelectorAll('#related_subject_list > li')) {
      String coverImageUrl =
          imageSrcOrFallback(subjectElement.querySelector('img'));

      int subjectId = tryParseInt(
          parseHrefId(subjectElement.querySelector('a'), digitOnly: true),
          defaultValue: null);

      subjects.add(ParentSubject((b) => b
        ..id = subjectId
        ..name = subjectElement.text.trim()
        ..cover.replace(BangumiImage.fromImageUrl(
            coverImageUrl, ImageSize.Unknown, ImageType.SubjectCover))));
    }

    return BlogContent((b) => b
      ..associatedSubjects.replace(BuiltList<ParentSubject>.of(subjects))
      ..postTimeInMilliSeconds = postTime.millisecondsSinceEpoch
      ..author.replace(author)
      ..html = document.querySelector('#entry_content')?.outerHtml ?? '');
  }

  _updateQuoteTextColor(DocumentFragment document) {
    // mimic bangumi css style
    List<Element> elements = document.querySelectorAll('div.quote');
    for (final element in elements) {
      final colorStyle = 'color: ${toCssRGBAString(captionTextColor)};';

      if (element.attributes['style'] == null) {
        element.attributes['style'] = colorStyle;
      } else {
        // normalizes inline-style by adding a possibly missing semicolon.
        bool endsWithSemicolon =
            element.attributes['style'].trim().endsWith(';');
        if (!endsWithSemicolon) {
          element.attributes['style'] = ';';
        }
        element.attributes['style'] += colorStyle;
      }
    }
  }

  GroupThread processGroupThread(String rawHtml, int threadId) {
    DocumentFragment document = parseFragment(rawHtml);
    _updateQuoteTextColor(document);

    String title = document.querySelector('title')?.text?.trim();

    String groupName =
        document.querySelector('#pageHeader a.avatar')?.text ?? '小组讨论';

    Post initialPost = _parsePost(
        document.querySelector('.postTopic'), PostType.InitialGroupPost);

    List<Post> replies = _parseReplies(document);

    return GroupThread((b) => b
      ..id = threadId
      ..initialPost.replace(initialPost)
      ..mainPostReplies.replace(BuiltList<Post>.of(replies))
      ..groupName = groupName
      ..title = title);
  }

  SubjectTopicThread processSubjectTopicThread(String rawHtml, int threadId) {
    DocumentFragment document = parseFragment(rawHtml);
    _updateQuoteTextColor(document);

    String title = document.querySelector('#header')?.text?.trim() ?? '??';

    var maybeParentSubject = parseParentSubject(document);

    Post initialPost = _parsePost(
        document.querySelector('.postTopic'), PostType.InitialSubjectPost);

    List<Post> replies = _parseReplies(document);

    return SubjectTopicThread((b) => b
      ..id = threadId
      ..originalPost.replace(initialPost)
      ..mainPostReplies.replace(BuiltList<Post>.of(replies))
      ..parentSubject.replace(
          maybeParentSubject.isPresent ? maybeParentSubject.value : null)
      ..title = title);
  }

  EpisodeThread processEpisodeThread(String rawHtml, int threadId) {
    DocumentFragment document = parseFragment(rawHtml);
    _updateQuoteTextColor(document);

    // Uses title class on page if any.
    String title =
        firstOrNullInIterable<Node>(document.querySelector('.title')?.nodes)
            ?.text;

    // If it doesn't exist, use the title html element in head.
    title ??= document.querySelector('title')?.text?.trim();

    String descriptionHtml = document.querySelector('.epDesc')?.outerHtml ?? '';

    List<Post> replies = _parseReplies(document);

    List<ThreadRelatedEpisode> relatedEpisodes =
        _parseThreadRelatedEpisodes(document.querySelector('.sideEpList'));

    var maybeParentSubject = parseParentSubject(document);

    return EpisodeThread((b) => b
      ..id = threadId
      ..title = title
      ..descriptionHtml = descriptionHtml
      ..parentSubject.replace(
          maybeParentSubject.isPresent ? maybeParentSubject.value : null)
      ..relatedEpisodes
          .replace(BuiltList<ThreadRelatedEpisode>.of(relatedEpisodes))
      ..mainPostReplies.replace(BuiltList<Post>.of(replies)));
  }

  BlogThread processBlogThread(String rawHtml, int blogId) {
    DocumentFragment document = parseFragment(rawHtml);
    _updateQuoteTextColor(document);

    String title = document.querySelector('title')?.text?.trim();

    BlogContent blogContent = _parseBlogContent(document);

    List<Post> replies = _parseReplies(document);

    return BlogThread((b) => b
      ..id = blogId
      ..title = title
      ..blogContent.replace(blogContent)
      ..mainPostReplies.replace(BuiltList<Post>.of(replies)));
  }
}

class PostTimeAndSeqNum {
  /// See [Post.mainSequentialNumber]
  final int mainSequentialNumber;

  /// Null for non [SubPostReply]
  final int subSequentialNumber;

  final int postTimeInMilliSeconds;

  const PostTimeAndSeqNum({
    @required this.mainSequentialNumber,
    @required this.postTimeInMilliSeconds,
    @required this.subSequentialNumber,
  });
}
