import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationCredentials {
  static final AuthenticationCredentials _singleton =
      AuthenticationCredentials._internal();

  static final oauthClientIdentifier = '';

  static SharedPreferences data;

  factory AuthenticationCredentials() {
    return _singleton;
  }

  AuthenticationCredentials._internal();
}
