/// An abstract exception interface, all munin exceptions should implement it.
abstract class MuninException implements Exception {
  final String message;

  MuninException._(this.message);
}

/// Exception that signals authentication has failed
class AuthenticationFailedException implements MuninException {
  /// Message describing the problem. */
  final message;

  AuthenticationFailedException(this.message);

  @override
  String toString() {
    return 'AuthenticationFailedException{message: $message}';
  }
}

/// Exception that signals authentication has expired
class AuthenticationExpiredException implements MuninException {
  /// Message describing the problem. */
  final message;

  AuthenticationExpiredException(this.message);

  @override
  String toString() {
    return 'AuthenticationExpiredException{message: $message}';
  }
}

/// Exception when Bangumi returns a response that cannot be understood by munin
class BangumiResponseIncomprehensibleException implements MuninException {
  /// Message describing the problem. */
  final message;

  BangumiResponseIncomprehensibleException(
      [this.message = '出现了未知错误: 从Bangumi返回了无法处理的数据']);

  @override
  String toString() {
    return 'BangumiResponseIncomprehensibleException{message: $message}';
  }
}

class BangumiRefreshTokenInvalidException implements MuninException {
  /// Message describing the problem. */
  final message;

  BangumiRefreshTokenInvalidException(
      [this.message = 'Bangumi返回了一个和用户资料不匹配的refresh token']);

  @override
  String toString() {
    return 'BangumiRefreshTokenInvalidException{message: $message}';
  }
}

class BangumiResourceNotFoundException implements MuninException {
  /// Message describing the problem. */
  final message;

  BangumiResourceNotFoundException([this.message = '未找到资源']);

  @override
  String toString() {
    return 'BangumiResourceNotFoundException{message: $message}';
  }
}

class BangumiUnauthorizedAccessException implements MuninException {
  /// Message describing the problem. */
  final message;

  BangumiUnauthorizedAccessException([this.message = '没有权限访问']);

  @override
  String toString() {
    return 'BangumiResourceNotFoundException{message: $message}';
  }
}

/// An General UnknownException
class GeneralUnknownException implements MuninException {
  /// Message describing the problem. */
  final message;

  GeneralUnknownException(this.message);

  @override
  String toString() {
    return 'GeneralUnknownException{message: $message}';
  }
}
