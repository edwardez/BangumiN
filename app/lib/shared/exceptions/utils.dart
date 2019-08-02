import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:munin/config/application.dart';
import 'package:munin/shared/exceptions/exceptions.dart';
import 'package:quiver/core.dart';

const _networkErrorLabel = '网络连接错误';

/// Formats Dio error, or returns [Optional.absent()] if the formatted message
/// cannot be understood.
Optional<String> formatDioErrorMessage(DioError dioError) {
  if (dioError.type == DioErrorType.CONNECT_TIMEOUT ||
      dioError.type == DioErrorType.RECEIVE_TIMEOUT ||
      dioError.type == DioErrorType.SEND_TIMEOUT) {
    return Optional.of('请求超时');
  }

  if (dioError.type == DioErrorType.DEFAULT &&
      dioError.error is SocketException) {
    return Optional.of(_networkErrorLabel);
  }

  return Optional.absent();
}

String formatErrorMessage(Object error,
    {String fallbackErrorMessage = '出现了错误'}) {
  String errorMessage;

  // [MuninException] should always have a human-readable message.
  if (error is MuninException) {
    errorMessage = error.message ?? fallbackErrorMessage;
  } else if (error is DioError) {
    final maybeReadableMessage = formatDioErrorMessage(error);

    if (maybeReadableMessage.isPresent) {
      errorMessage = maybeReadableMessage.value;
    }
  } else if (error is SocketException) {
    errorMessage = _networkErrorLabel;
  }

  errorMessage ??= fallbackErrorMessage;

  if (Application.environmentValue.environmentType ==
      EnvironmentType.Development) {
    String devErrorMessage = error?.toString() ?? 'null';
    return 'Error occurred.\n'
        'The original error is: $devErrorMessage.\n'
        'Formatted error is $errorMessage';
  } else {
    return errorMessage;
  }
}

reportError(dynamic error, {
  StackTrace stack,
  DiagnosticsNode context,
}) {
  FlutterError.reportError(FlutterErrorDetails(
      exception: error, stack: stack ??= StackTrace.current, context: context));
}
