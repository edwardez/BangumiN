import 'package:built_value/built_value.dart';

part 'SujectBase.g.dart';

@BuiltValue(instantiable: false)
abstract class SubjectBase {
  @nullable
  @BuiltValueField(wireName: 'id')
  int get id;

  @nullable
  @BuiltValueField(wireName: 'url')
  String get pageUrl;

  String get name;

  @nullable
  @BuiltValueField(wireName: 'name_cn')
  String get nameCn;

  SubjectBase rebuild(void updates(SubjectBaseBuilder b));

  SubjectBaseBuilder toBuilder();
}
