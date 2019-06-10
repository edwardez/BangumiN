import 'package:html/dom.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/subject/common/ParentSubject.dart';
import 'package:munin/providers/bangumi/util/utils.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:quiver/core.dart';

Optional<ParentSubject> parseParentSubject(DocumentFragment document) {
  Element subjectElement =
      document.querySelector('#subject_inner_info > a.avatar');

  int id = tryParseInt(parseHrefId(subjectElement), defaultValue: null);

  String name = subjectElement?.text ?? '??';
  String nameCn =
      (document.querySelector('.nameSingle>a')?.attributes ?? {})['title'] ??
          null;

  String coverImageUrl = imageSrcOrFallback(
      subjectElement?.querySelector('img'));

  if (id == null) {
    return Optional.absent();
  }

  ParentSubject subject = ParentSubject((b) => b
    ..id = id
    ..name = name
    ..nameCn = nameCn
    ..cover.replace(BangumiImage.fromImageUrl(
        coverImageUrl, ImageSize.Unknown, ImageType.SubjectCover)));

  return Optional.of(subject);
}
