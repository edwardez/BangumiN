import 'dart:async';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/Bangumi/BangumiCookieCredentials.dart';

// A client for Bangumi thst sends requests with cookie and handles relevant persistence
class BangumiCookieClient {
  BangumiCookieCredentials bangumiCookieCredential;
  FlutterSecureStorage secureStorage;
  Dio dio;

  BangumiCookieClient({
    @required BangumiCookieCredentials bangumiCookieCredential,
    @required FlutterSecureStorage secureStorage,
    @required Dio dio,
  }) {
    this.bangumiCookieCredential = bangumiCookieCredential;
    this.secureStorage = secureStorage;
    this.dio = dio;
  }

  bool readyToUse() {
    return bangumiCookieCredential != null &&
        bangumiCookieCredential.userAgent != null &&
        bangumiCookieCredential.authCookie != null;
  }

  /// update in-memory bangumi auth credentials info
  void updateBangumiAuthInfo({String authCookie, String userAgent}) {
    assert(authCookie != null);
    assert(userAgent != null);

    /// write to keystore/keychain
    bangumiCookieCredential = BangumiCookieCredentials((b) => {
    b
      ..authCookie = authCookie
      ..userAgent = userAgent
    });

    updateDioHeaders(authCookie: authCookie, userAgent: userAgent);
  }

  void updateDioHeaders({String authCookie, String userAgent}) {
    List<Cookie> cookies = [Cookie("chii_auth", authCookie)];
    var cookieJar = getIt.get<CookieJar>();

    cookieJar.saveFromResponse(
        Uri.parse("https://${Application.environmentValue.bangumiMainHost}"),
        cookies);
    Map<String, dynamic> headers = dio.options.headers;

    headers[HttpHeaders.userAgentHeader] = userAgent;
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
