// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetTimelineRequest.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GetTimelineRequest> _$getTimelineRequestSerializer =
    new _$GetTimelineRequestSerializer();

class _$GetTimelineRequestSerializer
    implements StructuredSerializer<GetTimelineRequest> {
  @override
  final Iterable<Type> types = const [GetTimelineRequest, _$GetTimelineRequest];
  @override
  final String wireName = 'GetTimelineRequest';

  @override
  Iterable serialize(Serializers serializers, GetTimelineRequest object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'timelineSource',
      serializers.serialize(object.timelineSource,
          specifiedType: const FullType(TimelineSource)),
      'timelineCategoryFilter',
      serializers.serialize(object.timelineCategoryFilter,
          specifiedType: const FullType(TimelineCategoryFilter)),
    ];
    if (object.username != null) {
      result
        ..add('username')
        ..add(serializers.serialize(object.username,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GetTimelineRequest deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GetTimelineRequestBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'timelineSource':
          result.timelineSource = serializers.deserialize(value,
              specifiedType: const FullType(TimelineSource)) as TimelineSource;
          break;
        case 'timelineCategoryFilter':
          result.timelineCategoryFilter = serializers.deserialize(value,
                  specifiedType: const FullType(TimelineCategoryFilter))
              as TimelineCategoryFilter;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GetTimelineRequest extends GetTimelineRequest {
  @override
  final TimelineSource timelineSource;
  @override
  final TimelineCategoryFilter timelineCategoryFilter;
  @override
  final String username;
  String __chineseName;

  factory _$GetTimelineRequest(
          [void Function(GetTimelineRequestBuilder) updates]) =>
      (new GetTimelineRequestBuilder()..update(updates)).build();

  _$GetTimelineRequest._(
      {this.timelineSource, this.timelineCategoryFilter, this.username})
      : super._() {
    if (timelineSource == null) {
      throw new BuiltValueNullFieldError(
          'GetTimelineRequest', 'timelineSource');
    }
    if (timelineCategoryFilter == null) {
      throw new BuiltValueNullFieldError(
          'GetTimelineRequest', 'timelineCategoryFilter');
    }
  }

  @override
  String get chineseName => __chineseName ??= super.chineseName;

  @override
  GetTimelineRequest rebuild(
          void Function(GetTimelineRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetTimelineRequestBuilder toBuilder() =>
      new GetTimelineRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetTimelineRequest &&
        timelineSource == other.timelineSource &&
        timelineCategoryFilter == other.timelineCategoryFilter &&
        username == other.username;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, timelineSource.hashCode), timelineCategoryFilter.hashCode),
        username.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GetTimelineRequest')
          ..add('timelineSource', timelineSource)
          ..add('timelineCategoryFilter', timelineCategoryFilter)
          ..add('username', username))
        .toString();
  }
}

class GetTimelineRequestBuilder
    implements Builder<GetTimelineRequest, GetTimelineRequestBuilder> {
  _$GetTimelineRequest _$v;

  TimelineSource _timelineSource;
  TimelineSource get timelineSource => _$this._timelineSource;
  set timelineSource(TimelineSource timelineSource) =>
      _$this._timelineSource = timelineSource;

  TimelineCategoryFilter _timelineCategoryFilter;
  TimelineCategoryFilter get timelineCategoryFilter =>
      _$this._timelineCategoryFilter;
  set timelineCategoryFilter(TimelineCategoryFilter timelineCategoryFilter) =>
      _$this._timelineCategoryFilter = timelineCategoryFilter;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  GetTimelineRequestBuilder();

  GetTimelineRequestBuilder get _$this {
    if (_$v != null) {
      _timelineSource = _$v.timelineSource;
      _timelineCategoryFilter = _$v.timelineCategoryFilter;
      _username = _$v.username;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetTimelineRequest other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$GetTimelineRequest;
  }

  @override
  void update(void Function(GetTimelineRequestBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GetTimelineRequest build() {
    final _$result = _$v ??
        new _$GetTimelineRequest._(
            timelineSource: timelineSource,
            timelineCategoryFilter: timelineCategoryFilter,
            username: username);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
