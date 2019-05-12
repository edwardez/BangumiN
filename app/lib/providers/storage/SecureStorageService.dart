import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/BangumiCookieCredentials.dart';
import 'package:oauth2/oauth2.dart';

class SecureStorageService {
  final FlutterSecureStorage secureStorage;

  SecureStorageService({@required this.secureStorage});

  Future<void> persistBangumiOauthCredentials(Credentials credentials) {
    assert(credentials != null);
    return this
        .secureStorage
        .write(key: 'bangumiOauthCredentials', value: credentials.toJson());
  }

  Future<void> clearBangumiOauthCredentials() async {
    return this.secureStorage.delete(key: 'bangumiOauthCredentials');
  }

  Future<void> persistBangumiCookieCredentials(
      BangumiCookieCredentials credentials) {
    assert(credentials != null);
    return this
        .secureStorage
        .write(key: 'bangumiCookieCredentials', value: credentials.toJson());
  }

  Future<void> clearBangumiCookieCredentials() {
    return this.secureStorage.delete(key: 'bangumiCookieCredentials');
  }
}
