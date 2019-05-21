// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TimelinePreview.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TimelinePreview> _$timelinePreviewSerializer =
    new _$TimelinePreviewSerializer();

class _$TimelinePreviewSerializer
    implements StructuredSerializer<TimelinePreview> {
  @override
  final Iterable<Type> types = const [TimelinePreview, _$TimelinePreview];
  @override
  final String wireName = 'TimelinePreview';

  @override
  Iterable serialize(Serializers serializers, TimelinePreview object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
      'userUpdatedAt',
      serializers.serialize(object.userUpdatedAt,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  TimelinePreview deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TimelinePreviewBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'userUpdatedAt':
          result.userUpdatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$TimelinePreview extends TimelinePreview {
  @override
  final String content;
  @override
  final int userUpdatedAt;

  factory _$TimelinePreview([void Function(TimelinePreviewBuilder) updates]) =>
      (new TimelinePreviewBuilder()..update(updates)).build();

  _$TimelinePreview._({this.content, this.userUpdatedAt}) : super._() {
    if (content == null) {
      throw new BuiltValueNullFieldError('TimelinePreview', 'content');
    }
    if (userUpdatedAt == null) {
      throw new BuiltValueNullFieldError('TimelinePreview', 'userUpdatedAt');
    }
  }

  @override
  TimelinePreview rebuild(void Function(TimelinePreviewBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TimelinePreviewBuilder toBuilder() =>
      new TimelinePreviewBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TimelinePreview &&
        content == other.content &&
        userUpdatedAt == other.userUpdatedAt;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, content.hashCode), userUpdatedAt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TimelinePreview')
          ..add('content', content)
          ..add('userUpdatedAt', userUpdatedAt))
        .toString();
  }
}

class TimelinePreviewBuilder
    implements Builder<TimelinePreview, TimelinePreviewBuilder> {
  _$TimelinePreview _$v;

  String _content;
  String get content => _$this._content;
  set content(String content) => _$this._content = content;

  int _userUpdatedAt;
  int get userUpdatedAt => _$this._userUpdatedAt;
  set userUpdatedAt(int userUpdatedAt) => _$this._userUpdatedAt = userUpdatedAt;

  TimelinePreviewBuilder();

  TimelinePreviewBuilder get _$this {
    if (_$v != null) {
      _content = _$v.content;
      _userUpdatedAt = _$v.userUpdatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TimelinePreview other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TimelinePreview;
  }

  @override
  void update(void Function(TimelinePreviewBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TimelinePreview build() {
    final _$result = _$v ??
        new _$TimelinePreview._(content: content, userUpdatedAt: userUpdatedAt);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
