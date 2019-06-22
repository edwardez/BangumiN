import 'package:html/dom.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/models/bangumi/subject/review/ReviewMetaInfo.dart';
import 'package:munin/models/bangumi/subject/review/SubjectReview.dart';
import 'package:munin/providers/bangumi/util/utils.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:munin/shared/utils/misc/constants.dart';

SubjectType parseSubjectType(DocumentFragment document) {
  return SubjectType.guessTypeByChineseName(
      document.querySelector('#navMenuNeue .focus')?.text?.trim());
}

/// Different types of elements that bangumi uses to display a review.
///
enum ReviewElement {
  /// '谁看这部动画? '  on the bottom left side of bangumi subject page, it
  /// displays users who recently collects this page.
  ///
  /// Collection status must not be null for [CollectionPreview],
  /// but whether user has commented on the subject is unknown.
  CollectionPreview,

  /// Full review for this subjects
  /// i.e. https://bgm.tv/subject/1/wishes
  /// It displays collection status, comment, score who recently collects this subject.
  ///
  /// Collection status must not be null for [CollectionFull], user may or may not
  /// leave a comment if it's shown under [CollectionFull].
  CollectionFull,

  /// '吐槽箱' on the bottom right side of bangumi subject page, , it displays users
  /// who recently comments for this subject
  ///
  /// Comment must not be null for [CommentBox], but collection status is unknown.
  CommentBox,
}

/// Parses a subject review for [ReviewElement.CollectionPreview] or
/// [ReviewElement.CommentBox].
///
/// For [ReviewElement.CollectionFull], use [parseReviewOnCollectionPage].
SubjectReview parseSubjectReviewOnNonCollectionPage(
  Element element,
  ReviewElement elementType, {
  String defaultActionName = '评价道',
}) {
  assert(elementType != ReviewElement.CollectionFull);

  Element avatarElement = element.querySelector('a.avatar');
  String username = parseHrefId(avatarElement);
  String userAvatarSmall = imageUrlFromBackgroundImage(avatarElement);
  BangumiImage avatar = BangumiImage.fromImageUrl(
      userAvatarSmall, ImageSize.Unknown, ImageType.UserAvatar);
  String updatedAt = element.querySelector('.grey')?.text;

  DateTime absoluteTime = parseBangumiTime(updatedAt);

  String commentContent;
  if (elementType == ReviewElement.CommentBox) {
    commentContent = element.querySelector('p')?.text ?? '';
  }

  String nickName;
  double score;
  String actionName;
  CollectionStatus collectionStatus;

  if (elementType == ReviewElement.CollectionPreview) {
    nickName = element.querySelector('.innerWithAvatar > .avatar')?.text ?? '';
    score = parseSubjectScore(element);

    String rawActionName =
        element.querySelector('.innerWithAvatar > .grey')?.text ?? '';
    actionName = lastNChars(rawActionName, 2);
    collectionStatus =
        CollectionStatus.guessCollectionStatusByChineseName(actionName);
  } else if (elementType == ReviewElement.CommentBox) {
    nickName = element.querySelector('.text > a')?.text ?? '';
    score = parseSubjectScore(element);
    actionName = score == null ? defaultActionName : '';
    collectionStatus = CollectionStatus.Unknown;
  } else {
    throw UnimplementedError('Not implemented yet');
  }

  ReviewMetaInfo metaInfo = ReviewMetaInfo((b) => b
    ..updatedAt = absoluteTime?.millisecondsSinceEpoch
    ..nickName = nickName
    ..actionName = actionName
    ..collectionStatus = collectionStatus
    ..score = score
    ..username = username
    ..avatar.replace(avatar));

  SubjectReview subjectReview = SubjectReview((b) => b
    ..content = commentContent
    ..metaInfo.replace(metaInfo));

  return subjectReview;
}

SubjectReview parseReviewOnCollectionPage(
  Element element, {
  @required SubjectType subjectType,
  @required CollectionStatus collectionStatus,
}) {
  final avatarElement = element.querySelector('img.avatar');
  String userAvatarImageUrl = imageSrcOrFallback(
    avatarElement,
    fallbackImageSrc: bangumiAnonymousUserMediumAvatar,
  );
  BangumiImage avatar = BangumiImage.fromImageUrl(
      userAvatarImageUrl, ImageSize.Unknown, ImageType.UserAvatar);
  final updatedAtElement = element.querySelector('p.info');

  final absoluteTime = parseBangumiTime(updatedAtElement?.text);

  String commentContent;

  Node commentTextNode = nextNodeSibling(updatedAtElement);
  if (commentTextNode?.nodeType == Node.TEXT_NODE) {
    commentContent = commentTextNode.text.trim();
  }

  final score = parseSubjectScore(element);
  final actionName = CollectionStatus.chineseNameWithSubjectType(
      collectionStatus, subjectType);
  final usernameElement = element.querySelector('a.avatar[href*="/user/"]');
  final username = parseHrefId(usernameElement);
  final nickName = usernameElement.text.trim();

  ReviewMetaInfo metaInfo = ReviewMetaInfo((b) => b
    ..updatedAt = absoluteTime?.millisecondsSinceEpoch
    ..nickName = nickName
    ..actionName = actionName
    ..collectionStatus = collectionStatus
    ..score = score
    ..username = username
    ..avatar.replace(avatar));

  SubjectReview subjectReview = SubjectReview((b) => b
    ..content = commentContent
    ..metaInfo.replace(metaInfo));

  return subjectReview;
}
