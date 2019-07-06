import 'package:flutter/cupertino.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/shared/utils/bangumi/RedirectableUrlResolver.dart';
import "package:test/test.dart";

class _Scheme {
  static const Http = 'http';
  static const Https = 'https';
}

void main() {
  group('resolveRedirectableUrl', () {
    const HttpScheme = 'http';
    const HttpsScheme = 'https';

    runFindRedirectableUrlTest({
      @required BangumiContent bangumiContent,
      @required String id,
      String suffix = '',
      String host = 'bgm.tv',
      String scheme = HttpsScheme,
      bool expectedToFindUrl = true,
    }) {
      final expectedBehavior = expectedToFindUrl ? 'can' : 'cannot';
      final url =
          '$scheme://$host/${bangumiContent.webPageRouteName}/$id$suffix';

      test('$expectedBehavior find $url for $bangumiContent', () {
        final expectedResult =
            expectedToFindUrl ? RedirectableUrlInfo(bangumiContent, id) : null;

        expect(resolveRedirectableUrl(url).orNull, expectedResult);
      });
    }

    runFindRedirectableUrlTest(
      id: '1',
      bangumiContent: BangumiContent.Subject,
    );

    runFindRedirectableUrlTest(
      id: 'abc',
      bangumiContent: BangumiContent.Subject,
      expectedToFindUrl: false,
    );

    runFindRedirectableUrlTest(
      id: '1',
      bangumiContent: BangumiContent.SubjectTopic,
    );

    runFindRedirectableUrlTest(
      id: '1',
      bangumiContent: BangumiContent.Episode,
    );

    runFindRedirectableUrlTest(
      id: '1',
      bangumiContent: BangumiContent.User,
    );

    runFindRedirectableUrlTest(
      id: 'abc_12',
      bangumiContent: BangumiContent.User,
      expectedToFindUrl: true,
    );

    runFindRedirectableUrlTest(
      id: '1',
      bangumiContent: BangumiContent.GroupTopic,
    );

    runFindRedirectableUrlTest(
      id: '1',
      suffix: '#post_123',
      bangumiContent: BangumiContent.GroupTopic,
      expectedToFindUrl: false,
    );

    runFindRedirectableUrlTest(
      id: '1',
      bangumiContent: BangumiContent.Blog,
    );
  });
}
