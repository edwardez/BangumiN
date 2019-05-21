class BangumiOauthCredentials {
  //  hard-code some pre-defined values for readability
  static final String tokenEndpoint = 'https://bgm.tv/oauth/access_token';

  String accessToken;
  String refreshToken;
  int expiration;

  BangumiOauthCredentials.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'],
        refreshToken = json['accessToken'],
        expiration = json['accessToken'];

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'expiration': expiration,
        'tokenEndpoint': tokenEndpoint,
      };
}
