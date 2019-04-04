import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'LoadingStatus.g.dart';

class LoadingStatus extends EnumClass {
  /// we use a 'trick' here, bangumi will return all results if type is not in their list, so we use -1 to indicate all type
  static const LoadingStatus Initial = _$Initial;
  static const LoadingStatus Loading = _$Loading;
  static const LoadingStatus Success = _$Success;
  static const LoadingStatus TimeoutException = _$Timeout;
  static const LoadingStatus UnknownException = _$UnknownError;

  /// If new status is a exception/error, please add it here
  @memoized
  bool get isException {
    return this == LoadingStatus.TimeoutException ||
        this == LoadingStatus.UnknownException;
  }

  const LoadingStatus._(String name) : super(name);

  static BuiltSet<LoadingStatus> get values => _$values;

  static LoadingStatus valueOf(String name) => _$valueOf(name);

  static Serializer<LoadingStatus> get serializer => _$loadingStatusSerializer;
}
