import 'dart:async';

Completer<T> immediateFinishCompleter<T>() {
  Completer<T> completer = Completer<T>();
  completer.complete();
  return completer;
}
