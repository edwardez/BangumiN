import 'package:quiver/strings.dart';

bool isValidAirDate(String airDate) {
  return isNotEmpty(airDate) && !airDate.startsWith('0000');
}
