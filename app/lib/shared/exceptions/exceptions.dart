/// Error thrown when a function is passed an unacceptable argument.
class AuthenticationExpiredException implements Exception {
  /// Message describing the problem. */
  final message;

  AuthenticationExpiredException(this.message);
}
