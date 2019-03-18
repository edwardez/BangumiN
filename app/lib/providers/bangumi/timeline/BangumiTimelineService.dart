import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:munin/providers/bangumi/BangumiCookieClient.dart';

// A Bangumi user service that handles user-related http requests and persist relevant info
class BangumiTimelineService {
  BangumiCookieClient cookieClient;

  BangumiTimelineService({@required this.cookieClient})
      : assert(cookieClient != null);

  // get bangumi user basic info through api
  Future<Response<String>> fetchLatestTimeline({int nextPageNum}) async {
    Map<String, dynamic> queryParameters = {'ajax': '1'};

    if (nextPageNum != null) {
      queryParameters['page'] = nextPageNum;
    }

    return cookieClient.dio
        .get('https://bgm.tv/timeline?', queryParameters: queryParameters);

//    var client = new http.Client();
//     return client.get('https://bgm.tv/timeline?&ajax=1&page=$nextPageNum', headers: {
//       'Cookie' : 'chii_auth=${cookieClient.bangumiCookieCredential.authCookie}',
//       'User-Agent': cookieClient.bangumiCookieCredential.userAgent
//     });
  }
}
