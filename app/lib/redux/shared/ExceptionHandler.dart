import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:munin/shared/exceptions/exceptions.dart';
import 'package:oauth2/oauth2.dart';

enum GeneralExceptionHandlerResult {
  /// This exception has been handled by generalExceptionHandler, no further action
  /// is needed
  Success,

  /// generalExceptionHandler decides this situation can be silently skipped
  Skipped,

  /// Caller is responsible for initiating a re-authentication
  RequiresReAuthentication,

  /// generalExceptionHandler is unable to handle this situation
  Unknown,
}

bool isNeedsReAuthenticationException(dynamic error) {
  /// Oauth-based authentication errors
  if (error is AuthorizationException || error is ExpirationException) {
    return true;
  }

  /// Cookie-based authentication errors
  if (error is AuthenticationExpiredException) {
    return true;
  }

  if (error is DioError && error.error is AuthenticationExpiredException) {
    return true;
  }

  return false;
}

Future<GeneralExceptionHandlerResult> generalExceptionHandler(
  dynamic error, {
  @required BuildContext context,
}) async {
  bool needsReAuthentication = isNeedsReAuthenticationException(error);
  if (needsReAuthentication) {
    return await showDialog<GeneralExceptionHandlerResult>(
        context: context,
        barrierDismissible: false,
        builder: (innerContext) {
          return AlertDialog(
            title: Text('认证已过期或出错'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('不需要退出登录，直接退出登录会清空所有设置。'),
                Text('请点击下方的"重新认证"以刷新Bangumi授权。'),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('暂不认证'),
                onPressed: () {
                  Navigator.of(context)
                      .pop(GeneralExceptionHandlerResult.Skipped);
                },
              ),
              FlatButton(
                child: Text('重新认证'),
                onPressed: () {
                  Navigator.of(context).pop(
                      GeneralExceptionHandlerResult.RequiresReAuthentication);
                },
              )
            ],
          );
        });
  }


  return GeneralExceptionHandlerResult.Unknown;
}
