import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/BangumiUserSmall.dart';
import 'package:munin/providers/storage/SecureStorageService.dart';
import 'package:munin/shared/exceptions/exceptions.dart';
import 'package:oauth2/oauth2.dart';
import 'package:quiver/time.dart';

/// A derived oauth client that can persist refreshed credentials
/// Please refer to base Oauth2 client for more details.
class BangumiOauthClient extends Client {
  static const accessTokenExpirationThreshold = aDay;

  /// Number of time `refreshCredentials` is called to refresh access token
  /// `maxRetriesToRefreshCredentials*(retry setting in http client)` is the final
  /// retry count if all http requests failed with a non-200 code
  static const maxRetriesToRefreshCredentials = 3;

  /// Current authenticated user info
  /// This field might be null after initialization
  BangumiUserSmall currentUser;

  /// A storage service that's used to persist oauth credentials
  final SecureStorageService secureStorageService;

  BangumiOauthClient(
    Credentials credentials, {
    @required this.secureStorageService,
    String identifier,
    String secret,
    bool basicAuth = true,
    http.Client httpClient,
  }) : super(credentials,
            identifier: identifier,
            secret: secret,
            basicAuth: basicAuth,
            httpClient: httpClient);

  bool shouldRefreshAccessToken() {
    /// If `credentials` is null, user is not logged in yet, thus login instead
    /// of refresh is needed
    if (credentials == null) {
      return false;
    }

    bool isAboutToExpire = credentials.expiration
        .subtract(accessTokenExpirationThreshold)
        .isBefore(DateTime.now());
    return isAboutToExpire;
  }

  /// Workaround for a current bug in bangumi api:
  /// Sometimes refresh token returns a totally different user
  /// Validates user info to make sure we are receiving info of current app user
  Future<bool> refreshTokenMatchesAppUser() async {
    http.Response response = await this.post(
        'https://$bangumiMainHost/oauth/token_status');

    /// If code returns non-200, always returns false
    if (response.statusCode != 200) {
      return false;
    }

    var decodedResponse = json.decode(response.body);
    bool isValidRefreshToken = decodedResponse['user_id'] is int &&
        decodedResponse['user_id'] == currentUser?.id;

    if (!isValidRefreshToken) {
      FlutterError.reportError(FlutterErrorDetails(
        exception: BangumiRefreshTokenInvalidException(),
        stack: StackTrace.current,
      ));
      debugPrint(
          'Authenicated bangumi user and current app user doesn\'t match! '
              'Bangumi user id: ${decodedResponse['user_id']}, '
              'app user id: ${currentUser?.id}');
    }

    return isValidRefreshToken;
  }

  @override
  Future<Client> refreshCredentials(
      [List<String> newScopes, triedTimes = 0]) async {
    Client newClient = await super.refreshCredentials(newScopes);
    secureStorageService.persistBangumiOauthCredentials(newClient.credentials);
    bool isValidRefreshToken = await refreshTokenMatchesAppUser();

    /// TODO: figure out a better way to authenticate current user if maximum
    /// number of retry has reached
    if (!isValidRefreshToken && triedTimes <= maxRetriesToRefreshCredentials) {
      debugPrint(
          'Retrying to refresh access token the ${triedTimes + 1} time since returned user info doesn\'t match app user');
      newClient = await refreshCredentials(null, triedTimes + 1);
    }

    if (isValidRefreshToken) {
      debugPrint(
          'Successfully refreshed bangumi oauth credentials, new token expires on ${newClient.credentials.expiration}');
    }

    return newClient;
  }
}
