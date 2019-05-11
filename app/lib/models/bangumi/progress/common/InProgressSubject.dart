import 'package:built_value/built_value.dart';
import 'package:munin/models/bangumi/progress/common/InProgressSubjectInfo.dart';

part 'InProgressSubject.g.dart';

@BuiltValue(instantiable: false)
abstract class InProgressSubject {
  /// The last time user touched this subject
  @BuiltValueField(wireName: 'lasttouch')
  int get userUpdatedAt;

  @BuiltValueField(wireName: 'subject')
  InProgressSubjectInfo get subject;

  InProgressSubject rebuild(void updates(InProgressSubjectBuilder b));

  InProgressSubjectBuilder toBuilder();
}
