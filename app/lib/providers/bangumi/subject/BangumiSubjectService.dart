import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:munin/providers/bangumi/BangumiCookieClient.dart';

// A Bangumi subject service that handles subject-related http requests
class BangumiSubjectService {
  BangumiCookieClient cookieClient;

  BangumiSubjectService({@required this.cookieClient})
      : assert(cookieClient != null);

  // get bangumi user basic info through api
  Future<Response<String>> getSubject({int subjectId}) async {
    return cookieClient.dio.get('/subject/$subjectId');
  }
}
