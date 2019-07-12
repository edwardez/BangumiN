import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:munin/config/application.dart';
import 'package:munin/shared/exceptions/exceptions.dart';
import 'package:quiver/core.dart';

/// Formats Dio error, or returns [Optional.absent()] if the formatted message
/// cannot be understood.
Optional<String> formatDioErrorMessage(DioError dioError) {
  if (dioError.type == DioErrorType.CONNECT_TIMEOUT ||
      dioError.type == DioErrorType.RECEIVE_TIMEOUT ||
      dioError.type == DioErrorType.SEND_TIMEOUT) {
    return Optional.of('请求超时');
  }

  return Optional.absent();
}

String formatErrorMessage(Object error,
    {String fallbackErrorMessage = '出现了错误'}) {
  if (Application.environmentValue.environmentType ==
      EnvironmentType.Development) {
    return error?.toString() ?? '$fallbackErrorMessage且error为null';
  }

  // [MuninException] should always have a human-readable message.
  if (error is MuninException) {
    return error.message ?? fallbackErrorMessage;
  }

  if (error is DioError) {
    final maybeReadableMessage = formatDioErrorMessage(error);

    if (maybeReadableMessage.isPresent) {
      return maybeReadableMessage.value;
    }
  }

  return fallbackErrorMessage;
}

reportError(dynamic error, {
  StackTrace stack,
  DiagnosticsNode context,
}) {
  FlutterError.reportError(FlutterErrorDetails(
      exception: error, stack: stack ??= StackTrace.current, context: context));
}
