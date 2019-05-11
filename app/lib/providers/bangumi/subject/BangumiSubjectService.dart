import 'dart:convert' show json;

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:http/http.dart' as Http;
import 'package:meta/meta.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/collection/SubjectCollectionInfo.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/providers/bangumi/BangumiCookieClient.dart';
import 'package:munin/providers/bangumi/BangumiOauthClient.dart';
import 'package:munin/providers/bangumi/subject/parser/SubjectParser.dart';
import 'package:munin/shared/exceptions/exceptions.dart';
import 'package:quiver/strings.dart';

// A Bangumi subject service that handles subject-related http requests
class BangumiSubjectService {
  BangumiCookieClient cookieClient;
  BangumiOauthClient oauthClient;

  BangumiSubjectService(
      {@required this.cookieClient, @required this.oauthClient})
      : assert(cookieClient != null),
        assert(oauthClient != null);

  // get bangumi subject info through parsing html response
  Future<BangumiSubject> getSubjectFromHttp({int subjectId}) async {
    Dio.Response<String> response = await cookieClient.dio.get<String>(
        '/subject/$subjectId');

    BangumiSubject subject = SubjectParser().process(response.data);

    return subject;
  }

  // get a bangumi user collection info through api
  Future<SubjectCollectionInfo> getCollectionInfo(int subjectId) async {
    Http.Response response = await oauthClient.client.get(''
        'https://${Application.environmentValue
        .bangumiApiHost}/collection/$subjectId');

    SubjectCollectionInfo subjectCollectionInfo;
    if (response.statusCode == 200) {
      var decodedBody = json.decode(response.body);
      if (decodedBody['code'] == 400) {
        throw GeneralUnknownException(
            '出现了未知错误: Bangumi此刻无法响应请求');
      } else if (decodedBody['code'] == null) {
        subjectCollectionInfo = SubjectCollectionInfo.fromJson(response.body);
        BuiltList<String> tags = subjectCollectionInfo.tags;

        /// if tags is null, Bangumi will returns a list with a empty string(i.e. [""]) instead of
        /// a empty list or null. Thus this extra trick is needed to clean
        /// up the data
        if (tags.length == 1 && isEmpty(tags[0])) {
          subjectCollectionInfo =
              subjectCollectionInfo.rebuild((b) => b..tags.replace([]));
        }
      } else {
        /// otherwise, Munin cannot understand this response
        throw BangumiResponseIncomprehensibleException(
            '出现了未知错误: 从Bangumi返回了无法处理的数据');
      }
    } else {
      throw GeneralUnknownException(
          '出现了未知错误: Bangumi此刻无法响应请求');
    }

    return subjectCollectionInfo;
  }

  // update collection info info through api
  Future<SubjectCollectionInfo> updateCollectionInfoRequest(int subjectId,
      SubjectCollectionInfo collectionUpdateRequest) async {
    Map<String, String> formData = {};
    String tagSeparator = ' ';
    formData['status'] = collectionUpdateRequest.status.type.wiredName;
    formData['comment'] = collectionUpdateRequest.comment;
    formData['tags'] = collectionUpdateRequest.tags.join(tagSeparator);
    formData['rating'] = collectionUpdateRequest.rating.toString();

    /// For some reason, bangumi uses `private` in Response and `privacy` in Request
    /// It sounds like an undocumented mistake that might be corrected in the
    /// future at any time without advanced inform
    /// sending both values just as an extra guard
    /// This trick might result in error if Bangumi guards their server to reject
    /// a request if it contains unknown parameter
    formData['private'] = collectionUpdateRequest.private.toString();
    formData['privacy'] = formData['private'];

    Http.Response response = await oauthClient.client.post(''
        'https://${Application.environmentValue
        .bangumiApiHost}/collection/$subjectId/update',
        body: formData
    );

    SubjectCollectionInfo subjectCollectionInfo;
    if (response.statusCode == 200) {
      var decodedBody = json.decode(response.body);
      if (decodedBody['code'] == null) {
        subjectCollectionInfo = SubjectCollectionInfo.fromJson(response.body);
      } else {
        /// otherwise, Munin cannot understand this response
        throw BangumiResponseIncomprehensibleException(
            '出现了未知错误: 从Bangumi返回了无法处理的数据');
      }
    }

    return subjectCollectionInfo;
  }
}
