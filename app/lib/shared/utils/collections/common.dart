import 'dart:collection';

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

/// Safely access first element without throwing exception, inspired by firstOrNull in kotlin
T firstOrNullInNestedBuiltList<T>(BuiltList<BuiltList<T>> builtList) {
  /// it's guaranteed by built_value that if builtList is not empty, it must not contain null
  /// no need to check whether first is null
  if (builtList == null || builtList.isEmpty || builtList.first.isEmpty) {
    return null;
  }

  return builtList.first.first;
}

/// Safely access last element without throwing exception, inspired by lastOrNull in kotlin
T lastOrNullInIterable<T>(Iterable<T> iterable) {
  if (iterable == null || iterable.isEmpty) {
    return null;
  }

  return iterable.last;
}

/// exception safe last element accessor, inspired by lastOrNull in kotlin
lastOrNullInNestedBuiltList<T>(BuiltList<BuiltList<T>> builtList) {
  if (builtList == null || builtList.isEmpty || builtList.last.isEmpty) {
    return null;
  }

  return builtList.last.last;
}

/// Put a new [K, V] pair into the [orderedHashMap] if it doesn't exist
/// otherwise, move the existing one to the tail of the [orderedHashMap]
/// It is an in-place operation
/// Note: it only works if the map is ordered(i.e. [LinkedHashMap])
void putOrMoveToLastInMap<K, V>(Map<K, V> orderedHashMap, K newKey,
    V newValue) {
  if (orderedHashMap.containsKey(newKey)) {
    orderedHashMap.remove(newKey);
  }

  orderedHashMap[newKey] = newValue;
}

/// Put a new [K, V] pair into the [orderedHashSet] if it doesn't exist
/// otherwise, move the existing one to the tail of the [orderedHashSet]
/// It is an in-place operation
/// Note: it only works if the set is ordered(i.e. [LinkedHashSet])
void putOrMoveToLastInSet<K>(Set<K> orderedHashSet, K newValue) {
  if (orderedHashSet.contains(newValue)) {
    orderedHashSet.remove(newValue);
  }

  orderedHashSet.add(newValue);
}
