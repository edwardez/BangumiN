class LoginElapsedTimeEvent {
  static const name = 'login_elapsed_time';
  static const afterPostLoginCredentials =
      'after_post_login_credentials_milliseconds';
  static const afterPostOauthCredentials =
      'after_post_oauth_credentials_milliseconds';
  static const afterGetUserProfile = 'after_get_user_profile_milliseconds';
  static const totalMilliSeconds = 'total_millisecondss';
}

class LoginErrorEvent {
  static const name = 'login_error';
}
