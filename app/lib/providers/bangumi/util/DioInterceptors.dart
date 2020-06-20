import 'package:dio/dio.dart';
import 'package:munin/shared/exceptions/exceptions.dart';

class BangumiCookieExpirationCheckInterceptor extends InterceptorsWrapper {
  /// [DateTime] that current cookie should expire.
  DateTime _expiresOn;

  set expiresOn(DateTime expiresOn) {
    _expiresOn = expiresOn;
  }

  BangumiCookieExpirationCheckInterceptor({DateTime expiresOn}) {
    this._expiresOn = expiresOn;
  }

  @override
  Future onRequest(RequestOptions options) {
    if (_expiresOn != null && DateTime.now().isAfter(_expiresOn)) {
      throw AuthenticationExpiredException('认证已过期');
    }

    return super.onRequest(options);
  }
}
