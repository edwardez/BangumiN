import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/BangumiUserSmall.dart';

class LoginPage {
  final BuildContext context;

  LoginPage(this.context);
}

class OAuthLoginRequest {
  final BuildContext context;

  OAuthLoginRequest(this.context);
}

class OAuthLoginCancel {
  final BuildContext context;

  OAuthLoginCancel(this.context);
}

class OAuthLoginFailure {
  final BuildContext context;
  final String message;

  OAuthLoginFailure(this.context, this.message);
}

class OAuthLoginSuccess {
  final BangumiUserSmall userInfo;

  OAuthLoginSuccess(this.userInfo);
}

class LogoutRequest {
  final BuildContext context;

  LogoutRequest(this.context);
}

class LogoutSuccess {
  final BuildContext context;

  LogoutSuccess(this.context);
}

class LogoutFailure {
  final BuildContext context;

  LogoutFailure(this.context);
}
