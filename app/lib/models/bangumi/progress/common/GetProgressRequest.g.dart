// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetProgressRequest.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GetProgressRequest> _$getProgressRequestSerializer =
    new _$GetProgressRequestSerializer();

class _$GetProgressRequestSerializer
    implements StructuredSerializer<GetProgressRequest> {
  @override
  final Iterable<Type> types = const [GetProgressRequest, _$GetProgressRequest];
  @override
  final String wireName = 'GetProgressRequest';

  @override
  Iterable serialize(Serializers serializers, GetProgressRequest object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'requestedSubjectTypes',
      serializers.serialize(object.requestedSubjectTypes,
          specifiedType:
              const FullType(BuiltSet, const [const FullType(SubjectType)])),
    ];

    return result;
  }

  @override
  GetProgressRequest deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GetProgressRequestBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'requestedSubjectTypes':
          result.requestedSubjectTypes.replace(serializers.deserialize(value,
              specifiedType: const FullType(
                  BuiltSet, const [const FullType(SubjectType)])) as BuiltSet);
          break;
      }
    }

    return result.build();
  }
}

class _$GetProgressRequest extends GetProgressRequest {
  @override
  final BuiltSet<SubjectType> requestedSubjectTypes;
  String __chineseName;
  int __pageIndex;

  factory _$GetProgressRequest(
          [void Function(GetProgressRequestBuilder) updates]) =>
      (new GetProgressRequestBuilder()..update(updates)).build();

  _$GetProgressRequest._({this.requestedSubjectTypes}) : super._() {
    if (requestedSubjectTypes == null) {
      throw new BuiltValueNullFieldError(
          'GetProgressRequest', 'requestedSubjectTypes');
    }
  }

  @override
  String get chineseName => __chineseName ??= super.chineseName;

  @override
  int get pageIndex => __pageIndex ??= super.pageIndex;

  @override
  GetProgressRequest rebuild(
          void Function(GetProgressRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetProgressRequestBuilder toBuilder() =>
      new GetProgressRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetProgressRequest &&
        requestedSubjectTypes == other.requestedSubjectTypes;
  }

  @override
  int get hashCode {
    return $jf($jc(0, requestedSubjectTypes.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GetProgressRequest')
          ..add('requestedSubjectTypes', requestedSubjectTypes))
        .toString();
  }
}

class GetProgressRequestBuilder
    implements Builder<GetProgressRequest, GetProgressRequestBuilder> {
  _$GetProgressRequest _$v;

  SetBuilder<SubjectType> _requestedSubjectTypes;
  SetBuilder<SubjectType> get requestedSubjectTypes =>
      _$this._requestedSubjectTypes ??= new SetBuilder<SubjectType>();
  set requestedSubjectTypes(SetBuilder<SubjectType> requestedSubjectTypes) =>
      _$this._requestedSubjectTypes = requestedSubjectTypes;

  GetProgressRequestBuilder();

  GetProgressRequestBuilder get _$this {
    if (_$v != null) {
      _requestedSubjectTypes = _$v.requestedSubjectTypes?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetProgressRequest other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$GetProgressRequest;
  }

  @override
  void update(void Function(GetProgressRequestBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GetProgressRequest build() {
    _$GetProgressRequest _$result;
    try {
      _$result = _$v ??
          new _$GetProgressRequest._(
              requestedSubjectTypes: requestedSubjectTypes.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'requestedSubjectTypes';
        requestedSubjectTypes.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GetProgressRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
