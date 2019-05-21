// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FetchTimelineRequest.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FetchTimelineRequest> _$fetchTimelineRequestSerializer =
    new _$FetchTimelineRequestSerializer();

class _$FetchTimelineRequestSerializer
    implements StructuredSerializer<FetchTimelineRequest> {
  @override
  final Iterable<Type> types = const [
    FetchTimelineRequest,
    _$FetchTimelineRequest
  ];
  @override
  final String wireName = 'FetchTimelineRequest';

  @override
  Iterable serialize(Serializers serializers, FetchTimelineRequest object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'timelineSource',
      serializers.serialize(object.timelineSource,
          specifiedType: const FullType(TimelineSource)),
      'timelineCategoryFilter',
      serializers.serialize(object.timelineCategoryFilter,
          specifiedType: const FullType(TimelineCategoryFilter)),
    ];

    return result;
  }

  @override
  FetchTimelineRequest deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FetchTimelineRequestBuilder();

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
      }
    }

    return result.build();
  }
}

class _$FetchTimelineRequest extends FetchTimelineRequest {
  @override
  final TimelineSource timelineSource;
  @override
  final TimelineCategoryFilter timelineCategoryFilter;
  String __chineseName;

  factory _$FetchTimelineRequest(
          [void Function(FetchTimelineRequestBuilder) updates]) =>
      (new FetchTimelineRequestBuilder()..update(updates)).build();

  _$FetchTimelineRequest._({this.timelineSource, this.timelineCategoryFilter})
      : super._() {
    if (timelineSource == null) {
      throw new BuiltValueNullFieldError(
          'FetchTimelineRequest', 'timelineSource');
    }
    if (timelineCategoryFilter == null) {
      throw new BuiltValueNullFieldError(
          'FetchTimelineRequest', 'timelineCategoryFilter');
    }
  }

  @override
  String get chineseName => __chineseName ??= super.chineseName;

  @override
  FetchTimelineRequest rebuild(
          void Function(FetchTimelineRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FetchTimelineRequestBuilder toBuilder() =>
      new FetchTimelineRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FetchTimelineRequest &&
        timelineSource == other.timelineSource &&
        timelineCategoryFilter == other.timelineCategoryFilter;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc(0, timelineSource.hashCode), timelineCategoryFilter.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FetchTimelineRequest')
          ..add('timelineSource', timelineSource)
          ..add('timelineCategoryFilter', timelineCategoryFilter))
        .toString();
  }
}

class FetchTimelineRequestBuilder
    implements Builder<FetchTimelineRequest, FetchTimelineRequestBuilder> {
  _$FetchTimelineRequest _$v;

  TimelineSource _timelineSource;
  TimelineSource get timelineSource => _$this._timelineSource;
  set timelineSource(TimelineSource timelineSource) =>
      _$this._timelineSource = timelineSource;

  TimelineCategoryFilter _timelineCategoryFilter;
  TimelineCategoryFilter get timelineCategoryFilter =>
      _$this._timelineCategoryFilter;
  set timelineCategoryFilter(TimelineCategoryFilter timelineCategoryFilter) =>
      _$this._timelineCategoryFilter = timelineCategoryFilter;

  FetchTimelineRequestBuilder();

  FetchTimelineRequestBuilder get _$this {
    if (_$v != null) {
      _timelineSource = _$v.timelineSource;
      _timelineCategoryFilter = _$v.timelineCategoryFilter;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FetchTimelineRequest other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FetchTimelineRequest;
  }

  @override
  void update(void Function(FetchTimelineRequestBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FetchTimelineRequest build() {
    final _$result = _$v ??
        new _$FetchTimelineRequest._(
            timelineSource: timelineSource,
            timelineCategoryFilter: timelineCategoryFilter);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
