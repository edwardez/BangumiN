import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:munin/providers/storage/SecureStorageService.dart';
import 'package:oauth2/oauth2.dart';

/// A derived oauth client that can persist refreshed credentials
/// Please refer to base Oauth2 client for more details.
class BangumiOauthClient extends Client {
  /// A storage service that's used to persist oauth credentials
  final SecureStorageService secureStorageService;

  BangumiOauthClient(Credentials credentials,
      {@required this.secureStorageService,
      String identifier,
      String secret,
      bool basicAuth = true,
      http.Client httpClient})
      : super(credentials,
            identifier: identifier,
            secret: secret,
            basicAuth: basicAuth,
            httpClient: httpClient);

  @override
  Future<Client> refreshCredentials([List<String> newScopes]) async {
    Client newClient = await super.refreshCredentials(newScopes);
    secureStorageService.persistBangumiOauthCredentials(newClient.credentials);
    debugPrint(
        'Successfully refreshed bangumi oauth credentials, new token expires on ${newClient.credentials.expiration}');
    return newClient;
  }
}
