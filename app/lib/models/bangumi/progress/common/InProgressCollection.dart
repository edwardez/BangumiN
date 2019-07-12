import 'package:built_value/built_value.dart';
import 'package:munin/models/bangumi/progress/common/InProgressSubjectInfo.dart';

part 'InProgressCollection.g.dart';

@BuiltValue(instantiable: false)
abstract class InProgressCollection {
  /// The last time user touched this subject
  @BuiltValueField(wireName: 'lasttouch')
  int get userUpdatedAt;

  @BuiltValueField(wireName: 'subject')
  InProgressSubjectInfo get subject;

  InProgressCollection rebuild(void updates(InProgressCollectionBuilder b));

  InProgressCollectionBuilder toBuilder();
}
