import 'package:html/dom.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/common/Images.dart';
import 'package:munin/models/bangumi/subject/comment/ReviewMetaInfo.dart';
import 'package:munin/models/bangumi/subject/comment/SubjectReview.dart';
import 'package:munin/providers/bangumi/util/utils.dart';
import 'package:munin/shared/utils/common.dart';

enum ReviewElement {
  ///'谁看这部动画? '  on the bottom left side of bangumi subject page, it displays users
  /// who recently collects this page
  /// collection status  must not be null for [RecentCollection]
  CollectionPreview,

  ///Full collection status for this subjects
  /// i.e. https://bgm.tv/subject/1/wishes
  /// it displays collection status, comment, score
  /// who recently collects this page
  /// collection status  must not be null for [RecentCollection]
  CollectionFull,

  /// '吐槽箱' on the bottom right side of bangumi subject page, , it displays users
  /// who recently comments for this subject
  /// comment must not be null for [CommentBox]
  CommentBox
}

SubjectReview parseSubjectReview(Element element, ReviewElement elementType,
    {String defaultActionName = '评价道'}) {
  Element avatarElement = element.querySelector('a.avatar');
  String username = parseHrefId(avatarElement);
  String userAvatarSmall = imageUrlFromBackgroundImage(avatarElement);
  Images images = Images.fromImageUrl(
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
    ..userAvatars.replace(images));

  SubjectReview subjectReview = SubjectReview((b) => b
    ..content = commentContent
    ..metaInfo.replace(metaInfo));

  return subjectReview;
}
