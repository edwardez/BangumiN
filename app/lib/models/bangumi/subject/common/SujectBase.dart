import 'package:built_value/built_value.dart';

part 'SujectBase.g.dart';

@BuiltValue(instantiable: false)
abstract class SubjectBase {
  @nullable
  @BuiltValueField(wireName: 'id')
  int get id;

  /// This value is from Bangumi API, it might be null if data is obtained by
  /// html parser. And even api might not return this value.
  @nullable
  @BuiltValueField(wireName: 'url')
  String get pageUrlFromApi;

  String get name;

  @nullable
  @BuiltValueField(wireName: 'name_cn')
  String get nameCn;

  SubjectBase rebuild(void updates(SubjectBaseBuilder b));

  SubjectBaseBuilder toBuilder();
}
