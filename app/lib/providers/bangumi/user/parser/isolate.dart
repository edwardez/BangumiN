import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/providers/bangumi/user/parser/UserParser.dart';

UserProfile processUserProfile(String rawHtml) {
  return UserParser().processUserProfile(rawHtml);
}
