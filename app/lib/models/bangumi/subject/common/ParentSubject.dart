import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/subject/common/SujectBase.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'ParentSubject.g.dart';

/// A subject as seen on subject page.
/// It's called a 'parent' subject because it's typically shown on subject episode,
/// subject thread pages where these items are linked to a parent subject.
abstract class ParentSubject
    implements SubjectBase, Built<ParentSubject, ParentSubjectBuilder> {
  BangumiImage get cover;

  ParentSubject._();

  factory ParentSubject([void Function(ParentSubjectBuilder) updates]) =
      _$ParentSubject;

  String toJson() {
    return json
        .encode(serializers.serializeWith(ParentSubject.serializer, this));
  }

  static ParentSubject fromJson(String jsonString) {
    return serializers.deserializeWith(
        ParentSubject.serializer, json.decode(jsonString));
  }

  static Serializer<ParentSubject> get serializer => _$parentSubjectSerializer;
}
