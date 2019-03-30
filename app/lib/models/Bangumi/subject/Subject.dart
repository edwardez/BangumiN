import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/Bangumi/common/Images.dart';
import 'package:munin/models/Bangumi/mono/Character.dart';
import 'package:munin/models/Bangumi/subject/InfoBox/InfoBoxItem.dart';
import 'package:munin/models/Bangumi/subject/InfoBox/InfoBoxRow.dart';
import 'package:munin/models/Bangumi/subject/Rating.dart';
import 'package:munin/models/Bangumi/subject/RelatedSubject.dart';
import 'package:munin/models/Bangumi/subject/comment/SubjectComment.dart';
import 'package:munin/models/Bangumi/subject/common/SubjectType.dart';
import 'package:munin/models/Bangumi/subject/common/SujectBase.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'Subject.g.dart';

abstract class Subject implements SubjectBase, Built<Subject, SubjectBuilder> {
  SubjectType get type;

  /// for anime, is it a TV series or a movie
  /// for book, is it a comic or novel?..etc
  /// this info is not always available and it's currently a string instead of
  /// a enum since we are parsing html and there are too many types
  /// Also note this subType might be slightly different from [RelatedSubject.subjectSubTypeName]
  /// i.e. if [Subject.subTypeName] is 小说系列, then
  /// [RelatedSubject.subjectSubTypeName] is 系列 for some subjects
  @nullable
  String get subTypeName;

  @BuiltValueField(wireName: 'summary')
  String get summary;

  @BuiltValueField(wireName: 'rating')
  Rating get rating;

  @nullable
  @BuiltValueField(wireName: 'rank')
  int get rank;

  @BuiltValueField(wireName: 'images')
  Images get images;

  @nullable
  @BuiltValueField(wireName: 'crt')
  BuiltList<Character> get characters;

  /// key is [RelatedSubject.subjectSubType], value is list of related subjects
  @nullable
  BuiltListMultimap<String, RelatedSubject> get relatedSubjects;

  @nullable
  /// a short preview list of comments that are on subject main page
  BuiltList<SubjectComment> get commentsPreview;

  /// key is row name, value is InfoBoxRow
  /// we need to use this data structure because Bangumi might use multiple rows
  /// to display info that's under the same rowName, and these need to be
  /// merged into one row, like:
  /// <li><span class="tip">平台: </span>PS4、PS3</li>
  /// <li><span class="tip" style="visibility:hidden;">平台: </span>PC</li>
  /// The default behaviour of ListMultimap is keys are retrieved in the same
  /// order as they stored, so key sequence are guaranteed(which is important to us)
  /// value has to be [InfoBoxRow] (which contains a list of [InfoBoxItem]) instead of
  /// a flatten list of [InfoBoxItem], reason is in each InfoBoxRow, Bangumi separates
  /// items using a `、`, so we need to add a a `、` between each [InfoBoxRow] as well
  /// i.e. in the above example, there is a `、` between PS4 and PS3, we want to
  /// add a `、` between PS3 and PC as well
  @nullable
  BuiltListMultimap<String, InfoBoxItem> get infoBoxRows;

  @memoized
  String get infoBoxRowsPlainText {
    String plainText = '';

    infoBoxRows.forEachKey((a, b) {
      plainText += '$a: ';

      b.forEach((InfoBoxItem infoBoxItem) {
        plainText += infoBoxItem.name;
      });
      plainText += '\n';
    });

    return plainText;
  }

  /// A list of curated info box rows
  /// These rows will present to user on subject main page
  /// while rows in [infoBoxRows] will only be shown if user taps 'lean more'
  /// [curatedInfoBoxRows] should be a subset of [infoBoxRows] that only contains
  /// most important info of a subject
  @nullable
  BuiltListMultimap<String, InfoBoxItem> get curatedInfoBoxRows;

  /// a runtime generated subject url
  /// see also [pageUrl]
  @memoized
  String get pageUrlFromCalculation {
    return 'https://${Application.environmentValue
        .bangumiMainHost}/subject/$id';
  }

  Subject._();

  factory Subject([updates(SubjectBuilder b)]) = _$Subject;

  String toJson() {
    return json.encode(serializers.serializeWith(Subject.serializer, this));
  }

  static Subject fromJson(String jsonString) {
    return serializers.deserializeWith(
        Subject.serializer, json.decode(jsonString));
  }


  static Serializer<Subject> get serializer => _$subjectSerializer;

  /// below fields are in bangumi rest api but currently not in use by Munin
  ///   @BuiltValueField(wireName: 'air_date')
  ///  String get airDate;
  ///  @BuiltValueField(wireName: 'air_weekday')
  ///  int get airWeekday;
  ///    @BuiltValueField(wireName: 'type')
  ///  SubjectType get type;
  ///    @BuiltValueField(wireName: 'topic')
  ///  BuiltList<Topic> get topic;
  ///  @BuiltValueField(wireName: 'blog')
  ///  BuiltList<Blog> get blog;
  ///    @nullable
  ///  @BuiltValueField(wireName: 'eps')
  ///  BuiltList<Episode> get episodes;
  ///
  ///  @nullable
  ///  @BuiltValueField(wireName: 'eps_count')
  ///  int get episodesCount;
  ///
  ///   @BuiltValueField(wireName: 'collection')
  ///  SubjectCollection get collection;
}
