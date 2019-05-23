import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'PreferredSubjectInfoLanguage.g.dart';

const defaultSubjectInfoLanguage = PreferredSubjectInfoLanguage.Original;

class PreferredSubjectInfoLanguage extends EnumClass {
  static const PreferredSubjectInfoLanguage Original = _$Original;

  static const PreferredSubjectInfoLanguage Chinese = _$Chinese;

  String get chineseName {
    switch (this) {
      case PreferredSubjectInfoLanguage.Original:
        return '原文';
      case PreferredSubjectInfoLanguage.Chinese:
        return '中文';
      default:
        assert(false, '$this doesn\'t have a valid Chinese name.');
        return '-';
    }
  }

  const PreferredSubjectInfoLanguage._(String name) : super(name);

  static BuiltSet<PreferredSubjectInfoLanguage> get values => _$values;

  static PreferredSubjectInfoLanguage valueOf(String name) => _$valueOf(name);

  static Serializer<PreferredSubjectInfoLanguage> get serializer =>
      _$preferredSubjectInfoLanguageSerializer;

  static PreferredSubjectInfoLanguage fromWiredName(String wiredName) {
    return serializers.deserializeWith(
        PreferredSubjectInfoLanguage.serializer, wiredName);
  }
}
