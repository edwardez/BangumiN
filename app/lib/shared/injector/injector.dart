import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:munin/providers/bangumi/BangumiCookieClient.dart';
import 'package:munin/providers/bangumi/BangumiOauthClient.dart';
import 'package:munin/providers/bangumi/BangumiUserService.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> injector(GetIt getIt) async {
  final FlutterSecureStorage secureStorage = new FlutterSecureStorage();
  Map<String, String> credentials = await secureStorage.readAll();
  SharedPreferences preferences = await SharedPreferences.getInstance();

  final BangumiCookieClient _bangumiCookieClient = BangumiCookieClient(
    serializedBangumiCookieCredentials: credentials['bangumiCookieCredentials'],
    secureStorage: secureStorage,
  );

  final String serializedBangumiOauthCredentials =
      credentials['bangumiOauthCredentials'];
  final BangumiOauthClient _bangumiOauthClient = BangumiOauthClient(
    cookieClient: _bangumiCookieClient,
    serializedBangumiOauthCredentials: serializedBangumiOauthCredentials,
    secureStorage: secureStorage,
  );

  getIt.registerSingleton<SharedPreferences>(preferences);
  getIt.registerSingleton<FlutterSecureStorage>(secureStorage);
  getIt.registerSingleton<BangumiCookieClient>(_bangumiCookieClient);
  getIt.registerSingleton<BangumiOauthClient>(_bangumiOauthClient);

  final bangumiUserService = BangumiUserService(
      cookieClient: _bangumiCookieClient,
      oauthClient: _bangumiOauthClient,
      sharedPreferences: preferences);
  getIt.registerSingleton<BangumiUserService>(bangumiUserService);

  return;
}
