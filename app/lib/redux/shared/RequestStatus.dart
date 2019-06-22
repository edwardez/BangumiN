import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'RequestStatus.g.dart';

class RequestStatus extends EnumClass {
  /// Request has not started yet
  static const RequestStatus Initial = _$Initial;

  static const RequestStatus Loading = _$Loading;
  static const RequestStatus Success = _$Success;

  /// New exception/error should be added to [isException]
  static const RequestStatus TimeoutException = _$Timeout;
  static const RequestStatus UnknownException = _$UnknownError;

  /// If new status is a exception/error, please add it here
  @memoized
  bool get isException {
    return this == RequestStatus.TimeoutException ||
        this == RequestStatus.UnknownException;
  }

  /// Checks whether next request can be initialized.
  @memoized
  bool get canInitializeNextRequest {
    return this == RequestStatus.Initial || this == RequestStatus.Success;
  }

  const RequestStatus._(String name) : super(name);

  static BuiltSet<RequestStatus> get values => _$values;

  static RequestStatus valueOf(String name) => _$valueOf(name);

  static Serializer<RequestStatus> get serializer => _$requestStatusSerializer;
}
