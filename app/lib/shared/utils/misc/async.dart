import 'dart:async';

Completer<T> immediateFinishCompleter<T>() {
  Completer<T> completer = Completer<T>();
  completer.complete();
  return completer;
}

/// Completes [completer] if it's not completed it.
///
/// It's useful as a sanity check to complete dangling completer since Calling
/// [Completer.complete] or [Completer.completeError] must be done at most once.
completeDanglingCompleter(Completer completer) {
  if (completer != null && !completer.isCompleted) {
    completer.complete();
  }
}