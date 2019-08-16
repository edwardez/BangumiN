import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_retry/dio_retry.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:mockito/mockito.dart';
import 'package:munin/models/bangumi/BangumiCookieCredentials.dart';
import 'package:munin/providers/bangumi/BangumiCookieService.dart';
import 'package:munin/providers/bangumi/BangumiOauthService.dart';
import 'package:munin/providers/storage/SecureStorageService.dart';
import 'package:munin/providers/storage/SharedPreferenceService.dart';
import 'package:munin/providers/util/RetryableHttpClient.dart';
import 'package:munin/shared/injector/injector.dart';

class HttpTestHelper {
  final BangumiCookieService cookieService;
  final BangumiOauthService oauthService;

  HttpTestHelper(this.cookieService, this.oauthService);
}

Future<HttpTestHelper> initializeHttpTestHelper() async {
  File file = File('../test/integration/http/config.json'); // (1)
  Map credentials = jsonDecode(await file.readAsString());
  var bangumiCookieCredentials = BangumiCookieCredentials.fromJson(
      jsonEncode(credentials[bangumiCookieCredentialsKey]));

  var dio = createDioForBangumiCookieService(
      bangumiCookieCredentials, CookieJar(),
      bangumiHostForDio: 'bangumi.tv');

  dio.interceptors.add(RetryInterceptor(dio: dio, logger: Logger('dio')));

  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  var cookieService = BangumiCookieService(
    dio: dio,
    bangumiCookieCredential: bangumiCookieCredentials,
    secureStorageService: MockSecureStorageService(),
  );
  var oauthService = BangumiOauthService(
    cookieClient: MockBangumiCookieService(),
    serializedBangumiOauthCredentials:
        jsonEncode(credentials[bangumiOauthCredentialsKey]),
    secureStorageService: MockSecureStorageService(),
    oauthHttpClient: RetryableHttpClient(http.Client(), retries: 3),
    identifier: credentials['bangumiOauthClientIdentifier'],
    secret: credentials['bangumiOauthClientSecret'],
  );

  return HttpTestHelper(cookieService, oauthService);
}

class MockSecureStorageService extends Mock implements SecureStorageService {}

class MockBangumiCookieService extends Mock implements BangumiCookieService {}

class MockSharedPreferenceService extends Mock
    implements SharedPreferenceService {}
