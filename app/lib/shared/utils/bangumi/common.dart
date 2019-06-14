import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/models/bangumi/subject/common/SujectBase.dart';
import 'package:quiver/core.dart';
import 'package:quiver/strings.dart';

bool isValidAirDate(String airDate) {
  return isNotEmpty(airDate) && !airDate.startsWith('0000');
}

bool isValidDoubleScore(double score) {
  if (score == null || score <= 0.0 || score > 10.0) {
    return false;
  }

  return true;
}

bool isValidIntScore(int score) {
  return isValidDoubleScore(score?.toDouble());
}

String preferredNameFromSubjectBase(SubjectBase subject,
    PreferredSubjectInfoLanguage language) {
  return preferredName(subject.name, subject.nameCn, language);
}

String preferredName(String name, String nameCn,
    PreferredSubjectInfoLanguage language) {
  switch (language) {
    case PreferredSubjectInfoLanguage.Chinese:

    /// Ensure there is at least one title
      return isNotEmpty(nameCn) ? nameCn : name;
    case PreferredSubjectInfoLanguage.Original:
    default:
      return name;
  }
}

///Secondary title might be absent so `Optional` is returned
Optional<String> secondaryNameFromSubjectBase(SubjectBase subject,
    PreferredSubjectInfoLanguage language) {
  return secondaryName(subject.name, subject.nameCn, language);
}

///Secondary title might be absent so `Optional` is returned
Optional<String> secondaryName(String name, String nameCn,
    PreferredSubjectInfoLanguage language) {
  switch (language) {
    case PreferredSubjectInfoLanguage.Original:
      return isNotEmpty(nameCn) ? Optional.of(nameCn) : Optional.absent();
    case PreferredSubjectInfoLanguage.Chinese:
    default:

    /// If nameCn is not null or empty, name can be used as the secondary language
    /// Otherwise, name has been used a fallback for nameCn, so secondary language should return null
      return isNotEmpty(nameCn) ? Optional.of(name) : Optional.absent();
  }
}
