import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/Images.dart';
import 'package:munin/models/bangumi/mono/MonoBase.dart';
import 'package:munin/models/bangumi/subject/InfoBox/InfoBoxRow.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'JobsPerStaff.g.dart';

/// info about a staff per person
/// A person might have different jobs
/// Bangumi Rest API returns this info
/// see [InfoBoxRow], Bangumi web parser returns that info
@BuiltValue(wireName: 'staff')
abstract class JobsPerStaff
    implements MonoBase, Built<JobsPerStaff, JobsPerStaffBuilder> {
  JobsPerStaff._();

  factory JobsPerStaff([updates(JobsPerStaffBuilder b)]) = _$JobsPerStaff;

  @BuiltValueField(wireName: 'name_cn')
  @nullable
  String get nameCn;

  @BuiltValueField(wireName: 'role_name')
  String get roleName;

  Images get images;

  @nullable
  @BuiltValueField(wireName: 'comment')
  int get commentCount;

  @nullable
  @BuiltValueField(wireName: 'collects')
  int get collectionCounts;

//  @BuiltValueField(wireName: 'info')
//  Info get info;

  @BuiltValueField(wireName: 'jobs')
  BuiltList<String> get jobs;

  String toJson() {
    return json
        .encode(serializers.serializeWith(JobsPerStaff.serializer, this));
  }

  static JobsPerStaff fromJson(String jsonString) {
    return serializers.deserializeWith(
        JobsPerStaff.serializer, json.decode(jsonString));
  }

  static Serializer<JobsPerStaff> get serializer => _$jobsPerStaffSerializer;
}
