import 'package:dio/dio.dart';
import 'package:munin/shared/exceptions/exceptions.dart';

InterceptorsWrapper createBangumiCookieExpirationCheckInterceptor(
    DateTime expiresOn) {
  return InterceptorsWrapper(
    onRequest: (RequestOptions options) {
      if (DateTime.now().isAfter(expiresOn)) {
        throw AuthenticationExpiredException('认证已过期');
      }

      return options;
    },
  );
}
