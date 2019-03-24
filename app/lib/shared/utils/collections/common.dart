import 'package:built_collection/built_collection.dart';
import 'package:quiver/collection.dart';

MapBuilder<K, V> newLruMapBuilder<K, V>({maximumSize = 100}) {
  return MapBuilder<K, V>()
    ..withBase(() => LruMap<K, V>(maximumSize: maximumSize));
}

isIterableNullOrEmpty(Iterable iterable) {
  return iterable == null || iterable.isEmpty;
}

isMapNullOrEmpty(Map map) {
  return map == null || map.isEmpty;
}

isBuiltListMultimapNullOrEmpty(BuiltListMultimap map) {
  return map == null || map.isEmpty;
}

/// exception safe first element accessor, inspired by firstOrNull in kotlin
firstOrNullInBuiltList<T>(BuiltList<T> builtList) {
  if (builtList == null || builtList.isEmpty) {
    return null;
  }

  return builtList.first;
}

/// exception safe first element accessor, inspired by firstOrNull in kotlin
firstOrNullInNestedBuiltList<T>(BuiltList<BuiltList<T>> builtList) {
  /// it's guaranteed by built_value that if builtList is not empty, it must not contain null
  /// no need to check whether first is null
  if (builtList == null || builtList.isEmpty || builtList.first.isEmpty) {
    return null;
  }

  return builtList.first.first;
}

/// exception safe last element accessor, inspired by lastOrNull in kotlin
lastOrNullInBuiltList<T>(BuiltList<T> builtList) {
  if (builtList == null || builtList.isEmpty) {
    return null;
  }

  return builtList.last;
}

/// exception safe last element accessor, inspired by lastOrNull in kotlin
lastOrNullInNestedBuiltList<T>(BuiltList<BuiltList<T>> builtList) {
  if (builtList == null || builtList.isEmpty || builtList.last.isEmpty) {
    return null;
  }

  return builtList.last.last;
}
