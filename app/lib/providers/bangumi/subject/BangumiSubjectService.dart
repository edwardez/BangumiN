import 'dart:convert' show json;

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as Http;
import 'package:meta/meta.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/collection/SubjectCollectionInfo.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/models/bangumi/subject/review/GetSubjectReviewRequest.dart';
import 'package:munin/models/bangumi/subject/review/enum/SubjectReviewMainFilter.dart';
import 'package:munin/providers/bangumi/BangumiCookieService.dart';
import 'package:munin/providers/bangumi/BangumiOauthService.dart';
import 'package:munin/providers/bangumi/subject/parser/SubjectReviewParser.dart';
import 'package:munin/providers/bangumi/subject/parser/isolate.dart';
import 'package:munin/shared/exceptions/exceptions.dart';
import 'package:munin/shared/utils/http/common.dart';
import 'package:quiver/strings.dart';

// A Bangumi subject service that handles subject-related http requests
class BangumiSubjectService {
  BangumiCookieService cookieClient;
  BangumiOauthService oauthClient;

  BangumiSubjectService(
      {@required this.cookieClient, @required this.oauthClient})
      : assert(cookieClient != null),
        assert(oauthClient != null);

  /// Gets bangumi subject info through parsing html response
  Future<BangumiSubject> getSubjectFromHttp({
    @required int subjectId,
    @required BuiltMap<String, MutedUser> mutedUsers,
  }) async {
    Dio.Response<String> response =
        await cookieClient.dio.get<String>('/subject/$subjectId');

    BangumiSubject subject = await compute(processBangumiSubject,
        ParseBangumiSubjectMessage(response.data, mutedUsers));

    return subject;
  }

  /// Gets a bangumi user collection info through api
  Future<SubjectCollectionInfo> getCollectionInfo(int subjectId) async {
    Http.Response response = await oauthClient.client.get(Uri.parse(''
        'https://${Application.bangumiApiHost}/collection/$subjectId'));

    SubjectCollectionInfo subjectCollectionInfo;
    if (response.statusCode == 200) {
      var decodedBody = json.decode(response.body);
      if (decodedBody['code'] == 400) {
        // code = 400 means user has not collected this subject
        // we initialize a dummy new collection here
        subjectCollectionInfo = SubjectCollectionInfo();
      } else if (decodedBody['code'] == null) {
        subjectCollectionInfo = SubjectCollectionInfo.fromJson(response.body);
        BuiltList<String> tags = subjectCollectionInfo.tags;

        // If tags is null, Bangumi will returns a list with a empty string(i.e. [""]) instead of
        // a empty list or null. Thus this extra trick is needed to clean
        // up the data
        if (tags.length == 1 && isEmpty(tags[0])) {
          subjectCollectionInfo =
              subjectCollectionInfo.rebuild((b) => b..tags.replace([]));
        }
      } else {
        // Otherwise, Munin cannot understand this response
        throw BangumiResponseIncomprehensibleException(
            '出现了未知错误: 从Bangumi返回了无法处理的数据');
      }
    } else {
      throw GeneralUnknownException('出现了未知错误: Bangumi此刻无法响应请求');
    }

    return subjectCollectionInfo;
  }

  /// Updates collection info info through api
  Future<SubjectCollectionInfo> updateCollectionInfoRequest(
      int subjectId, SubjectCollectionInfo collectionUpdateRequest) async {
    Map<String, String> formData = {};
    String tagSeparator = ' ';
    formData['status'] = collectionUpdateRequest.status.type.wiredName;
    formData['comment'] = collectionUpdateRequest.comment;
    formData['tags'] = collectionUpdateRequest.tags.join(tagSeparator);
    formData['rating'] = collectionUpdateRequest.rating.toString();

    // For some reason, bangumi uses `private` in Response and `privacy` in Request
    // It sounds like an undocumented mistake that might be corrected in the
    // future at any time without advanced inform
    // sending both values just as an extra guard
    // This trick might result in error if Bangumi guards their server to reject
    // a request if it contains unknown parameter
    formData['private'] = collectionUpdateRequest.private.toString();
    formData['privacy'] = formData['private'];

    Http.Response response = await oauthClient.client.post(
        Uri.parse(''
            'https://${Application
            .bangumiApiHost}/collection/$subjectId/update'),
        body: formData);

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

  /// Deletes a collection on bangumi.
  ///
  /// Throws [GeneralUnknownException] if deletion failed.
  /// Note that since this operation is completed by mocking web page, there is
  /// no good way to verify whether a subject has been deleted other than calling
  /// api and checking collection status.
  Future<void> deleteCollection(int subjectId) async {
    String xsrfToken = await cookieClient.getXsrfToken();
    Map<String, dynamic> queryParameters = {'gh': xsrfToken};

    await cookieClient.dio.get(
      '/subject/$subjectId/remove',
      queryParameters: queryParameters,
    );

    final subjectCollectionInfo = await getCollectionInfo(subjectId);
    if (subjectCollectionInfo.status.type == CollectionStatus.Pristine) {
      return;
    }

    throw GeneralUnknownException('删除收藏失败');
  }

  /// Gets subject reviews from web page.
  ///
  /// [pageNumber] is the page number [getsSubjectReviews] should look for.
  Future<ParsedSubjectReviews> getsSubjectReviews({
    @required int pageNumber,
    @required GetSubjectReviewRequest request,
    @required BuiltMap<String, MutedUser> mutedUsers,
  }) async {
    String path = '/subject/${request.subjectId}';
    Map<String, String> queryParameters = {};

    if (request.mainFilter == SubjectReviewMainFilter.WithNonEmptyComments) {
      path += '/comments';
    } else {
      path += '/${request.mainFilter.wiredNameOnWebPage}';

      if (request.showOnlyFriends) {
        queryParameters['filter'] = 'friends';
      }
    }

    if (pageNumber >= 2) {
      queryParameters['page'] = pageNumber.toString();
    }

    Dio.Response response = await cookieClient.dio.get(
      path,
      queryParameters: queryParameters,
    );

    if (!is2xxCode(response.statusCode)) {
      throw BangumiResponseIncomprehensibleException();
    }

    ParsedSubjectReviews parsedSubjectReviews = await compute(
        processBangumiSubjectReview,
        ParseBangumiSubjectReviewsMessage(
          response.data,
          mutedUsers: mutedUsers,
          requestedPageNumber: pageNumber,
          mainFilter: request.mainFilter,
        ));

    return parsedSubjectReviews;
  }
}
