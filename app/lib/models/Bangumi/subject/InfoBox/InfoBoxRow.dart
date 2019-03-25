import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/Bangumi/subject/InfoBox/InfoBoxItem.dart';
import 'package:munin/models/Bangumi/subject/Subject.dart';
import 'package:munin/models/Bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/models/Bangumi/timeline/common/HyperBangumiItem.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'InfoBoxRow.g.dart';

/// info about all staff under a job, or other infobox rows
/// Multiple staff might work on the same job
/// Bangumi Rest API returns this info
/// Bangumi web parser returns this info
/// see [JobsPerStaff], Bangumi Rest API returns that info
abstract class InfoBoxRow implements Built<InfoBoxRow, InfoBoxRowBuilder> {
  static String _rowItemSeparator = '、';

  static InfoBoxItem separator = InfoBoxItem((b) =>
  b
    ..name = _rowItemSeparator
    ..type = BangumiContent.PlainText);

  /// i.e. nameCn, director, airDate, Music, Title Studio
  String get rowName;

  /// is this row a curated(aka. important) row
  /// see [curatedInfoBoxRows] in [Subject]
  bool get isCuratedRow;

  /// Can be: all staff under a job, name value for a name row
  /// i.e. for `监督: 少女A、少女B`, infoItemName is `监督`,
  /// value is `[少女，少女B]` (without considering it's actually a  [HyperBangumiItem] instance)
  BuiltList<InfoBoxItem> get rowItems;

  String toJson() {
    return json.encode(serializers.serializeWith(InfoBoxRow.serializer, this));
  }

  @memoized
  String concatRowItems() {
    return rowItems.fold(
        '', (String currentStr, InfoBoxItem item) => currentStr + item.name);
  }

  static InfoBoxRow fromJson(String jsonString) {
    return serializers.deserializeWith(
        InfoBoxRow.serializer, json.decode(jsonString));
  }

  static Serializer<InfoBoxRow> get serializer => _$infoBoxRowSerializer;

  InfoBoxRow._();

  factory InfoBoxRow([updates(InfoBoxRowBuilder b)]) = _$InfoBoxRow;
}
