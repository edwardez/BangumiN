import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/BangumiUserBaic.dart';

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
  final String failureMessage;

  OAuthLoginFailure(this.context, this.failureMessage);
}

class OAuthLoginSuccess {
  final BangumiUserBasic userInfo;

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
