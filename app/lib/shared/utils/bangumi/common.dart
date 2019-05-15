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
