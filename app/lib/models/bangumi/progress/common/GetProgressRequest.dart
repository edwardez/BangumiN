import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';

part 'GetProgressRequest.g.dart';

abstract class GetProgressRequest
    implements Built<GetProgressRequest, GetProgressRequestBuilder> {
  BuiltSet<SubjectType> get requestedSubjectTypes;

  @memoized
  String get chineseName {
    if (requestedSubjectTypes ==
        BuiltSet<SubjectType>.of(
            [SubjectType.Anime, SubjectType.Real, SubjectType.Book])) {
      return '所有在看';
    }

    assert(requestedSubjectTypes.length == 1);

    return requestedSubjectTypes.first.chineseName;
  }

  GetProgressRequest._();

  factory GetProgressRequest([updates(GetProgressRequestBuilder b)]) =
      _$GetProgressRequest;
}
