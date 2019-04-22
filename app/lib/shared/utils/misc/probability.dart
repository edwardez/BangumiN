import 'dart:math' as math;

import 'package:munin/shared/exceptions/exceptions.dart';

/// Mocks exception and throws an [GeneralUnknownException] by default with
/// a 50% chance and a delay
/// failurePercentage must be between 0 and 100(both inclusive)
throwExceptionAtPercentage<T>([int percentage = 50, T error]) {
  assert(percentage >= 0 && percentage <= 100);
  error ??= GeneralUnknownException('Unknown Error') as T;

  if (returnsTrueAtPercentage(percentage)) {
    throw error;
  }
}

/// Mocks exception and throws an [GeneralUnknownException] by default with
/// a 50% chance and a delay
/// failurePercentage must be between 0 and 100(both inclusive)
/// It's useful for simulating a http async operation
/// Since it's an `async` function, await must be used accordingly if needed
throwExceptionAtPercentageWithDelay<T>(
    {int percentage = 50, T error, delaySeconds = 0}) async {
  assert(percentage >= 0 && percentage <= 100);
  error ??= GeneralUnknownException('Unknown Error') as T;

  if (delaySeconds >= 0) {
    await Future.delayed(Duration(seconds: delaySeconds));
  }

  if (returnsTrueAtPercentage(percentage)) {
    throw error;
  }
}

/// Returns true with a [percentage] chance, by default [percentage] is 50
/// [percentage] must be between 0 and 100
bool returnsTrueAtPercentage([int percentage = 50]) {
  assert(percentage >= 0 && percentage <= 100);

  int maxNumber = 100;

  /// nextInt generates from 0, inclusive, to [max], exclusive, hence +1
  int randomNumber = math.Random().nextInt(maxNumber) + 1;

  if (randomNumber < percentage) {
    return true;
  }

  return false;
}
