import 'dart:async';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:meta/meta.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/BangumiCookieCredentials.dart';
import 'package:munin/providers/storage/SecureStorageService.dart';
import 'package:munin/shared/exceptions/exceptions.dart';
import 'package:quiver/strings.dart';

// A client for Bangumi thst sends requests with cookie and handles relevant persistence
class BangumiCookieService {
  BangumiCookieCredentials bangumiCookieCredential;
  SecureStorageService secureStorageService;
  Dio dio;

  BangumiCookieService({
    @required BangumiCookieCredentials bangumiCookieCredential,
    @required SecureStorageService secureStorageService,
    @required Dio dio,
  }) {
    this.bangumiCookieCredential = bangumiCookieCredential;
    this.secureStorageService = secureStorageService;
    this.dio = dio;
  }

  bool readyToUse() {
    return bangumiCookieCredential != null &&
        bangumiCookieCredential.userAgent != null &&
        bangumiCookieCredential.authCookie != null;
  }

  /// update in-memory bangumi auth credentials info
  void updateBangumiAuthInfo(
      {String authCookie, String sessionCookie, String userAgent}) {
    assert(authCookie != null);
    assert(userAgent != null);
    assert(sessionCookie != null);

    /// write to keystore/keychain
    bangumiCookieCredential = BangumiCookieCredentials((b) => {
    b
      ..authCookie = authCookie
      ..sessionCookie = sessionCookie
      ..userAgent = userAgent
    });

    updateDioHeaders(authCookie: authCookie,
        sessionCookie: sessionCookie,
        userAgent: userAgent);
  }

  void updateDioHeaders(
      {String authCookie, String sessionCookie, String userAgent}) {
    final String bangumiMainHost = Application.environmentValue.bangumiMainHost;
    final String bangumiNonCdnHost = Application.environmentValue
        .bangumiNonCdnHost;
    List<Cookie> cookies = [
      Cookie("chii_auth", authCookie),
      Cookie("chii_sid", sessionCookie)
    ];

    var cookieJar = getIt.get<CookieJar>();

    /// Save authenticated cookie for both version of bangumi
    cookieJar.saveFromResponse(
        Uri.parse("https://$bangumiMainHost"),
        cookies);
    cookieJar.saveFromResponse(
        Uri.parse("https://$bangumiNonCdnHost"),
        cookies);
    dio.options.headers[HttpHeaders.userAgentHeader] = userAgent;
  }

  Future<void> clearCredentials() {
    return secureStorageService.clearBangumiCookieCredentials();
  }

  Future<void> persistCredentials() {
    return secureStorageService.persistBangumiCookieCredentials(
        bangumiCookieCredential);
  }

  Future<String> getXsrfToken() async {
    /// TODO: find a better place where xsrf token is stored
    Response response = await dio.get('/settings/password');
    if (response.statusCode == 200) {
      DocumentFragment document = parseFragment(response.data);
      Element tokenElement = document.querySelector('input[name=formhash]');
      if (tokenElement != null &&
          isNotEmpty(tokenElement.attributes['value'])) {
        return tokenElement.attributes['value'];
      }
    }

    throw BangumiResponseIncomprehensibleException();
  }
}
