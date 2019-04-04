import 'dart:math' as math;

import 'package:munin/shared/exceptions/exceptions.dart';

/// Mocks exception and throws an [GeneralUnknownException] by default with
/// a 50% chance
/// failurePercentage must be between 0 and 100(both inclusive)
throwExceptionAtPercentage<T>([int failurePercentage = 50, T error]) {
  assert(failurePercentage >= 0 && failurePercentage <= 100);
  error ??= GeneralUnknownException('Unknown Error') as T;

  int maxNumber = 100;

  /// nextInt generates from 0, inclusive, to [max], exclusive, hence +1
  int randomNumber = math.Random().nextInt(maxNumber) + 1;

  if (randomNumber < failurePercentage) {
    throw error;
  }
}
