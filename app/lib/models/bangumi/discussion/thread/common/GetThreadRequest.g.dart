// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetThreadRequest.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GetThreadRequest> _$getThreadRequestSerializer =
    new _$GetThreadRequestSerializer();

class _$GetThreadRequestSerializer
    implements StructuredSerializer<GetThreadRequest> {
  @override
  final Iterable<Type> types = const [GetThreadRequest, _$GetThreadRequest];
  @override
  final String wireName = 'GetThreadRequest';

  @override
  Iterable serialize(Serializers serializers, GetThreadRequest object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'threadType',
      serializers.serialize(object.threadType,
          specifiedType: const FullType(ThreadType)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GetThreadRequest deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GetThreadRequestBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'threadType':
          result.threadType = serializers.deserialize(value,
              specifiedType: const FullType(ThreadType)) as ThreadType;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GetThreadRequest extends GetThreadRequest {
  @override
  final ThreadType threadType;
  @override
  final int id;

  factory _$GetThreadRequest(
          [void Function(GetThreadRequestBuilder) updates]) =>
      (new GetThreadRequestBuilder()..update(updates)).build();

  _$GetThreadRequest._({this.threadType, this.id}) : super._() {
    if (threadType == null) {
      throw new BuiltValueNullFieldError('GetThreadRequest', 'threadType');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('GetThreadRequest', 'id');
    }
  }

  @override
  GetThreadRequest rebuild(void Function(GetThreadRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetThreadRequestBuilder toBuilder() =>
      new GetThreadRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetThreadRequest &&
        threadType == other.threadType &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, threadType.hashCode), id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GetThreadRequest')
          ..add('threadType', threadType)
          ..add('id', id))
        .toString();
  }
}

class GetThreadRequestBuilder
    implements Builder<GetThreadRequest, GetThreadRequestBuilder> {
  _$GetThreadRequest _$v;

  ThreadType _threadType;

  ThreadType get threadType => _$this._threadType;

  set threadType(ThreadType threadType) => _$this._threadType = threadType;

  int _id;

  int get id => _$this._id;

  set id(int id) => _$this._id = id;

  GetThreadRequestBuilder();

  GetThreadRequestBuilder get _$this {
    if (_$v != null) {
      _threadType = _$v.threadType;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetThreadRequest other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$GetThreadRequest;
  }

  @override
  void update(void Function(GetThreadRequestBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GetThreadRequest build() {
    final _$result =
        _$v ?? new _$GetThreadRequest._(threadType: threadType, id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
