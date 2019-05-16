import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/BangumiCookieCredentials.dart';
import 'package:oauth2/oauth2.dart';

class SecureStorageService {
  final FlutterSecureStorage secureStorage;

  static const String cookieCredentialsKey = 'bangumiCookieCredentials';
  static const String oauthCredentialsKey = 'bangumiOauthCredentials';

  SecureStorageService({@required this.secureStorage});

  Future<void> persistBangumiOauthCredentials(Credentials credentials) async {
    assert(credentials != null);
    return this
        .secureStorage
        .write(key: oauthCredentialsKey, value: credentials.toJson());
  }

  Future<void> clearBangumiOauthCredentials() async {
    return this.secureStorage.delete(key: oauthCredentialsKey);
  }

  Future<void> persistBangumiCookieCredentials(
      BangumiCookieCredentials credentials) async {
    assert(credentials != null);
    return this
        .secureStorage
        .write(key: cookieCredentialsKey, value: credentials.toJson());
  }

  Future<void> clearBangumiCookieCredentials() async {
    return this.secureStorage.delete(key: cookieCredentialsKey);
  }
}
