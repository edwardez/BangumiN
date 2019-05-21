import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'Mono.g.dart';

class Mono extends EnumClass {
  static const Mono Character = _$Character;
  static const Mono Person = _$Person;

  const Mono._(String name) : super(name);

  static BuiltSet<Mono> get values => _$values;

  static Mono valueOf(String name) => _$valueOf(name);

  static Serializer<Mono> get serializer => _$monoSerializer;
}
