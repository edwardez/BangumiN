import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/Bangumi/BangumiCookieCredentials.dart';

// A client for Bangumi thst sends requests with cookie and handles relevant persistence
class BangumiCookieClient {
  BangumiCookieCredentials bangumiCookieCredential;
  FlutterSecureStorage secureStorage;

  BangumiCookieClient(
      {@required String serializedBangumiCookieCredentials,
      @required secureStorage}) {
    if (serializedBangumiCookieCredentials != null) {
      bangumiCookieCredential =
          BangumiCookieCredentials.fromJson(serializedBangumiCookieCredentials);
    }
    this.secureStorage = secureStorage;
  }

  bool readyToUse() {
    return bangumiCookieCredential != null &&
        bangumiCookieCredential.userAgent != null &&
        bangumiCookieCredential.authCookie != null;
  }

  void updateBangumiAuthInfo({String authCookie, String userAgent}) {
    /// write to keystore/keychain
    bangumiCookieCredential = BangumiCookieCredentials((b) => {
          b
            ..authCookie = authCookie
            ..userAgent = userAgent
        });
  }

  Future<void> persistCredentials() {
    return this.secureStorage.write(
        key: 'bangumiCookieCredentials',
        value: bangumiCookieCredential.toJson());
  }

  Future<void> clearCredentials() {
    return this.secureStorage.delete(key: 'bangumiCookieCredentials');
  }
}
