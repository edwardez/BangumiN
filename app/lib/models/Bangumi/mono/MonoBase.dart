import 'package:built_value/built_value.dart';

part 'MonoBase.g.dart';

@BuiltValue(instantiable: false)
abstract class MonoBase {
  int get id;

  @BuiltValueField(wireName: 'url')
  String get pageUrl;

  String get name;

  MonoBase rebuild(void updates(MonoBaseBuilder b));

  MonoBaseBuilder toBuilder();
}
