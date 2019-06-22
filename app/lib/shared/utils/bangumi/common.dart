import 'package:munin/models/bangumi/common/ChineseNameOwner.dart';
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

String preferredNameFromChineseNameOwner(ChineseNameOwner chineseNameOwner,
    PreferredSubjectInfoLanguage language,) {
  return preferredName(
      chineseNameOwner.name, chineseNameOwner.chineseName, language);
}

String preferredNameFromSubjectBase(SubjectBase subject,
    PreferredSubjectInfoLanguage language,) {
  return preferredName(subject.name, subject.chineseName, language);
}

String preferredName(String name,
    String chineseName,
    PreferredSubjectInfoLanguage language,) {
  switch (language) {
    case PreferredSubjectInfoLanguage.Chinese:

    /// Ensure there is at least one title
      return isNotEmpty(chineseName) ? chineseName : name;
    case PreferredSubjectInfoLanguage.Original:
    default:
      return name;
  }
}

///Secondary title might be absent so `Optional` is returned
Optional<String> secondaryNameFromSubjectBase(SubjectBase subject,
    PreferredSubjectInfoLanguage language,) {
  return secondaryName(subject.name, subject.chineseName, language);
}

Optional<String> secondaryNameFromChineseNameOwner(
    ChineseNameOwner chineseNameOwner,
    PreferredSubjectInfoLanguage language,) {
  return secondaryName(
      chineseNameOwner.name, chineseNameOwner.chineseName, language);
}

///Secondary title might be absent so `Optional` is returned
Optional<String> secondaryName(String name,
    String chineseName,
    PreferredSubjectInfoLanguage language,) {
  switch (language) {
    case PreferredSubjectInfoLanguage.Original:
      return isNotEmpty(chineseName)
          ? Optional.of(chineseName)
          : Optional.absent();
    case PreferredSubjectInfoLanguage.Chinese:
    default:

    /// If [chineseName] is not null or empty, name can be used as the secondary language
    /// Otherwise, name has been used a fallback for [chineseName], so secondary language should return null
      return isNotEmpty(chineseName) ? Optional.of(name) : Optional.absent();
  }
}
