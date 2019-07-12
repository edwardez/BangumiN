import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/discussion/thread/common/ThreadType.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'GetThreadRequest.g.dart';

abstract class GetThreadRequest
    implements Built<GetThreadRequest, GetThreadRequestBuilder> {
  ThreadType get threadType;

  /// Id of the thread
  int get id;

  GetThreadRequest._();

  factory GetThreadRequest([void Function(GetThreadRequestBuilder) updates]) =
      _$GetThreadRequest;

  String toJson() {
    return json
        .encode(serializers.serializeWith(GetThreadRequest.serializer, this));
  }

  static GetThreadRequest fromJson(String jsonString) {
    return serializers.deserializeWith(
        GetThreadRequest.serializer, json.decode(jsonString));
  }

  static Serializer<GetThreadRequest> get serializer =>
      _$getThreadRequestSerializer;
}
