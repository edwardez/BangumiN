import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'SubjectStatus.g.dart';

/// Status of a subject on bangumi.
class SubjectStatus extends EnumClass {
  static const SubjectStatus Unknown = _$Unknown;

  static const SubjectStatus Normal = _$Normal;

  /// Subject is locked. User is not allowed to modify collection status
  /// for this subject.
  static const SubjectStatus LockedForCollection = _$LockedForCollection;

  const SubjectStatus._(String name) : super(name);

  static BuiltSet<SubjectStatus> get values => _$values;

  static SubjectStatus valueOf(String name) => _$valueOf(name);

  static Serializer<SubjectStatus> get serializer => _$subjectStatusSerializer;
}
