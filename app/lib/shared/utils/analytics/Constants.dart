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

class InstallUpdatePromptEvent {
  static const name = 'install_critical_update_prompt';
  static const agreeToInstall = 'agree_to_install';
  static const refuseToInstall = 'refuse_to_install';
  static const criticalUpdateVersion = 'critical_update_version';
}
