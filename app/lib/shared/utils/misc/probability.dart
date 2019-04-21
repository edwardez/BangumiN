import 'dart:math' as math;

import 'package:munin/shared/exceptions/exceptions.dart';

/// Mocks exception and throws an [GeneralUnknownException] by default with
/// a 50% chance
/// failurePercentage must be between 0 and 100(both inclusive)
throwExceptionAtPercentage<T>([int failurePercentage = 50, T error]) {
  assert(failurePercentage >= 0 && failurePercentage <= 100);
  error ??= GeneralUnknownException('Unknown Error') as T;

  if (returnsTrueAtPercentage(failurePercentage)) {
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
